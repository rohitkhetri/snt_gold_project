// import 'package:snt_gold_project/bloc/auth_repo.dart';
// import 'package:snt_gold_project/bloc/auth_state.dart';
// import 'package:snt_gold_project/bloc/login_event.dart';
// import 'package:snt_gold_project/Model/login_state.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class LoginBloc extends Bloc<AuthEvent, LoginState> {
//     final AuthRepository authRepository;

//     AuthBloc(this.authRepository) : super(AuthInitial()){
//         on<LoginEvent>((event, emit) async{
//             emit(AuthLoading());
//             try{
//                 final token = await authRepository.login(event., password)
//             }
//         })
//     }
  
// }