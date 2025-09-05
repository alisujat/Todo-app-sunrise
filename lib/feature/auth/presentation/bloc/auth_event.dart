part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}


final class AuthSignInGoogle extends AuthEvent {
  AuthSignInGoogle();
}


final class AuthSignOut extends AuthEvent {
  AuthSignOut();
}
