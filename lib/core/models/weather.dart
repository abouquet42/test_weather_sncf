import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class ForecastAll extends Equatable {
  final List<Forecast> forecasts;

  const ForecastAll(this.forecasts);

  ForecastAll.fromJson(Map<String, dynamic> json)
      : forecasts = (json['list'] as List).map((e) {
    return Forecast.fromJson(e as Map<String, dynamic>);
  }).toList();

  @override
  List<Object?> get props => [forecasts];
}

class Forecast {
  final String date;
  final String hour;
  final ForecastMain main;
  final List<Weather> weathers;

  Forecast(
    this.date,
    this.hour,
    this.main,
    this.weathers,
  );

  static String getDate(int dt) {
    final String date =  DateFormat('dd/MM/yyyy')
        .format(DateTime.fromMillisecondsSinceEpoch(dt * 1000, isUtc: true));
    return date;
  }

  static String getHour(int dt) {
    final String date =  DateFormat('HH:mm')
        .format(DateTime.fromMillisecondsSinceEpoch(dt * 1000, isUtc: true));
    return date;
  }

  Forecast.fromJson(Map<String, dynamic> json)
      : date = getDate(json['dt']),
        hour = getHour(json['dt']),
        main = ForecastMain.fromJson(json['main']),
        weathers = (json['weather'] as List).map((e) {
          return Weather.fromJson(e as Map<String, dynamic>);
        }).toList();
}

class ForecastMain {
  final double temp;
  final double tempMin;
  final double tempMax;
  final int humidity;

  ForecastMain(
    this.temp,
    this.tempMin,
    this.tempMax,
    this.humidity,
  );

  ForecastMain.fromJson(Map<String, dynamic> json)
      : temp = double.parse(json['temp'].toString()),
        tempMin = double.parse(json['temp_min'].toString()),
        tempMax = double.parse(json['temp_max'].toString()),
        humidity = json['humidity'] as int;
}

class Weather {
  final String main;
  final String description;
  final String icon;

  Weather(
    this.main,
    this.description,
    this.icon,
  );

  Weather.fromJson(Map<String, dynamic> json)
      : main = json['main'] as String,
        description = json['description'] as String,
        icon = json['icon'] as String;
}
