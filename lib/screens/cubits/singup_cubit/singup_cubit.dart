import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial());

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
