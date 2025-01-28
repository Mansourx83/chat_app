import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> signInWithEmailAndPass({
    required String email,
    required String pass,
  }) async {
    emit(LoginLoading());
    try {
      UserCredential user =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: pass,
      );
      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(LoginFailure(errorMessage:'user not found' ));
      } else if (e.code == 'wrong-password') {
        emit(LoginFailure(errorMessage:'wrong password' ));
      }
    } on Exception catch (e) {
      emit(LoginFailure(errorMessage: 'Something went wrong'));
    }
  }
}
