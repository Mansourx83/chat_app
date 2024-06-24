import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scholar_chat/constints.dart';
import 'package:scholar_chat/widgets/mybutton.dart';
import 'package:scholar_chat/widgets/mytextfield.dart';

class SingupPage extends StatelessWidget {
  SingupPage({super.key});
  static String id = 'singupPage';
  String? email;
  String? pass;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 120,
              ),
              Image.asset('assets/images/scholar.png'),
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
              MyTextField(
                hint: 'Email',
                onCahnged: (data) {
                  email = data;
                },
              ),
              MyTextField(
                hint: 'Password',
                onCahnged: (data) {
                  pass = data;
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MyButton(
                  text: 'Signup',
                  function: () async {
                    try {
                      await registerUser();
                      showBar(context,
                          text: 'The account is created.', color: Colors.green);
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        showBar(context,
                            text: 'The password is too weak',
                            color: Colors.red);
                      } else if (e.code == 'email-already-in-use') {
                        showBar(context,
                            text: 'The account already exists for that email.',
                            color: Colors.red);
                      }
                    } catch (e) {
                      print(e);
                    }
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account',
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
    );
  }

  void showBar(BuildContext context,
      {required String text, required Color color}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        backgroundColor: color,
      ),
    );
  }

  Future<void> registerUser() async {
    final user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email!,
      password: pass!,
    );
  }
}
