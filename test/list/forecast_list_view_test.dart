import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_test_sncf/app_theme.dart';
import 'package:weather_test_sncf/core/blocs/forecast/get_forecast_bloc.dart';
import 'package:weather_test_sncf/core/enums/unit_temp.dart';
import 'package:weather_test_sncf/core/models/weather.dart';
import 'package:weather_test_sncf/helpers/constants.dart';
import 'package:weather_test_sncf/utils/units.dart';
import 'package:weather_test_sncf/weather/weather_view.dart';

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

const String username = 'Test name';

void main() {
  List<Forecast> forecasts = <Forecast>[];

  late GetForecastBloc getForecastBloc;
  setUp(() {
    getForecastBloc = GetForecastBloc()
      ..add(GetForecast(unit: UnitTemp.celsius));
  });

  group('Load forecasts list', () {

    testWidgets('''Forecasts are loading then display list''',
        (WidgetTester tester) async {
      // Load and render Widget
      await tester.pumpWidget(WeatherViewWrapper(
        blocForecast: getForecastBloc,
      ));
      await tester.pump(Duration.zero);

      final loadingKey = find.byKey(const Key(forecastsLoading));
      expect(loadingKey, findsOneWidget);

      final String unit = getUnit(UnitTemp.celsius);
      forecasts = mockForecastsCelsius;
      getForecastBloc.emit(GetForecastSuccess(forecasts, unit));

      await tester.pump(const Duration(seconds: 3));

      // Check Forecasts List's component's existence via key
      final forecastListKey = find.byKey(const Key(forecastsListKey));
      expect(forecastListKey, findsOneWidget);

      // Check there is 2 forecasts
      final forecastsKey = find.byKey(const Key(forecastKey));
      expect(forecastsKey, findsNWidgets(2));
    });
  });

  testWidgets('''Weather view is loading with username in title''',
      (WidgetTester tester) async {
    // Load and render Widget
    await tester.pumpWidget(WeatherViewWrapper(
      blocForecast: getForecastBloc,
    ));
    await tester.pump(Duration.zero);

    // Check there is the username
    final usernameText = find.byKey(const Key(usernameKey));
    expect(usernameText, findsOneWidget);

    final titleFinder = find.text('Welcome $username');
    await tester.ensureVisible(titleFinder);
    expect(titleFinder, findsOneWidget);
  });
}

class WeatherViewWrapper extends StatelessWidget {
  final GetForecastBloc blocForecast;

  const WeatherViewWrapper({
    required this.blocForecast,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppTheme(
      child: BlocProvider<GetForecastBloc>(
        create: (context) =>
            blocForecast..add(GetForecast(unit: UnitTemp.celsius)),
        child: const MaterialApp(
          home: WeatherView(name: username),
        ),
      ),
    );
  }
}
