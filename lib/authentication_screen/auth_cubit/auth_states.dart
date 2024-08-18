abstract class AuthStates {}

class AuthInitialState extends AuthStates {}

class AuthLoadingState extends AuthStates {}

class RegisterSuccessState extends AuthStates {

  final String messagesucess;
  RegisterSuccessState({required this.messagesucess});
}

class RegisterErrorState extends AuthStates {

  final String message;
  RegisterErrorState({required this.message});
}

//

class LoginSuccessState extends AuthStates {
  final String messagesucess;
  LoginSuccessState({required this.messagesucess});
}

class LoginErrorState extends AuthStates {
  final String message;
  LoginErrorState({required this.message});
}
class logloadingState extends AuthStates {}

class LogoutSuccessState extends AuthStates {
  final String message;
  LogoutSuccessState({required this.message});
}
class LogoutErrorState extends AuthStates {
  final String message;
  LogoutErrorState({required this.message});
}

 class SuccessBannerState extends AuthStates {}
  class ErrorBannerState extends AuthStates {
    final String error;
    ErrorBannerState({required this.error});
  }
   class LoadingBannerState extends AuthStates {}