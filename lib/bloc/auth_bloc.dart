import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snt_gold_project/bloc/auth_repo.dart';
import 'package:snt_gold_project/bloc/auth_state.dart';
import 'package:snt_gold_project/bloc/login_event.dart';

class AuthBloc extends Bloc<AuthEvent,  AuthState> {
  final AuthRepository authRepository;
  // AuthBloc(this.authRepository) : super(AuthInitial());

  AuthBloc(this.authRepository) : super(AuthInitial()) {
    on<LoginEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final token = await authRepository.login(event.email, event.password);
        emit(Authenticated(token));
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    on<RegisterEvent>((event, emit) async {
      emit(AuthLoading());
      try{
        await authRepository.register(event.userData);
        emit(AuthInitial());
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    on<LogoutEvent>((event, emit) async {
      emit(AuthLoading());
      try{
        await authRepository.logout(event.token);
        emit(AuthLoggedout());
      } catch(e) {
        emit(AuthError(e.toString()));
      }
    });
  }
  // @override
  // Stream<AuthState> mapEventToState(AuthEvent event) async* {
  //   if(event is LoginEvent){
  //     yield AuthLoading();
  //     try{
  //       final token = await authRepository.login(event.email, event.password);
  //       yield Authenticated(token);
  //     } catch (e) {
  //       yield AuthError(e.toString());
  //     }
  //   } else if ( event is RegisterEvent){
  //     yield AuthLoading();
  //     try{
  //       await authRepository.register(event.userData);
  //       yield AuthInitial();
  //     } catch(e){
  //       yield AuthError(e.toString());
  //     }
  //   } else if (event is LogoutEvent){
  //     yield AuthLoading();
  //     try{
  //       await authRepository.logout(event.token);
  //       yield AuthLoggedout();
  //     } catch (e) {
  //       yield AuthError(e.toString());
  //     }
  //   }
  // }
}