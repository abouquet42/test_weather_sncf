part of 'get_forecast_bloc.dart';

@immutable
abstract class GetForecastEvent {}

class GetForecast extends GetForecastEvent {
  final UnitTemp unit;

  GetForecast({required this.unit});
}
