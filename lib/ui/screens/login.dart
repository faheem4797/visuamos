import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:visuamos/services/authService.dart';
import 'package:visuamos/ui/colors/colors.dart';
import 'package:visuamos/ui/screens/dashboard.dart';
import 'package:visuamos/ui/screens/signup.dart';
import 'package:visuamos/ui/widgets/appBarEveryWhere.dart';
import 'package:visuamos/ui/widgets/customTextFormField.dart';

import '../widgets/CommonBottomButton.dart';

class Login extends StatefulWidget {
  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const AppBarEveryWhere(
          title: 'Login',
          isIconRequired: false,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextFormField(
                      controller: _emailController,
                      hintText: 'Enter your email here',
                      labelText: 'Email',
                      textInputType: TextInputType.emailAddress,
                      validator: (value) {
                        if (_emailController.text == '') {
                          return 'Please enter an amount';
                        } else if (!RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(_emailController.text)) {
                          return 'Please enter a valid amount';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextFormField(
                      controller: _passwordController,
                      hintText: 'Enter your password here',
                      labelText: 'Password',
                      textInputType: TextInputType.emailAddress,
                      obscureText: true,
                      validator: (value) {
                        if (_passwordController.text == '') {
                          return 'Please enter a password';
                        } else if (_passwordController.text.length < 8) {
                          return 'Please enter a valid password';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Center(
                      child: CommonBottomButton(
                          title: 'Login',
                          bottomButtonCallBackFunc: () async {
                            final isValid = formKey.currentState?.validate();
                            if (isValid == true) {
                              formKey.currentState?.save();
                              final message = await AuthService().login(
                                email: _emailController.text,
                                password: _passwordController.text,
                              );
                              if (message!.contains('Success')) {
                                if (!mounted) return;
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Dashboard()));
                              }
                              if (!mounted) return;
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(message),
                                ),
                              );
                            }
                          }),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            const TextSpan(
                                text: "Don't have an account? ",
                                style: TextStyle(color: black, fontSize: 16)),
                            TextSpan(
                                style: const TextStyle(
                                    color: darkBlue, fontSize: 18),
                                text: 'Sign Up',
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) => SignUp()));
                                  }),
                          ],
                        ),
                      ),
                    ),
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
