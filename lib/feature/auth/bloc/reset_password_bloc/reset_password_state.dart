class ResetPasswordState {
  const ResetPasswordState();
}

final class ResetPasswordInitial extends ResetPasswordState {}

class SendEmailSuccessState extends ResetPasswordState {}

class SendEmailLoadingState extends ResetPasswordState {}

class SendEmailFieldState extends ResetPasswordState {}

class SendCodeSuccessState extends ResetPasswordState {}

class SendCodeLoadingState extends ResetPasswordState {}

class SendCodeFieldState extends ResetPasswordState {}

class SendNewPasswordSuccessState extends ResetPasswordState {}

class SendNewPasswordLoadingState extends ResetPasswordState {}

class SendNewPasswordFieldState extends ResetPasswordState {}
