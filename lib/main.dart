import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_test_sncf/app_theme.dart';
import 'package:weather_test_sncf/core/blocs/forecast/get_forecast_bloc.dart';
import 'package:weather_test_sncf/res/i18n.dart';
import 'package:weather_test_sncf/routes.dart';
import 'package:weather_test_sncf/ui/login/login_view.dart';

import 'helpers/dependency_assembly.dart';

void main() {
  setupDependencyAssembler();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ConnectivityAppWrapper(
      app: AppTheme(
        child: BlocProvider<GetForecastBloc>(
          create: (context) =>
              GetForecastBloc(),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            onGenerateRoute: AppRoutes.getRoutes,
            home: const LoginView(),
            localizationsDelegates: const [
              I18nDelegate(),
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: I18nDelegate.supportedLocals,
            builder: (BuildContext buildContext, Widget? widget) {
              return ConnectivityWidgetWrapper(
                disableInteraction: false,
                height: 80,
                child: widget ??
                    Container(
                      color: Colors.red,
                    ),
              );
            },
          ),
        ),
      ),
    );
  }
}
