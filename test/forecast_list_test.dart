import 'package:flutter_test/flutter_test.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:weather_test_sncf/core/blocs/forecast/get_forecast_bloc.dart';
import 'package:weather_test_sncf/core/enums/unit_temp.dart';
import 'package:weather_test_sncf/core/models/weather.dart';
import 'package:weather_test_sncf/core/services/api.dart';
import 'package:weather_test_sncf/utils/units.dart';

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

List<Forecast> mockForecastsKelvin = [
  Forecast(
    '03/01/2023',
    '21:00',
    ForecastMain(
      286.31,
      286.1,
      286.31,
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
      285.29,
      284.72,
      285.29,
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

class MockAPI extends API {
  @override
  Future<Result<List<Forecast>, Exception>> getForecasts(UnitTemp unit) {
    if (unit == UnitTemp.kelvin) {
      return Future.value(Success(mockForecastsKelvin));
    }
    return Future.value(Success(mockForecastsCelsius));
  }
}

void main() {
  API api = MockAPI();

  List<Forecast> forecasts = <Forecast>[];

  group('Load forecasts', () {
    late GetForecastBloc getForecastBloc;
    setUp(() => getForecastBloc = GetForecastBloc()
      ..add(GetForecast(unit: UnitTemp.celsius)));

    test('Bloc should get list of forecasts', () {
      expect(getForecastBloc.state, GetForecastLoading());

      final String unit = getUnit(UnitTemp.celsius);
      forecasts = mockForecastsCelsius;
      getForecastBloc.emit(GetForecastSuccess(forecasts, unit));

      expect(getForecastBloc.state, GetForecastSuccess(mockForecastsCelsius, 'C'));
    });
  });

  group('Load forecasts for a unit', (){
    test('Page should load a list of forecasts in celsius', () async {
      Result<List<Forecast>, Exception> result = await api.getForecasts(UnitTemp.celsius);
      List<Forecast>? listForecasts = result.tryGetSuccess();
      expect(listForecasts?.length, 2);

      expect(listForecasts?[0].weathers.first.main, 'Rain');
      expect(listForecasts?[0].weathers.first.description, 'light rain');
      expect(listForecasts?[0].weathers.first.icon, '10n');
      expect(listForecasts?[0].date, '03/01/2023');
      expect(listForecasts?[0].hour, '21:00');
      expect(listForecasts?[0].main.temp, 10);
      expect(listForecasts?[0].main.tempMin, 8);
      expect(listForecasts?[0].main.tempMax, 12);
      expect(listForecasts?[0].main.humidity, 80);

      expect(listForecasts?[1].weathers.first.main, 'Rain');
      expect(listForecasts?[1].weathers.first.description, 'moderate rain');
      expect(listForecasts?[1].weathers.first.icon, '10d');
      expect(listForecasts?[1].date, '04/01/2023');
      expect(listForecasts?[1].hour, '00:00');
      expect(listForecasts?[1].main.temp, 6);
      expect(listForecasts?[1].main.tempMin, 5);
      expect(listForecasts?[1].main.tempMax, 7);
      expect(listForecasts?[1].main.humidity, 60);
    });

    test('Page should load a list of forecasts in kelvin', () async {
      Result<List<Forecast>, Exception> result = await api.getForecasts(UnitTemp.kelvin);
      List<Forecast>? listForecasts = result.tryGetSuccess();
      expect(listForecasts?.length, 2);

      expect(listForecasts?[0].main.temp, 286.31);
      expect(listForecasts?[0].main.tempMin, 286.1);
      expect(listForecasts?[0].main.tempMax, 286.31);

      expect(listForecasts?[1].main.temp, 285.29);
      expect(listForecasts?[1].main.tempMin, 284.72);
      expect(listForecasts?[1].main.tempMax, 285.29);
    });
  });
}
