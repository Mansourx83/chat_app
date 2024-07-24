import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat/constints.dart';
import 'package:scholar_chat/screens/chat_screen.dart';
import 'package:scholar_chat/screens/singup_screen.dart';
import 'package:scholar_chat/widgets/mybutton.dart';
import 'package:scholar_chat/widgets/mytextfield.dart';
import 'package:scholar_chat/helper/showbar.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});
  static String id = 'LoginPage';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? email, pass;

  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
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
                          isLoading = true;
                          setState(() {});
                          try {
                            await sinInWithEmailAndPass();
                            Navigator.pushNamedAndRemoveUntil(
                                context, ChatPage.id, (route) => false);
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'user-not-found') {
                              showBar(context,
                                  text: 'No user found for that email.',
                                  color: Colors.red);
                            } else if (e.code == 'wrong-password') {
                              showBar(context,
                                  text:
                                      'Wrong password provided for that user.',
                                  color: Colors.red);
                            }
                          } catch (e) {
                            showBar(context,
                                text: 'An error occurred. Please try again.',
                                color: Colors.red);
                            print(e);
                          }
                          isLoading = false;
                          setState(() {});
                        } else
                          () {};
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Dont have any account ?',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, SingupPage.id);
                        },
                        child: const Text(
                          'Sing Up',
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
  }

  Future<void> sinInWithEmailAndPass() async {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email!,
      password: pass!,
    );
  }
}
