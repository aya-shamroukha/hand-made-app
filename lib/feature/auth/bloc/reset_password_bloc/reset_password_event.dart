import 'package:hand_made_app/core/domin/model/auth_model/reset_password_model.dart';

class ResetPasswordEvent  {
  const ResetPasswordEvent();


}

class SendEmailEvent extends ResetPasswordEvent {
  final SendEmailModel sendEmailModel;

  const SendEmailEvent({required this.sendEmailModel});
}

class SendCodeEvent extends ResetPasswordEvent {
  final SendCodeModel sendCodeModel;

  const SendCodeEvent({required this.sendCodeModel});
}

class SendNewPasswordEvent extends ResetPasswordEvent {
  final SendPasswordModel sendPasswordModel;

  const SendNewPasswordEvent(this.sendPasswordModel);
}
