import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {  
  @override
  List<Object> get props => [];

  String? get token => null;

  String? get userSlug => null;
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class Authenticated extends AuthState {

  @override
  final String token;

  @override
  final String userSlug;

  Authenticated(this.token,this.userSlug);

  @override
  List<Object> get props => [token,userSlug];
}

class UnAuthenticated extends AuthState {

  @override
  List<Object> get props => [];
}

class AuthFailure extends AuthState {

  final String error;
  AuthFailure(this.error);

  @override

  List<Object> get props => [error];

}
