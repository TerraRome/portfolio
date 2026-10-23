import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_portfolio/model/profile.dart';
import 'package:flutter_portfolio/res/constants.dart';
import 'package:flutter_portfolio/res/strings.dart';
import 'package:flutter_portfolio/res/theme_mode.dart';
import 'package:flutter_portfolio/view%20model/responsive.dart';

import 'actions.dart';

class NavItem {
  const NavItem(this.id, this.label);
  final String id;
  final String label;
}

const double navHeight = 64;

/// Sticky bar: wordmark, section links with scroll-spy, language + theme
/// toggles, CV. Below 1024 the links move into a sheet.
class NavBar extends StatelessWidget {
  const NavBar({
    super.key,
    required this.items,
    required this.active,
    required this.onJump,
    required this.onHome,
  });

  final List<NavItem> items;
  final ValueListenable<String> active;
  final ValueChanged<String> onJump;
  final VoidCallback onHome;

  @override
  Widget build(BuildContext context) {
    final h = context.hermes;
    final s = context.strings;
    final wide = Responsive.isDesktop(context);
    final gutter = wide ? spacingXl : spacingMd;

    return Container(
      height: navHeight,
      decoration: BoxDecoration(
        color: h.surface,
        border: Border(bottom: BorderSide(color: h.border)),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: contentMaxWidth),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: gutter),
            child: Row(
              children: [
                _Wordmark(onTap: onHome, compact: !wide),
                if (wide) ...[
                  const Spacer(),
                  ValueListenableBuilder<String>(
                    valueListenable: active,
                    builder: (context, current, _) => Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        for (final item in items)
                          _NavLink(
                            item: item,
                            isActive: item.id == current,
                            onTap: () => onJump(item.id),
                          ),
                      ],
                    ),
                  ),
                  const Spacer(),
                ] else
                  const Spacer(),
                const _LanguageToggle(),
                const _ThemeToggle(),
                if (wide)
                  Padding(
                    padding: const EdgeInsets.only(left: spacingSm),
                    child: PrimaryButton(
                      label: s.navCv,
                      onTap: () => openUrl(cvUrl),
                    ),
                  )
                else
                  Builder(
                    builder: (context) => IconButton(
                      tooltip: s.menuTooltip,
                      color: h.body,
                      onPressed: () => _openSheet(context),
                      icon: const Icon(Icons.menu, size: 22),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _openSheet(BuildContext context) {
    final h = context.hermes;
    final s = context.strings;
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: h.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusModal)),
      ),
      builder: (sheetContext) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: spacingSm),
          child: ValueListenableBuilder<String>(
            valueListenable: active,
            builder: (context, current, _) => Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (final item in items)
                  TextButton(
                    onPressed: () {
                      Navigator.of(sheetContext).pop();
                      onJump(item.id);
                    },
                    style: TextButton.styleFrom(
                      alignment: Alignment.centerLeft,
                      minimumSize: const Size(0, 52),
                      padding: const EdgeInsets.symmetric(
                        horizontal: spacingLg,
                      ),
                      foregroundColor:
                          item.id == current ? h.primaryInk : h.body,
                      shape: const RoundedRectangleBorder(),
                      textStyle: Theme.of(context)
                          .textTheme
                          .labelLarge
                          ?.copyWith(letterSpacing: 0.14),
                    ),
                    child: Text(item.label.toUpperCase()),
                  ),
                Padding(
                  padding: const EdgeInsets.all(spacingLg),
                  child: PrimaryButton(
                    label: s.navCv,
                    onTap: () {
                      Navigator.of(sheetContext).pop();
                      openUrl(cvUrl);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Wordmark extends StatelessWidget {
  const _Wordmark({required this.onTap, required this.compact});

  final VoidCallback onTap;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final h = context.hermes;
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        foregroundColor: h.fg,
        minimumSize: const Size(minTapTarget, minTapTarget),
        padding: const EdgeInsets.symmetric(horizontal: spacingXs),
        shape: const RoundedRectangleBorder(borderRadius: buttonRadius),
        overlayColor: h.primary.withValues(alpha: 0.06),
      ),
      child: Text(
        compact ? 'TA' : displayName.toUpperCase(),
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontSize: compact ? 17 : 15,
              letterSpacing: 0.08,
              color: h.fg,
            ),
      ),
    );
  }
}

class _NavLink extends StatelessWidget {
  const _NavLink({
    required this.item,
    required this.isActive,
    required this.onTap,
  });

  final NavItem item;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final h = context.hermes;
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        foregroundColor: isActive ? h.primaryInk : h.body,
        minimumSize: const Size(0, minTapTarget),
        padding: const EdgeInsets.symmetric(horizontal: spacingMd),
        shape: const RoundedRectangleBorder(borderRadius: buttonRadius),
        overlayColor: h.primary.withValues(alpha: 0.06),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            item.label.toUpperCase(),
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.12,
                  color: isActive ? h.primaryInk : h.body,
                ),
          ),
          const SizedBox(height: 4),
          AnimatedContainer(
            duration: MediaQuery.disableAnimationsOf(context)
                ? Duration.zero
                : motionFast,
            height: 2,
            width: isActive ? 18 : 0,
            color: h.primary,
          ),
        ],
      ),
    );
  }
}

/// EN / ID, current one in gold. 44px tall so it stays tappable.
class _LanguageToggle extends StatelessWidget {
  const _LanguageToggle();

  @override
  Widget build(BuildContext context) {
    final h = context.hermes;
    final current = context.strings.code;
    final style = Theme.of(context).textTheme.labelSmall?.copyWith(
          fontSize: 11.5,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.1,
        );

    Widget item(String code) {
      final active = code == current;
      return TextButton(
        onPressed: active ? null : toggleLanguage,
        style: TextButton.styleFrom(
          minimumSize: const Size(30, minTapTarget),
          padding: const EdgeInsets.symmetric(horizontal: 5),
          foregroundColor: active ? h.primaryInk : h.muted,
          disabledForegroundColor: h.primaryInk,
          shape: const RoundedRectangleBorder(borderRadius: buttonRadius),
          overlayColor: h.primary.withValues(alpha: 0.06),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Text(code, style: style),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        item('EN'),
        Text('/', style: style?.copyWith(color: h.borderStrong)),
        item('ID'),
      ],
    );
  }
}

class _ThemeToggle extends StatelessWidget {
  const _ThemeToggle();

  @override
  Widget build(BuildContext context) {
    final h = context.hermes;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final s = context.strings;
    return IconButton(
      tooltip: isDark ? s.themeLight : s.themeDark,
      color: h.body,
      onPressed: () =>
          themeMode.value = isDark ? ThemeMode.light : ThemeMode.dark,
      icon: Icon(isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
          size: 20),
    );
  }
}
