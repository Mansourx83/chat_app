import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

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
        emit(LoginFailure(errorMessage: 'user not found'));
      } else if (e.code == 'wrong-password') {
        emit(LoginFailure(errorMessage: 'wrong password'));
      }
    } on Exception catch (e) {
      emit(LoginFailure(errorMessage: 'Something went wrong'));
    }
  }

  Future<void> registerUser(
      {required String email, required String pass}) async {
    emit(SignupLoading());
    try {
      UserCredential user =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );
      emit(SignupSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(SignupFailure(errorMessage: 'weak password'));
      } else if (e.code == 'email-already-in-use') {
        emit(SignupFailure(errorMessage: 'email already in use'));
      }
    } on Exception catch (e) {
      emit(SignupFailure(errorMessage: 'there was an error pleas try again'));
    }
  }
}
