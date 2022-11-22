import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:visuamos/ui/colors/colors.dart';
import 'package:visuamos/ui/screens/dashboard.dart';
import 'package:visuamos/ui/screens/login.dart';
import 'package:visuamos/ui/widgets/appBarEveryWhere.dart';
import 'package:visuamos/ui/widgets/customTextFormField.dart';

import '../../services/authService.dart';
import '../widgets/CommonBottomButton.dart';

class SignUp extends StatefulWidget {
  SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const AppBarEveryWhere(
          title: 'Sign Up',
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
                      controller: _nameController,
                      hintText: 'Enter your name here',
                      labelText: 'Name',
                      validator: (value) {
                        if (_nameController.text == '') {
                          return 'Please enter a name';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextFormField(
                      controller: _emailController,
                      hintText: 'Enter your email here',
                      labelText: 'Email',
                      textInputType: TextInputType.emailAddress,
                      validator: (value) {
                        if (_emailController.text == '') {
                          return 'Please enter an email';
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
                      height: 10,
                    ),
                    CustomTextFormField(
                      controller: _passwordController,
                      hintText: 'Enter your password here',
                      labelText: 'Password',
                      textInputType: TextInputType.text,
                      obscureText: true,
                      validator: (value) {
                        if (_passwordController.text == '') {
                          return 'Please enter a password';
                        } else if (_passwordController.text.length < 8) {
                          return 'Password should atleast be 8 characters long';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextFormField(
                      controller: _confirmPasswordController,
                      hintText: 'Please re-enter your password here',
                      labelText: 'Confirm Password',
                      textInputType: TextInputType.text,
                      obscureText: true,
                      validator: (value) {
                        if (_confirmPasswordController.text == '') {
                          return 'Please enter a password';
                        } else if (_passwordController.text !=
                            _confirmPasswordController.text) {
                          return "Password doesn't match";
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
                          title: const Text(
                            'Create an Account',
                            textAlign: TextAlign.center,
                          ),
                          bottomButtonCallBackFunc: () async {
                            final isValid = formKey.currentState?.validate();
                            if (isValid == true) {
                              formKey.currentState?.save();
                              print('message');
                              final message = await AuthService().registration(
                                email: _emailController.text,
                                password: _passwordController.text,
                              );
                              print(message);
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
                                text: 'Already have an account? ',
                                style: TextStyle(color: black, fontSize: 16)),
                            TextSpan(
                                style: const TextStyle(
                                    color: darkBlue, fontSize: 18),
                                text: 'Login',
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) => Login()));
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
