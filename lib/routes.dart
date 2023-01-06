import 'package:flutter/material.dart';
import 'package:weather_test_sncf/errors/error_screen.dart';
import 'package:weather_test_sncf/ui/login/login_view.dart';
import 'package:weather_test_sncf/ui/weather/weather_view.dart';

class AppRoutes {
  static const String routeLogin = '/login';
  static const String routeWeather = '/weather';

  const AppRoutes._();

  static Route<dynamic> getRoutes(RouteSettings settings) {
    WidgetBuilder? builder;

    settings = rewriteRoute(settings);

    String? routeName = settings.name;
    Object? arguments = settings.arguments;

    switch (routeName) {
      case routeLogin:
        builder = (BuildContext context) => const LoginView();
        break;
      case routeWeather:
        String nameArgument = arguments as String;
        builder = (BuildContext context) => WeatherView(
          name: nameArgument,
        );
        break;
    }

    builder ??= (BuildContext context) => const LoginView();

    return MaterialPageRoute<dynamic>(
      builder: builder,
      settings: settings,
    );
  }

  static RouteSettings rewriteRoute(RouteSettings settings) {
    return settings;
  }

  static Route<dynamic> onUnknownRoute(RouteSettings settings) {
    return MaterialPageRoute<dynamic>(
      builder: (BuildContext context) => const ErrorScreen(),
      settings: settings,
    );
  }
}
