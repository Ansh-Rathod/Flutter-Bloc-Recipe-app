part of 'login_cubit.dart';

enum LoginStatus { inital, loading, success, error }

class LoginState extends Equatable {
  final LoginStatus status;
  final Failure error;
  LoginState({
    @required this.status,
    @required this.error,
  });
  factory LoginState.initial() {
    return LoginState(status: LoginStatus.inital, error: Failure());
  }
  @override
  bool get stringify => true;
  @override
  List<Object> get props => [status, error];

  LoginState copyWith({
    LoginStatus status,
    Failure error,
    bool isShow,
  }) {
    return LoginState(
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}
