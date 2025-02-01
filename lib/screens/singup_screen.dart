import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat/constints.dart';
import 'package:scholar_chat/helper/showbar.dart';
import 'package:scholar_chat/screens/chat_screen.dart';
import 'package:scholar_chat/screens/cubits/chat_cubit/chat_cubit.dart';
import 'package:scholar_chat/screens/cubits/singup_cubit/singup_cubit.dart';
import 'package:scholar_chat/widgets/mybutton.dart';
import 'package:scholar_chat/widgets/mytextfield.dart';

class SignupPage extends StatelessWidget {
  static String id = 'singupPage';
  String? email, pass;

  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupCubit, SignupState>(
      listener: (context, state) {
        if (state is SignupLoading) {
          isLoading = true;
        } else if (state is SignupSuccess) {
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
        } else if (state is SignupFailure) {
          showBar(
            context,
            text: state.errorMessage,
            color: Colors.red,
          );
          isLoading = false;
        }
      },
      builder: (context, state) {
        return SafeArea(
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
                              'Register',
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
                      // Get email from textfield
                      MyFormTextField(
                        hint: 'Email',
                        onCahnged: (data) {
                          email = data;
                        },
                      ),
                      // Get password from textfield
                      MyFormTextField(
                        hint: 'Password',
                        onCahnged: (data) {
                          pass = data;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: MyButton(
                          text: 'Sign up',
                          // Handle sign up with Firebase
                          function: () async {
                            if (formKey.currentState!.validate()) {
                              BlocProvider.of<SignupCubit>(context)
                                  .registerUser(email: email!, pass: pass!);
                            }
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Already have an account?',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Login',
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
        );
      },
    );
  }
}
