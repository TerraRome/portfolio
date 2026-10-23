import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ---------------------------------------------------------------------------
// Hermes design system — single source of truth.
//
// All UI reads colors from `context.hermes` (HermesColors ThemeExtension) so
// light and dark mode both work. The bare `const` aliases at the bottom are the
// dark-mode values kept for legacy call sites; new code should not use them.
// ---------------------------------------------------------------------------

@immutable
class HermesColors extends ThemeExtension<HermesColors> {
  const HermesColors({
    required this.bg,
    required this.surface,
    required this.surfaceHover,
    required this.border,
    required this.borderStrong,
    required this.fg,
    required this.body,
    required this.muted,
    required this.primary,
    required this.onPrimary,
    required this.primaryInk,
    required this.copper,
    required this.copperInk,
    required this.success,
    required this.warning,
    required this.danger,
    required this.info,
    required this.silver,
    required this.diamond,
    required this.olympian,
    required this.shadow1,
    required this.shadow2,
    required this.shadow4,
    required this.halo,
  });

  final Color bg;
  final Color surface;
  final Color surfaceHover;
  final Color border;
  final Color borderStrong;
  final Color fg;
  final Color body;
  final Color muted;

  /// Gold. Fill for primary actions; safe as text in dark mode.
  final Color primary;
  final Color onPrimary;

  /// Gold darkened for text on light surfaces (≥4.5:1).
  final Color primaryInk;

  /// Copper fill / border. Not for text.
  final Color copper;

  /// Copper legible as text in this mode (≥4.5:1).
  final Color copperInk;

  final Color success;
  final Color warning;
  final Color danger;
  final Color info;

  // Tier badges only.
  final Color silver;
  final Color diamond;
  final Color olympian;

  final List<BoxShadow> shadow1;
  final List<BoxShadow> shadow2;
  final List<BoxShadow> shadow4;
  final List<BoxShadow> halo;

  static const dark = HermesColors(
    bg: Color(0xFF0D1514),
    surface: Color(0xFF151F1D),
    surfaceHover: Color(0xFF1B2724),
    border: Color(0xFF2A3D38),
    borderStrong: Color(0xFF3A5148),
    fg: Color(0xFFE2ECE9),
    body: Color(0xFFA9BDB7),
    muted: Color(0xFF8FA5A0),
    primary: Color(0xFFCBA374),
    onPrimary: Color(0xFF0A100F),
    primaryInk: Color(0xFFCBA374),
    copper: Color(0xFFA86A42),
    copperInk: Color(0xFFC98A5E),
    success: Color(0xFF6FBFA0),
    warning: Color(0xFFD9BB6A),
    danger: Color(0xFFE07373),
    info: Color(0xFF7FB4D4),
    silver: Color(0xFF8A9BA8),
    diamond: Color(0xFF4A9CB0),
    olympian: Color(0xFF9B76D6),
    shadow1: [BoxShadow(color: Color(0x66000000), offset: Offset(0, 1), blurRadius: 2)],
    shadow2: [BoxShadow(color: Color(0x73000000), offset: Offset(0, 4), blurRadius: 6)],
    shadow4: [BoxShadow(color: Color(0x8C000000), offset: Offset(0, 20), blurRadius: 25)],
    halo: [BoxShadow(color: Color(0x26CBA374), blurRadius: 28, spreadRadius: 1)],
  );

  static const light = HermesColors(
    bg: Color(0xFFF5F2ED),
    surface: Color(0xFFFFFFFF),
    surfaceHover: Color(0xFFEFEAE2),
    border: Color(0xFFE0D8CC),
    borderStrong: Color(0xFFC8BCA9),
    fg: Color(0xFF1A1A1A),
    body: Color(0xFF4A4A48),
    muted: Color(0xFF5C5C58),
    primary: Color(0xFFCBA374),
    onPrimary: Color(0xFF0A100F),
    primaryInk: Color(0xFF7A5228),
    copper: Color(0xFFA86A42),
    copperInk: Color(0xFF8A4E28),
    success: Color(0xFF2F6B52),
    warning: Color(0xFF8A6A14),
    danger: Color(0xFFA83232),
    info: Color(0xFF2C6485),
    silver: Color(0xFF5F7078),
    diamond: Color(0xFF2C6F7E),
    olympian: Color(0xFF5B3A93),
    shadow1: [BoxShadow(color: Color(0x14000000), offset: Offset(0, 1), blurRadius: 2)],
    shadow2: [BoxShadow(color: Color(0x1A000000), offset: Offset(0, 4), blurRadius: 6)],
    shadow4: [BoxShadow(color: Color(0x26000000), offset: Offset(0, 20), blurRadius: 25)],
    halo: [BoxShadow(color: Color(0x33A86A42), blurRadius: 24, spreadRadius: 1)],
  );

  @override
  HermesColors copyWith({Color? bg}) => this;

  @override
  HermesColors lerp(ThemeExtension<HermesColors>? other, double t) {
    if (other is! HermesColors) return this;
    Color mix(Color a, Color b) => Color.lerp(a, b, t)!;
    return HermesColors(
      bg: mix(bg, other.bg),
      surface: mix(surface, other.surface),
      surfaceHover: mix(surfaceHover, other.surfaceHover),
      border: mix(border, other.border),
      borderStrong: mix(borderStrong, other.borderStrong),
      fg: mix(fg, other.fg),
      body: mix(body, other.body),
      muted: mix(muted, other.muted),
      primary: mix(primary, other.primary),
      onPrimary: mix(onPrimary, other.onPrimary),
      primaryInk: mix(primaryInk, other.primaryInk),
      copper: mix(copper, other.copper),
      copperInk: mix(copperInk, other.copperInk),
      success: mix(success, other.success),
      warning: mix(warning, other.warning),
      danger: mix(danger, other.danger),
      info: mix(info, other.info),
      silver: mix(silver, other.silver),
      diamond: mix(diamond, other.diamond),
      olympian: mix(olympian, other.olympian),
      shadow1: t < 0.5 ? shadow1 : other.shadow1,
      shadow2: t < 0.5 ? shadow2 : other.shadow2,
      shadow4: t < 0.5 ? shadow4 : other.shadow4,
      halo: t < 0.5 ? halo : other.halo,
    );
  }
}

extension HermesContext on BuildContext {
  HermesColors get hermes =>
      Theme.of(this).extension<HermesColors>() ?? HermesColors.dark;
}

// ---------------------------------------------------------------------------
// Geometry, spacing, motion — mode independent.
// ---------------------------------------------------------------------------

const double radiusButton = 4;
const double radiusModal = 8;
const BorderRadius buttonRadius = BorderRadius.all(Radius.circular(radiusButton));
const BorderRadius modalRadius = BorderRadius.all(Radius.circular(radiusModal));
const BorderRadius sharpRadius = BorderRadius.zero;

const double defaultPadding = 20;
const double spacingXs = 4;
const double spacingSm = 8;
const double spacingMd = 16;
const double spacingLg = 24;
const double spacingXl = 32;
const double spacing2xl = 48;
const double spacing3xl = 64;

/// Max width for reading columns; keeps prose off the 1440px edge.
const double contentMaxWidth = 1120;
const double proseMaxWidth = 680;

/// Minimum comfortable hit area.
const double minTapTarget = 44;

const Duration motionFast = Duration(milliseconds: 150);
const Duration motionNormal = Duration(milliseconds: 250);

/// Cinzel display + Inter body. Colors come from the theme, not from here.
TextTheme hermesTextTheme(Color fg, Color body) {
  final cinzel = GoogleFonts.cinzel;
  final inter = GoogleFonts.inter;

  TextStyle display(double size, FontWeight weight, double spacing) => cinzel(
        fontSize: size,
        fontWeight: weight,
        letterSpacing: spacing,
        height: 1.12,
        color: fg,
      );

  TextStyle text(double size, FontWeight weight, double spacing) => inter(
        fontSize: size,
        fontWeight: weight,
        letterSpacing: spacing,
        height: 1.55,
        color: body,
      );

  return TextTheme(
    displayLarge: display(56, FontWeight.w700, 0.02),
    displayMedium: display(44, FontWeight.w700, 0.02),
    displaySmall: display(36, FontWeight.w600, 0.02),
    headlineLarge: display(32, FontWeight.w600, 0.01),
    headlineMedium: display(26, FontWeight.w600, 0.01),
    headlineSmall: display(21, FontWeight.w600, 0.01),
    titleLarge: cinzel(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.01,
      color: fg,
    ),
    titleMedium: inter(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.01,
      color: fg,
    ),
    titleSmall: inter(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.02,
      color: fg,
    ),
    bodyLarge: text(17, FontWeight.w400, 0),
    bodyMedium: text(15, FontWeight.w400, 0),
    bodySmall: text(13.5, FontWeight.w400, 0),
    labelLarge: inter(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.06,
      color: fg,
    ),
    labelMedium: inter(
      fontSize: 13,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.08,
      color: body,
    ),
    labelSmall: inter(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
      color: body,
    ),
  );
}

// ---------------------------------------------------------------------------
// Legacy aliases (dark mode). Kept so untouched call sites still compile.
// New code: use `context.hermes`.
// ---------------------------------------------------------------------------

const bgColor = Color(0xFF0D1514);
const surfaceColor = Color(0xFF151F1D);
const surfaceHoverColor = Color(0xFF1B2724);
const borderColor = Color(0xFF2A3D38);
const foregroundColor = Color(0xFFE2ECE9);
const bodyTextColor = Color(0xFFA9BDB7);
const onGoldColor = Color(0xFF0A100F);
const primaryColor = Color(0xFFCBA374);
const secondaryColor = Color(0xFFA86A42);
const copperTextColor = Color(0xFFC98A5E);
const successColor = Color(0xFF6FBFA0);
const warningColor = Color(0xFFD9BB6A);
const dangerColor = Color(0xFFE07373);
const infoColor = Color(0xFF7FB4D4);
const silverTierColor = Color(0xFF8A9BA8);
const diamondTierColor = Color(0xFF4A9CB0);
const olympianTierColor = Color(0xFF9B76D6);
final List<BoxShadow> shadowLevel1 = HermesColors.dark.shadow1;
final List<BoxShadow> shadowLevel2 = HermesColors.dark.shadow2;
final List<BoxShadow> shadowLevel4 = HermesColors.dark.shadow4;
final List<BoxShadow> goldHalo = HermesColors.dark.halo;
