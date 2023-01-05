import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:weather_test_sncf/core/enums/unit_temp.dart';
import 'package:weather_test_sncf/core/models/weather.dart';
import 'package:weather_test_sncf/core/services/api.dart';
import 'package:weather_test_sncf/helpers/dependency_assembly.dart';
import 'package:weather_test_sncf/utils/units.dart';

part 'get_forecast_event.dart';

part 'get_forecast_state.dart';

class GetForecastBloc extends Bloc<GetForecastEvent, GetForecastState> {
  GetForecastBloc() : super(GetForecastInitial()) {
    on<GetForecast>((GetForecast event, Emitter<GetForecastState> emit) async {
      emit(GetForecastLoading());
      try {
        API api = dependencyAssembler<API>();

        Result<List<Forecast>, Exception> result =
            await api.getForecasts(event.unit);

        result.whenSuccess((success) {
          List<Forecast> forecasts = success;
          final String unit = getUnit(event.unit);
          emit(GetForecastSuccess(forecasts, unit));
        });
        result.whenError((error) {
          emit(GetForecastError(error));
        });
      } catch (error) {
        if (error is Exception) {
          emit(GetForecastError(error));
        }
      }
    });
  }
}
