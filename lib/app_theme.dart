import 'package:flutter/material.dart';

class _Colors {
  Color get primary => const Color(0xFF0476B1);
  Color get secondary => const Color(0xFF8de8fe);
}

class _Values {
  BorderRadius get defaultBorderRadius => BorderRadius.circular(5.0);
}

/// Assets
class _ImageAssets {}

class _Icons {}

class _TextStyles {
  final _Colors colors;

  _TextStyles(this.colors);

  TextStyle get titleTextField => TextStyle(
        color: colors.primary,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      );

  TextStyle get titleLarge => TextStyle(
        color: colors.primary,
        fontSize: 18,
        fontWeight: FontWeight.w700,
      );

  TextStyle get textButton => const TextStyle(
        color: Colors.white,
        fontSize: 15,
        fontWeight: FontWeight.w600,
      );

  TextStyle get error => const TextStyle(
        color: Colors.red,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      );
}

// ignore: must_be_immutable
class AppTheme extends InheritedWidget {
  final _Colors colors = _Colors();

  final _Values values = _Values();

  final _Icons icons = _Icons();

  final _ImageAssets assets = _ImageAssets();

  late _TextStyles textStyles;

  AppTheme({
    Key? key,
    required Widget child,
  }) : super(key: key, child: child) {
    textStyles = _TextStyles(colors);
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;

  static AppTheme? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppTheme>();
  }
}
