import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:govt_billing/data/repo/auth_repo.dart';

part 'auth_state.dart';

// part

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo userRepo;

  AuthCubit(this.userRepo) : super(const AuthState()) {
    checkLoginToken();
  }

  checkLoginToken() async {}

  loginUser(String email, String password) async {}

  logoutUser() async {
    emit(const AuthState());
  }
}
