import 'package:flutter/material.dart';
import 'package:weather_test_sncf/res/i18n.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(I18n.noViewError)),
    );
  }
}
