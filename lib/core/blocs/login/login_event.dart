part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class LogUserIn extends LoginEvent {
  final String username;
  final String password;

  LogUserIn({
    required this.username,
    required this.password,
  });
}
