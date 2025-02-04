import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat/constints.dart';
import 'package:scholar_chat/screens/chat_screen.dart';
import 'package:scholar_chat/screens/cubits/auth_cubit/auth_cubit.dart';
import 'package:scholar_chat/screens/cubits/chat_cubit/chat_cubit.dart';
import 'package:scholar_chat/screens/singup_screen.dart';
import 'package:scholar_chat/widgets/mybutton.dart';
import 'package:scholar_chat/widgets/mytextfield.dart';
import 'package:scholar_chat/helper/showbar.dart';

class LoginPage extends StatelessWidget {
  String? email, pass;
  static String id = 'LoginPage';

  bool isLoading = false;
  bool _isObscure = true;

  GlobalKey<FormState> formKey = GlobalKey();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          isLoading = true;
        } else if (state is LoginSuccess) {
          showBar(
            context,
            text: 'Login Success',
            color: Colors.green,
          );
          BlocProvider.of<ChatCubit>(context).getMessage();
          isLoading = false;
          Navigator.pushNamed(
            context,
            ChatPage.id,
            arguments: email,
          );
        } else if (state is LoginFailure) {
          showBar(
            context,
            text: state.errorMessage,
            color: Colors.red,
          );
          isLoading = false;
        }
      },
      child: SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: isLoading,
          color: kPrimaryColor,
          child: Scaffold(
            backgroundColor: kPrimaryColor,
            body: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 120,
                    ),
                    Image.asset(kLogo),
                    const Text(
                      'Scholar Chat',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'pacifico',
                        fontSize: 30,
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 14),
                          child: Text(
                            'Log In',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontFamily: 'pacifico',
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    MyFormTextField(
                      hint: 'Email',
                      onCahnged: (data) {
                        email = data;
                      },
                    ),
                    MyFormTextField(
                      isPassword: true,
                      obscureText: _isObscure,
                      iconButton: IconButton(
                        icon: Icon(
                          _isObscure ? Icons.visibility : Icons.visibility_off,
                          color: Colors.white,
                        ),
                        onPressed: () {},
                      ),
                      hint: 'Password',
                      onCahnged: (data) {
                        pass = data;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MyButton(
                        text: 'Login',
                        function: () async {
                          if (formKey.currentState!.validate()) {
                            BlocProvider.of<AuthCubit>(context)
                                .signInWithEmailAndPass(
                                    email: email!, pass: pass!);
                          }
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Don\'t have an account?',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, SignupPage.id);
                          },
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white30,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
