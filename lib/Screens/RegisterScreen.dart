import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:notetakingapp/Screens/LoginScreen.dart';
import 'package:notetakingapp/Widgets/TextInputField.dart';
import 'package:notetakingapp/Widgets/Text_Input_Field.dart';
import 'package:notetakingapp/utils/constant.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Container(),
                flex: 2,
              ),
              const SizedBox(
                height: 64,
              ),
              const SizedBox(
                height: 24,
              ),
              TextInputField(
                controller: _usernameController,
                icon: Icons.person,
                labelText: "UserName",
              ),
              const SizedBox(
                height: 24,
              ),
              TextInputField(
                controller: _emailController,
                icon: Icons.email,
                labelText: "Email",
              ),
              const SizedBox(
                height: 24,
              ),
              TextInputField(
                controller: _passwordController,
                icon: Icons.lock,
                labelText: "Password",
                isObscure: true,
              ),
              const SizedBox(
                height: 24,
              ),
              const SizedBox(
                height: 24,
              ),
              InkWell(
                onTap: () async {
                  // String response = await Auth_Methods()
                  //     .login(emailController.text, passwordController.text);
                  // if (response == "success") {
                  //   Navigator.pushReplacement(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) => const HomeScreen(),
                  //       ));
                  // } else {
                  //   customSnackBar(response, context);
                  // }
                },
                child: Container(
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  width: double.infinity,
                  color: Colors.red,
                  child: const Center(
                      child: Text(
                    "SignUp",
                    style: TextStyle(
                        color: primaryColor,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  )),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Flexible(
                child: Container(),
                flex: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: const Text(
                      'Already have an account?',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    ),
                    child: Container(
                      child: const Text(
                        ' Login.',
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                  ),
                ],
              ),
              Flexible(
                flex: 2,
                child: Container(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
