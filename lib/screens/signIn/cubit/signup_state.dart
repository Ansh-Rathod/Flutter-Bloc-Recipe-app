part of 'signup_cubit.dart';

enum SignupStatus { intial, loading, error, success }

class SignupState extends Equatable {
  final Failure error;
  final SignupStatus status;
  SignupState({
    @required this.error,
    @required this.status,
  });
  factory SignupState.intial() {
    return SignupState(
      error: Failure(),
      status: SignupStatus.intial,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [error, status];

  SignupState copyWith({
    Failure error,
    SignupStatus status,
  }) {
    return SignupState(
      error: error ?? this.error,
      status: status ?? this.status,
    );
  }
}
