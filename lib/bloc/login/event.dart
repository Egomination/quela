import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class LoginEvents extends Equatable {
  LoginEvents([List props = const []]) : super(props);
}

class ButtonPressed extends LoginEvents {
  final String email;
  final String password;

  ButtonPressed({
    @required this.email,
    @required this.password,
  }) : super([email, password]);

  @override
  String toString() =>
      'LoginButtonPressed { email: $email, password: $password }';
}
