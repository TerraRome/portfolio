import 'package:flutter/material.dart';

/// System by default; the nav toggle pins an explicit light/dark choice.
final ValueNotifier<ThemeMode> themeMode = ValueNotifier<ThemeMode>(
  ThemeMode.system,
);
