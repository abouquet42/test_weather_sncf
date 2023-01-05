import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:crypto/crypto.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:weather_test_sncf/core/models/user.dart';
import 'package:weather_test_sncf/core/services/api.dart';
import 'package:weather_test_sncf/helpers/dependency_assembly.dart';
import 'package:weather_test_sncf/res/i18n.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LogUserIn>((LogUserIn event, Emitter<LoginState> emit) async {
      emit(LoginLoading());
      try {
        API api = dependencyAssembler<API>();

        final List<int> bytes = utf8.encode(event.password);
        final Digest sha256Password = sha256.convert(bytes);

        Result<User, Exception> result =
            api.getUser(event.username, sha256Password.toString());

        result.whenSuccess((success) {
          emit(LoginSuccess(success));
        });
        result.whenError((error) {
          emit(LoginError(error));
        });
      } catch (error) {
        emit(LoginError(Exception(I18n.exceptionLogin)));
      }
    });
  }
}
