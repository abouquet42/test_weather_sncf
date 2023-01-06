import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_test_sncf/app_theme.dart';
import 'package:weather_test_sncf/core/blocs/forecast/get_forecast_bloc.dart';
import 'package:weather_test_sncf/core/enums/unit_temp.dart';
import 'package:weather_test_sncf/core/models/weather.dart';
import 'package:weather_test_sncf/helpers/constants.dart';
import 'package:weather_test_sncf/res/i18n.dart';

import '../../core/services/api.dart';

class WeatherView extends StatelessWidget {
  final String name;

  const WeatherView({
    required this.name,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.of(context)!.colors.primary,
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.thermostat_rounded),
            itemBuilder: (context) {
              return [
                PopupMenuItem<int>(
                  value: 0,
                  child: Text(I18n.celsiusButton),
                ),
                PopupMenuItem<int>(
                  value: 1,
                  child: Text(I18n.kelvinButton),
                ),
                PopupMenuItem<int>(
                  value: 2,
                  child: Text(I18n.fahrenheitButton),
                ),
              ];
            },
            onSelected: (value) {
              if (value == 0) {
                BlocProvider.of<GetForecastBloc>(context)
                    .add(GetForecast(unit: UnitTemp.celsius));
              } else if (value == 1) {
                BlocProvider.of<GetForecastBloc>(context)
                    .add(GetForecast(unit: UnitTemp.kelvin));
              } else if (value == 2) {
                BlocProvider.of<GetForecastBloc>(context)
                    .add(GetForecast(unit: UnitTemp.fahrenheit));
              }
            },
          ),
        ],
        title: Text(
          '${I18n.welcomeTitle} $name',
          key: const Key(usernameKey),
        ),
      ),
      body: BlocBuilder<GetForecastBloc, GetForecastState>(
        builder: (BuildContext context, GetForecastState state) {
          if (state is GetForecastSuccess) {
            final List<Forecast> forecasts = state.forecasts;
            final String unit = state.unit;

            if (forecasts.isEmpty) {
              return const ListEmpty();
            }
            return ListContent(
              key: const Key(forecastsListKey),
              forecasts: forecasts,
              unit: unit,
            );
          } else if (state is GetForecastError) {
            return const ErrorWidget();
          }
          return const Center(
            key: Key(forecastsLoading),
            child: CircularProgressIndicator.adaptive(),
          );
        },
      ),
    );
  }
}

class ListContent extends StatelessWidget {
  final List<Forecast> forecasts;
  final String unit;

  const ListContent({
    required this.forecasts,
    required this.unit,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            I18n.weatherInParisText,
            style: AppTheme.of(context)?.textStyles.titleLarge,
          ),
        ),
        Container(
          height: 1,
          color: AppTheme.of(context)?.colors.primary,
        ),
        Expanded(
          child: ListView.builder(
            itemCount: forecasts.length,
            itemBuilder: (BuildContext context, int index) {
              final Forecast forecast = forecasts[index];

              if ((index > 0 && forecast.date != forecasts[index - 1].date) ||
                  index == 0) {
                return Column(
                  children: [
                    Container(
                      height: 40,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppTheme.of(context)?.colors.primary,
                      ),
                      child: Center(
                        child: Text(
                          forecast.date,
                          style: AppTheme.of(context)?.textStyles.textButton,
                        ),
                      ),
                    ),
                    CardDetail(
                      key: const Key(forecastKey),
                      forecast: forecast,
                      unit: unit,
                    ),
                  ],
                );
              }
              return CardDetail(
                key: const Key(forecastKey),
                forecast: forecast,
                unit: unit,
              );
            },
          ),
        ),
      ],
    );
  }
}

class ListEmpty extends StatelessWidget {
  const ListEmpty({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        I18n.noForecastText,
      ),
    );
  }
}

class ErrorWidget extends StatelessWidget {
  const ErrorWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Spacer(),
          Text(
            I18n.errorOccurredText,
            style: AppTheme.of(context)?.textStyles.error,
          ),
          const SizedBox(height: 16),
          buildRetryButton(context),
          const Spacer(),
        ],
      ),
    );
  }

  InkWell buildRetryButton(BuildContext context) {
    return InkWell(
      onTap: () {
        BlocProvider.of<GetForecastBloc>(context)
            .add(GetForecast(unit: UnitTemp.celsius));
      },
      child: Container(
        height: 50,
        width: 120,
        decoration: BoxDecoration(
          color: AppTheme.of(context)?.colors.primary,
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Center(
          child: Text(
            I18n.retryButton,
            style: AppTheme.of(context)?.textStyles.textButton,
          ),
        ),
      ),
    );
  }
}

class CardDetail extends StatelessWidget {
  final Forecast forecast;
  final String unit;

  const CardDetail({
    required this.forecast,
    required this.unit,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1.0,
            color: AppTheme.of(context)!.colors.primary,
          ),
          borderRadius: AppTheme.of(context)?.values.defaultBorderRadius,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                  color: AppTheme.of(context)?.colors.primary,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Center(
                  child: CachedNetworkImage(
                    imageUrl:
                        '${API.endpointIcons}${forecast.weathers.first.icon}$suffixIcon',
                    placeholder: (context, url) =>
                        const CircularProgressIndicator.adaptive(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
              const SizedBox(width: 16.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('${forecast.date} ${forecast.hour}'),
                  Text(
                    '${forecast.main.temp} °$unit',
                    style: AppTheme.of(context)?.textStyles.titleTextField,
                  ),
                  Text(
                      '${forecast.weathers.first.main}: ${forecast.weathers.first.description}'),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
