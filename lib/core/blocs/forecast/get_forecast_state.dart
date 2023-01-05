part of 'get_forecast_bloc.dart';

@immutable
abstract class GetForecastState extends Equatable {}

class GetForecastInitial extends GetForecastState {
  @override
  List<Object?> get props => [];
}

class GetForecastLoading extends GetForecastState {
  @override
  List<Object?> get props => [];
}

class GetForecastSuccess extends GetForecastState {
  final List<Forecast> forecasts;
  final String unit;

  GetForecastSuccess(this.forecasts, this.unit);

  @override
  List<Object> get props => [forecasts, unit];
}

class GetForecastError extends GetForecastState {
  final Exception exception;

  GetForecastError(this.exception);

  @override
  List<Object?> get props => [exception];
}
