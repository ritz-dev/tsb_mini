import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:tsb_mini/bloc/auth_event.dart';
import 'package:tsb_mini/bloc/auth_state.dart';
import 'package:tsb_mini/services/auth/auth_service.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {

  final AuthService authService;
  
  AuthBloc({required this.authService}) : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<LogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onLoginRequested(LoginRequested event,Emitter<AuthState> emit) async{
    emit(AuthLoading());

    try{

      final authResponse = await authService.login(email: event.email,password: event.password);

      // debugPrint('Token is $authResponse');

      emit(Authenticated(authResponse.token,authResponse.slug));

    }catch(e){
     emit(AuthFailure(e.toString()));
     debugPrint('Login failed with error: $e');
    }
  }

  Future<void> _onLogoutRequested(LogoutRequested event, Emitter<AuthState> emit) async {
    await authService.logout();
    emit(UnAuthenticated());
  }
}
