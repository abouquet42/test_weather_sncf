import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_test_sncf/app_theme.dart';
import 'package:weather_test_sncf/core/models/weather.dart';
import 'package:weather_test_sncf/helpers/constants.dart';
import 'package:weather_test_sncf/login/login_view.dart';
import 'package:weather_test_sncf/routes.dart';

List<Forecast> mockForecastsCelsius = [
  Forecast(
    '03/01/2023',
    '21:00',
    ForecastMain(
      10,
      8,
      12,
      80,
    ),
    [
      Weather(
        'Rain',
        'light rain',
        '10n',
      )
    ],
  ),
  Forecast(
    '04/01/2023',
    '00:00',
    ForecastMain(
      6,
      5,
      7,
      60,
    ),
    [
      Weather(
        'Rain',
        'moderate rain',
        '10d',
      )
    ],
  ),
];

void main() {
  group('''Login is displayed''', () {
    testWidgets('''TextFields are displayed''', (WidgetTester tester) async {
      await tester.pumpWidget(const LoginViewWrapper());
      await tester.pump(Duration.zero);

      final loginEmailTFKey = find.byKey(const Key(loginEmailKey));
      expect(loginEmailTFKey, findsOneWidget);

      final loginPasswordTFKey = find.byKey(const Key(loginPasswordKey));
      expect(loginPasswordTFKey, findsOneWidget);
    });

    testWidgets('''Validated button is displayed''', (WidgetTester tester) async {
      await tester.pumpWidget(const LoginViewWrapper());
      await tester.pump(Duration.zero);

      final loginValidateButtonKey = find.byKey(const Key(loginValidateKey));
      expect(loginValidateButtonKey, findsOneWidget);
    });
  });
}

class LoginViewWrapper extends StatelessWidget {
  const LoginViewWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppTheme(
      child: const MaterialApp(
        onGenerateRoute: AppRoutes.getRoutes,
        home: LoginView(),
      ),
    );
  }
}
