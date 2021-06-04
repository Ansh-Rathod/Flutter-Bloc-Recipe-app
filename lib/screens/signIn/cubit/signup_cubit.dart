import 'package:bloc/bloc.dart';
import 'package:racipi/models/failure.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:racipi/repo/auth_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final repo = AuthRepo();
  SignupCubit() : super(SignupState.intial());

  Future<bool> submit(String email, String pass) async {
    emit(state.copyWith(status: SignupStatus.loading));
    try {
      await repo.signup(email, pass);

      SharedPreferences prefrences = await SharedPreferences.getInstance();
      prefrences.setBool('isLogin', true);
      emit(state.copyWith(status: SignupStatus.success));
      return true;
    } on Failure catch (e) {
      emit(state.copyWith(status: SignupStatus.error, error: e));
      return false;
    }
  }
}
