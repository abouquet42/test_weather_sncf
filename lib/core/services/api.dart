import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:multiple_result/multiple_result.dart';
import 'package:weather_test_sncf/core/enums/unit_temp.dart';
import 'package:weather_test_sncf/core/models/user.dart';
import 'package:weather_test_sncf/res/i18n.dart';
import 'package:weather_test_sncf/utils/units.dart';
import '../../helpers/constants.dart';
import '../models/weather.dart';

class API {
  static const endpointForecast = URL.forecast;
  static const endpointIcons = URL.icons;

  var client = http.Client();

  Future<Result<List<Forecast>, Exception>> getForecasts(UnitTemp unit) async {
    try {
      final forecasts = <Forecast>[];

      final String unitStr = getUnitString(unit);
      final url = Uri.parse(endpointForecast + unitStr);

      final http.Response response = await client.get(url);
      switch (response.statusCode) {
        case 200:
          final ForecastAll forecastAll =
              ForecastAll.fromJson(json.decode(response.body));
          for (final forecast in forecastAll.forecasts) {
            forecasts.add(forecast);
          }

          return Success(forecasts);
        default:
          return Error(Exception(response.reasonPhrase));
      }
    } on SocketException catch (e) {
      return Error(e);
    }
  }

  Result<User, Exception> getUser(String username, String password) {
    try {
      http.Response response =
          http.Response(jsonEncode(User('John Doe').toJson()), 200);
      switch (response.statusCode) {
        case 200:
          if (username == UserMock.username && password == UserMock.password) {
            return Success(User.fromJson(jsonDecode(response.body)));
          } else {
            return Error(Exception(I18n.exceptionLogin));
          }
        default:
          return Error(Exception(response.reasonPhrase));
      }
    } on SocketException catch (e) {
      return Error(e);
    }
  }
}
