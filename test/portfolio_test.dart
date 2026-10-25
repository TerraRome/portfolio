import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_portfolio/main.dart';
import 'package:flutter_portfolio/model/project_model.dart';
import 'package:flutter_portfolio/res/strings.dart';
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
  // `appStrings` and `themeMode` are global notifiers: reset them so a test
  // that toggles either cannot leak state into the next one.
  setUp(() {
    appStrings.value = en;
    themeMode.value = ThemeMode.dark;
  });

  test('sortedProjects: finished work first, every project kept', () {
    final sorted = sortedProjects(projectList);
    expect(sorted.length, projectList.length);
    // Live and demo share the top rank; both are finished builds.
    expect(
      sorted.take(5).every((p) => p.status != ProjectStatus.inProgress),
      isTrue,
    );
    expect(sorted.take(3).every((p) => p.status == ProjectStatus.live), isTrue);
    // At least one demo is featured, so the new work is not buried.
    expect(
      sorted.take(4).any((p) => p.status == ProjectStatus.demo),
      isTrue,
    );
    expect(sorted.map((p) => p.name).toSet().length, projectList.length);
  });

  // Both are finished builds with public source and no product URL, so the
  // badge says Demo and the only link is the repo.
  testWidgets('hot pot and taskflow carry a demo badge and a source link',
      (tester) async {
    for (final prefix in ['Crimson Dragon', 'TaskFlow']) {
      final p = projectList.firstWhere((x) => x.name.startsWith(prefix));
      expect(p.status, ProjectStatus.demo);
      expect(p.image, isNotNull);
      expect(p.gallery.length, greaterThanOrEqualTo(8), reason: p.name);
      expect(p.links.single.label.en, 'Source code');
      expect(p.links.single.url, startsWith('https://github.com/TerraRome/'));
      // Portrait screenshots must be phone-shaped, not square or landscape.
      expect(p.gallery.first.label.en, anyOf('Sign in', 'Onboarding'));
    }

    await tester.binding.setSurfaceSize(const Size(1440, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(const PortfolioApp());
    await tester.pump(const Duration(milliseconds: 300));

    // The grid shows four featured cards; the demos sit behind the toggle.
    final page = find
        .byWidgetPredicate(
          (w) => w is Scrollable && w.axisDirection == AxisDirection.down,
        )
        .first;
    final toggle = find.textContaining('Show all');
    for (var i = 0; i < 20 && toggle.evaluate().isEmpty; i++) {
      await tester.drag(page, const Offset(0, -600));
      await tester.pump(const Duration(milliseconds: 60));
    }
    await tester.ensureVisible(toggle);
    await tester.pump(const Duration(milliseconds: 200));
    await tester.tap(toggle);
    await tester.pump(const Duration(milliseconds: 300));

    for (var i = 0; i < 20 && find.text('DEMO').evaluate().isEmpty; i++) {
      await tester.drag(page, const Offset(0, -600));
      await tester.pump(const Duration(milliseconds: 60));
    }

    expect(find.text('DEMO'), findsWidgets);
    expect(find.text('Source code'), findsWidgets);
    expect(tester.takeException(), isNull);
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

  // ReCharge is the first live project with a screenshot, so it leads the grid.
  testWidgets('recharge card leads and renders its banner', (tester) async {
    expect(sortedProjects(projectList).first.name, contains('ReCharge'));

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
          assetNameOf(w.image) == 'assets/images/projects/recharge/main-image.png',
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

  // SeMoLis ships the same case-study treatment: banner, link, screenshot strip.
  testWidgets('semolis card and modal expose the website link', (tester) async {
    final semolis = projectList.firstWhere((p) => p.name.startsWith('SeMoLis'));
    expect(semolis.links.single.url, 'https://www.sewamotorlistrik.com/');
    expect(semolis.image, 'assets/images/projects/semolis.webp');
    expect(semolis.gallery.length, 6);

    await tester.binding.setSurfaceSize(const Size(1440, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(const PortfolioApp());
    await tester.pump(const Duration(milliseconds: 300));

    final scrollable = find.byType(Scrollable).first;
    for (var i = 0; i < 20; i++) {
      await tester.drag(scrollable, const Offset(0, -400));
      await tester.pump(const Duration(milliseconds: 30));
    }

    // No pumpAndSettle: the portrait has a perpetual float animation.
    await tester.ensureVisible(find.text(semolis.name));
    await tester.pump(const Duration(milliseconds: 300));
    await tester.tap(find.text(semolis.name));
    await tester.pump(const Duration(milliseconds: 400));

    expect(tester.takeException(), isNull);
    expect(find.text('Links'), findsOneWidget);
    expect(
      assetNamesOf(tester),
      containsAll(semolis.gallery.take(5).map((s) => s.asset)),
    );
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
      expect(find.text(shot.label.t), findsOneWidget);
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

  // SigApp has no screenshot: it must fall back to the text panel (its brand
  // name as the monogram), not an empty box or a code snippet.
  testWidgets('sigapp uses the text panel', (tester) async {
    final sigapp = projectList.firstWhere((p) => p.name.startsWith('SigApp'));
    expect(sigapp.image, isNull);
    final brand = sigapp.name.split(' — ').first;
    expect(brand, 'SigApp');

    await tester.binding.setSurfaceSize(const Size(375, 812));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(const PortfolioApp());
    await tester.pump(const Duration(milliseconds: 300));

    final scrollable = find.byType(Scrollable).first;
    for (var i = 0; i < 30; i++) {
      await tester.drag(scrollable, const Offset(0, -400));
      await tester.pump(const Duration(milliseconds: 30));
    }
    expect(tester.takeException(), isNull);
    expect(find.text(brand), findsOneWidget);
    expect(find.text(sigapp.techStack.take(3).join(' · ').toUpperCase()),
        findsOneWidget);
  });

  // Every screenshot referenced by the data must actually be bundled.
  testWidgets('recharge card and modal expose the website link', (tester) async {
    final recharge = projectList.firstWhere((p) => p.name.startsWith('ReCharge'));
    expect(recharge.links.single.url, 'https://www.recharge.id/');
    expect(recharge.image, 'assets/images/projects/recharge/main-image.png');
    expect(recharge.gallery.length, 6);
    expect(recharge.gallery.first.label.en, 'Login');

    await tester.binding.setSurfaceSize(const Size(1440, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(const PortfolioApp());
    await tester.pump(const Duration(milliseconds: 300));

    final scrollable = find.byType(Scrollable).first;
    for (var i = 0; i < 20; i++) {
      await tester.drag(scrollable, const Offset(0, -400));
      await tester.pump(const Duration(milliseconds: 30));
    }

    // No pumpAndSettle: the portrait has a perpetual float animation.
    await tester.ensureVisible(find.text(recharge.name));
    await tester.pump(const Duration(milliseconds: 300));
    await tester.tap(find.text(recharge.name));
    await tester.pump(const Duration(milliseconds: 400));

    expect(tester.takeException(), isNull);
    expect(find.text('Screens'), findsOneWidget);
    expect(find.text('Website'), findsWidgets);
    expect(
      assetNamesOf(tester),
      containsAll(recharge.gallery.take(5).map((s) => s.asset)),
    );
  });

  testWidgets('volta gallery assets resolve from the bundle', (tester) async {
    for (final shot in projectList
        .expand((p) => p.gallery)
        .map((s) => s.asset)
        .toSet()) {
      final data = await rootBundle.load(shot);
      expect(data.lengthInBytes, greaterThan(1000), reason: shot);
    }
  });

  // Project content — not just UI chrome — must follow the language toggle.
  testWidgets('project content switches to Indonesian', (tester) async {
    await tester.binding.setSurfaceSize(const Size(1440, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(const PortfolioApp());
    await tester.pump(const Duration(milliseconds: 300));

    final volta = projectList.firstWhere((p) => p.name.startsWith('Volta'));
    expect(find.text(volta.summary.en), findsWidgets);

    await tester.tap(find.text('ID'));
    await tester.pump(const Duration(milliseconds: 300));
    expect(tester.takeException(), isNull);

    // Card copy is Indonesian now, and the English string is gone.
    expect(find.text(volta.summary.id), findsWidgets);
    expect(find.text(volta.summary.en), findsNothing);

    // Modal copy too, including the screenshot captions.
    final scrollable = find.byType(Scrollable).first;
    for (var i = 0; i < 20; i++) {
      await tester.drag(scrollable, const Offset(0, -400));
      await tester.pump(const Duration(milliseconds: 30));
    }
    await tester.ensureVisible(find.text(volta.name));
    await tester.pump(const Duration(milliseconds: 300));
    await tester.tap(find.text(volta.name));
    await tester.pump(const Duration(milliseconds: 400));

    expect(find.text('Tangkapan layar'), findsOneWidget);
    expect(find.text('Tautan'), findsOneWidget);
    expect(find.text(volta.gallery.first.label.id), findsWidgets);
    expect(find.text('Situs Web'), findsWidgets);

    // The modal is a route over the nav bar, so close it before toggling back.
    await tester.tap(find.byIcon(Icons.close));
    await tester.pump(const Duration(milliseconds: 400));

    await tester.tap(find.text('EN'));
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.text(volta.summary.en), findsWidgets);
    expect(find.text(volta.summary.id), findsNothing);
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
