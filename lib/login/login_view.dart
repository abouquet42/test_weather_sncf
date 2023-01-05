import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_test_sncf/app_theme.dart';
import 'package:weather_test_sncf/core/blocs/forecast/get_forecast_bloc.dart';
import 'package:weather_test_sncf/core/blocs/login/login_bloc.dart';
import 'package:weather_test_sncf/core/enums/unit_temp.dart';
import 'package:weather_test_sncf/helpers/constants.dart';
import 'package:weather_test_sncf/res/i18n.dart';

import '../routes.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(),
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            BlocProvider.of<GetForecastBloc>(context)
                .add(GetForecast(unit: UnitTemp.celsius));
            Navigator.of(context)
                .pushNamed(AppRoutes.routeWeather, arguments: state.user.name);
          }
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppTheme.of(context)!.colors.primary,
            centerTitle: true,
            title: Text(I18n.loginTitle),
          ),
          body: const ContentLogin(),
        ),
      ),
    );
  }
}

class ContentLogin extends StatefulWidget {
  const ContentLogin({
    Key? key,
  }) : super(key: key);

  @override
  State<ContentLogin> createState() => _ContentLoginState();
}

class _ContentLoginState extends State<ContentLogin> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildTextFieldUsername(),
        buildTextFieldPassword(),
        const SizedBox(height: 16),
        buildError(context),
        const Spacer(),
        buildValidateButton(context),
        const SizedBox(height: 64),
      ],
    );
  }

  Widget buildError(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (BuildContext context, LoginState state) {
        if (state is LoginError) {
          return Text(
            state.error.toString().replaceAll('${I18n.exceptionText} ', ''),
            style: AppTheme.of(context)?.textStyles.error,
          );
        }
        return const SizedBox();
      },
    );
  }

  Padding buildTextFieldUsername() {
    return Padding(
      key: const Key(loginEmailKey),
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            I18n.emailText,
            style: AppTheme.of(context)?.textStyles.titleTextField,
          ),
          const SizedBox(height: 8),
          TextField(
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            controller: usernameController,
            decoration: buildInputDecoration(context),
          ),
        ],
      ),
    );
  }

  Padding buildTextFieldPassword() {
    return Padding(
      key: const Key(loginPasswordKey),
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            I18n.passwordText,
            style: AppTheme.of(context)?.textStyles.titleTextField,
          ),
          const SizedBox(height: 8),
          TextField(
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            controller: passwordController,
            obscureText: true,
            decoration: buildInputDecoration(context),
            onSubmitted: (String text) async {
              loginAction(context);
            },
          ),
        ],
      ),
    );
  }

  InkWell buildValidateButton(BuildContext context) {
    return InkWell(
      key: const Key(loginValidateKey),
      onTap: () {
        loginAction(context);
      },
      child: Container(
        height: 50,
        width: 150,
        decoration: BoxDecoration(
          color: AppTheme.of(context)?.colors.primary,
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Center(
          child: Text(
            I18n.validateButton,
            style: AppTheme.of(context)?.textStyles.textButton,
          ),
        ),
      ),
    );
  }

  void loginAction(BuildContext context) {
    BlocProvider.of<LoginBloc>(context).add(
      LogUserIn(
        username: usernameController.text,
        password: passwordController.text,
      ),
    );
  }

  InputDecoration buildInputDecoration(BuildContext context) {
    return InputDecoration(
      border: OutlineInputBorder(
        borderRadius: AppTheme.of(context)!.values.defaultBorderRadius,
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppTheme.of(context)!.colors.primary,
          width: 2.0,
        ),
        borderRadius: AppTheme.of(context)!.values.defaultBorderRadius,
      ),
    );
  }
}
