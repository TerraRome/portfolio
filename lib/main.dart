import 'package:flutter/material.dart';
import 'package:flutter_portfolio/res/constants.dart';
import 'package:flutter_portfolio/res/strings.dart';
import 'package:flutter_portfolio/res/theme_mode.dart';
import 'package:flutter_portfolio/view/page.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AppStrings>(
      valueListenable: appStrings,
      builder: (context, strings, _) => StringsScope(
        strings: strings,
        child: ValueListenableBuilder<ThemeMode>(
          valueListenable: themeMode,
          builder: (context, mode, _) => MaterialApp(
            title: 'Tengku Alfarizi — Flutter & Mobile Engineer',
            debugShowCheckedModeBanner: false,
            theme: _theme(HermesColors.light, Brightness.light),
            darkTheme: _theme(HermesColors.dark, Brightness.dark),
            themeMode: mode,
            home: const PortfolioPage(),
          ),
        ),
      ),
    );
  }
}

ThemeData _theme(HermesColors h, Brightness brightness) {
  final scheme = ColorScheme.fromSeed(
    seedColor: h.primary,
    brightness: brightness,
  ).copyWith(
    primary: h.primary,
    onPrimary: h.onPrimary,
    secondary: h.copper,
    onSecondary: h.fg,
    surface: h.surface,
    onSurface: h.fg,
    error: h.danger,
    onError: h.bg,
    outline: h.border,
  );

  return ThemeData(
    useMaterial3: true,
    brightness: brightness,
    colorScheme: scheme,
    scaffoldBackgroundColor: h.bg,
    canvasColor: h.bg,
    textTheme: hermesTextTheme(h.fg, h.body),
    extensions: <ThemeExtension<dynamic>>[h],
    dividerTheme: DividerThemeData(color: h.border, thickness: 1, space: 1),
    iconTheme: IconThemeData(color: h.body),
    focusColor: h.primary,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    hoverColor: h.surfaceHover,
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: h.primary,
      selectionColor: h.primary.withValues(alpha: 0.24),
      selectionHandleColor: h.primary,
    ),
    scrollbarTheme: ScrollbarThemeData(
      thumbColor: WidgetStatePropertyAll(h.borderStrong),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: h.surface,
      surfaceTintColor: Colors.transparent,
    ),
  );
}
