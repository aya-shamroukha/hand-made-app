import 'package:hand_made_app/core/domin/model/auth_model/signup_model.dart';

class SignUpEvent {}

class SignUpSuccess extends SignUpEvent {
  final SignUpModel signUpModel;

  SignUpSuccess(this.signUpModel);
}

class SignUpField extends SignUpEvent {}

class SignUpLoading extends SignUpEvent {}

class PasswordEvent extends SignUpEvent {
  final bool isScreat;

  PasswordEvent(this.isScreat);
}
