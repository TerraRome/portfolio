import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_portfolio/main.dart';
import 'package:flutter_portfolio/model/project_model.dart';
import 'package:flutter_portfolio/res/theme_mode.dart';
import 'package:flutter_test/flutter_test.dart';

/// Asset names of every `Image` currently in the tree, unwrapping
/// `ResizeImage` (added by `cacheWidth`).
Set<String> assetNamesOf(WidgetTester tester) {
  return tester
      .widgetList<Image>(find.byType(Image))
      .map((w) {
        final p = w.image is ResizeImage
            ? (w.image as ResizeImage).imageProvider
            : w.image;
        return p is AssetImage ? p.assetName : null;
      })
      .whereType<String>()
      .toSet();
}

void main() {
  test('sortedProjects: live first, every project kept', () {
    final sorted = sortedProjects(projectList);
    expect(sorted.length, projectList.length);
    expect(sorted.take(4).every((p) => p.status == ProjectStatus.live), isTrue);
    expect(sorted.map((p) => p.name).toSet().length, projectList.length);
  });

  // Lays out at mobile/tablet/desktop in both themes, scrolls the full page and
  // opens a case-study modal. Any overflow or missing-theme exception fails.
  for (final size in const [Size(375, 812), Size(768, 900), Size(1440, 900)]) {
    for (final mode in const [ThemeMode.dark, ThemeMode.light]) {
      testWidgets('renders at ${size.width.toInt()} ${mode.name}',
          (tester) async {
        await tester.binding.setSurfaceSize(size);
        themeMode.value = mode;
        await tester.pumpWidget(const PortfolioApp());
        await tester.pump(const Duration(milliseconds: 300));
        expect(tester.takeException(), isNull);

        final page = find
            .byWidgetPredicate(
              (w) => w is Scrollable && w.axisDirection == AxisDirection.down,
            )
            .first;

        await tester.drag(page, const Offset(0, -6000));
        await tester.pump(const Duration(milliseconds: 300));
        expect(tester.takeException(), isNull);

        await tester.drag(page, const Offset(0, 6000));
        await tester.pump(const Duration(milliseconds: 300));

        final caseStudy = find.text('Case study').first;
        await tester.ensureVisible(caseStudy);
        await tester.pump(const Duration(milliseconds: 200));
        await tester.tap(caseStudy);
        await tester.pump(const Duration(milliseconds: 400));
        expect(tester.takeException(), isNull);
        expect(find.text('Problem'), findsOneWidget);

        addTearDown(() => tester.binding.setSurfaceSize(null));
      });
    }
  }

  // The only project with a screenshot must lead the grid and actually load.
  testWidgets('volta card leads and renders its webp', (tester) async {
    expect(sortedProjects(projectList).first.name, contains('Volta'));

    await tester.binding.setSurfaceSize(const Size(1440, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(const PortfolioApp());
    await tester.pump(const Duration(milliseconds: 300));

    final scrollable = find.byType(Scrollable).first;
    for (var i = 0; i < 20; i++) {
      await tester.drag(scrollable, const Offset(0, -400));
      await tester.pump(const Duration(milliseconds: 30));
    }
    expect(tester.takeException(), isNull);

    String? assetNameOf(ImageProvider provider) {
      final p = provider is ResizeImage ? provider.imageProvider : provider;
      return p is AssetImage ? p.assetName : null;
    }

    final assetImage = find.byWidgetPredicate(
      (w) =>
          w is Image &&
          assetNameOf(w.image) == 'assets/images/projects/volta-light.webp',
    );
    expect(assetImage, findsOneWidget);
  });

  // CV-sourced content must actually reach the page.
  testWidgets('experience and education render from profile data',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(1440, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(const PortfolioApp());
    await tester.pump(const Duration(milliseconds: 300));

    final scrollable = find.byType(Scrollable).first;
    for (var i = 0; i < 30; i++) {
      await tester.drag(scrollable, const Offset(0, -400));
      await tester.pump(const Duration(milliseconds: 30));
    }
    expect(tester.takeException(), isNull);
    expect(find.text('PT Code Development Indonesia'), findsOneWidget);
    expect(find.text('PT Permata Solusindo'), findsOneWidget);
    expect(find.text('Universitas Insan Pembangunan'), findsOneWidget);
    expect(find.text('ReCharge — Powerbank Sharing'), findsOneWidget);
  });

  // Volta's case-study modal must show the screenshot evidence strip.
  testWidgets('volta modal shows screenshots', (tester) async {
    await tester.binding.setSurfaceSize(const Size(1440, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(const PortfolioApp());
    await tester.pump(const Duration(milliseconds: 300));

    final scrollable = find.byType(Scrollable).first;
    for (var i = 0; i < 20; i++) {
      await tester.drag(scrollable, const Offset(0, -400));
      await tester.pump(const Duration(milliseconds: 30));
    }

    final volta = projectList.firstWhere((p) => p.name.startsWith('Volta'));
    expect(volta.gallery.length, 9);
    expect(volta.image, 'assets/images/projects/volta-light.webp');

    // No pumpAndSettle: the portrait has a perpetual float animation.
    await tester.ensureVisible(find.text(volta.name));
    await tester.pump(const Duration(milliseconds: 300));
    await tester.tap(find.text(volta.name));
    await tester.pump(const Duration(milliseconds: 400));

    expect(tester.takeException(), isNull);
    expect(find.text('Screens'), findsOneWidget);
    // The strip is a lazy ListView: only built items are in the tree.
    expect(
      assetNamesOf(tester),
      containsAll(volta.gallery.take(5).map((s) => s.asset)),
    );
    for (final shot in volta.gallery.take(5)) {
      expect(find.text(shot.label), findsOneWidget);
    }
  });

  // Volta links out to the live product; only existing links are rendered.
  testWidgets('volta card and modal expose the website link', (tester) async {
    final volta = projectList.firstWhere((p) => p.name.startsWith('Volta'));
    expect(volta.links.single.url, 'https://voltaindonesia.com/');
    expect(
      projectList
          .where((p) => p.name != volta.name)
          .expand((p) => p.links)
          .where((l) => l.url == volta.links.single.url),
      isEmpty,
    );

    await tester.binding.setSurfaceSize(const Size(1440, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(const PortfolioApp());
    await tester.pump(const Duration(milliseconds: 300));

    final scrollable = find.byType(Scrollable).first;
    for (var i = 0; i < 20; i++) {
      await tester.drag(scrollable, const Offset(0, -400));
      await tester.pump(const Duration(milliseconds: 30));
    }

    await tester.ensureVisible(find.text(volta.name));
    await tester.pump(const Duration(milliseconds: 300));
    await tester.tap(find.text(volta.name));
    await tester.pump(const Duration(milliseconds: 400));

    expect(tester.takeException(), isNull);
    expect(find.text('Links'), findsOneWidget);
    expect(find.text('Website'), findsWidgets);
  });

  // Every screenshot referenced by the data must actually be bundled.
  testWidgets('volta gallery assets resolve from the bundle', (tester) async {
    for (final shot in projectList
        .expand((p) => p.gallery)
        .map((s) => s.asset)
        .toSet()) {
      final data = await rootBundle.load(shot);
      expect(data.lengthInBytes, greaterThan(1000), reason: shot);
    }
  });

  // Bilingual layer: the toggle must swap copy without a rebuild exception.
  testWidgets('language toggle switches to Indonesian', (tester) async {
    await tester.binding.setSurfaceSize(const Size(375, 812));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(const PortfolioApp());
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('Mengirim aplikasi mobile sejak 2019.'), findsNothing);
    await tester.tap(find.text('ID'));
    await tester.pump(const Duration(milliseconds: 300));
    expect(tester.takeException(), isNull);
    expect(find.text('Mengirim aplikasi mobile sejak 2019.'), findsOneWidget);

    await tester.tap(find.text('EN'));
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.text('Shipping mobile since 2019.'), findsOneWidget);
  });
}
