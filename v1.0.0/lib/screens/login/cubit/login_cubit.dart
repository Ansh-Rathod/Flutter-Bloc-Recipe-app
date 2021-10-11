import 'package:bloc/bloc.dart';
import 'package:racipi/models/failure.dart';
import 'package:racipi/repo/auth_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final repo = AuthRepo();
  LoginCubit() : super(LoginState.initial());

  Future<bool> login(String email, String pass) async {
    emit(state.copyWith(status: LoginStatus.loading));
    try {
      await repo.login(email, pass);
      SharedPreferences prefrences = await SharedPreferences.getInstance();
      prefrences.setBool('isLogin', true);

      emit(state.copyWith(status: LoginStatus.success));
      return true;
    } on Failure catch (e) {
      emit(state.copyWith(status: LoginStatus.error, error: e));
      return false;
    }
  }
}
