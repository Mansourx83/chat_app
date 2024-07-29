import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat/constints.dart';
import 'package:scholar_chat/screens/chat_screen.dart';
import 'package:scholar_chat/widgets/mybutton.dart';
import 'package:scholar_chat/widgets/mytextfield.dart';
import 'package:scholar_chat/helper/showbar.dart';

class SingupPage extends StatefulWidget {
  SingupPage({super.key});
  static String id = 'singupPage';

  @override
  State<SingupPage> createState() => _SingupPageState();
}

class _SingupPageState extends State<SingupPage> {
  String? email, pass;

  bool isLoading = false;
  bool _isObscure = true;

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
                    isPassword: true,
                    obscureText: _isObscure,
                    iconButton: IconButton(
                      icon: Icon(
                        _isObscure ? Icons.visibility : Icons.visibility_off,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                    ),
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
                          setState(() {
                            isLoading = true;
                          });
                          try {
                            await registerUser();
                            showBar(context,
                                text: 'The account is created.',
                                color: Colors.green);
                            Navigator.pushNamedAndRemoveUntil(
                                context, ChatPage.id, (route) => false,
                                arguments: email);
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'weak-password') {
                              showBar(context,
                                  text: 'The password is too weak',
                                  color: Colors.red);
                            } else if (e.code == 'email-already-in-use') {
                              showBar(context,
                                  text:
                                      'The account already exists for that email.',
                                  color: Colors.red);
                            }
                          } catch (e) {
                            showBar(context,
                                text: 'An error occurred. Please try again.',
                                color: Colors.red);
                            print(e);
                          }
                          setState(() {
                            isLoading = false;
                          });
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
  }

  // Default Firebase registration
  Future<void> registerUser() async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email!,
      password: pass!,
    );
  }
}
