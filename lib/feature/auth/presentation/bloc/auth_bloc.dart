import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/feature/auth/domain/use_cases/sign_in_email.dart';
import 'package:todo_app/feature/auth/domain/use_cases/sign_out.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignInWithGoogle _google;
  final UserSignOut _signOut;
  AuthBloc(
      {
      required UserSignInWithGoogle google,
      required UserSignOut signOut}):
        _google = google,
        _signOut = signOut,
        super(AuthInitial()) {

    // Login Bloc
    on<AuthSignInGoogle>((event, emit) async {
      emit(AuthLoading());
      try {
        await _google({});
        emit(AuthSuccess('Signed in successfully'));
      } catch (e) {
        emit(AuthFailure(''));
      }
    });

    // Sign Out Bloc
    on<AuthSignOut>((event, emit) async {
      emit(AuthLoading());
      try {
        await _signOut({});
        emit(AuthSuccess('Signed out successfully'));
      } catch (e) {
        emit(AuthFailure(''));
      }
    });
  }
}
