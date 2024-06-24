import 'package:flutter/material.dart';
import 'package:scholar_chat/constints.dart';
import 'package:scholar_chat/screens/singup_screen.dart';
import 'package:scholar_chat/widgets/mybutton.dart';
import 'package:scholar_chat/widgets/mytextfield.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  static String id = 'LoginPage';
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
               MyTextField(
                hint: 'Email', onCahnged: (String ) {  },
              ),
              MyTextField(
                hint: 'Password', onCahnged: (String ) {  },
              ),
               Padding(
                padding: const EdgeInsets.all(8.0),
                child: MyButton(
                  text: 'Login', function: () {  },
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
    );
  }
}
