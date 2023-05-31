import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visuamos/ui/colors/colors.dart';
import 'package:visuamos/ui/screens/dashboard.dart';
import 'package:visuamos/ui/screens/login.dart';
import 'package:visuamos/ui/widgets/customTextFormField.dart';

import '../../services/authService.dart';

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
  bool isLoading = false;

  Future<void> _launchURL() async {
    const url =
        'https://github.com/visuamos/visuamos-policy/blob/main/privacy-policy.md';
    final uri = Uri.parse(url);
    if (!await launchUrl(
      uri,
      mode: LaunchMode.platformDefault,
    )) {
      throw "Can not launch url";
    }
  }

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
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [lightBlueGradient, purpleGradient])),
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          'Make Your Dreams Come True',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: white,
                            fontSize: 34.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Image.asset(
                        'assets/logo/logo510.png',
                        fit: BoxFit.fitHeight,
                        height: 150.h,
                      ),
                      SizedBox(height: 30.h),
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
                      SizedBox(
                        height: 10.h,
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
                      SizedBox(
                        height: 10.h,
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
                      SizedBox(
                        height: 10.h,
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
                      SizedBox(
                        height: 30.h,
                      ),
                      Center(
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text:
                                    'By clicking Create an Account, you agree to and have read our ',
                                style: GoogleFonts.outfit(
                                    textStyle: TextStyle(
                                  color: white,
                                  fontSize: 15.sp,
                                  //fontWeight: FontWeight.bold,
                                )),
                              ),
                              TextSpan(
                                  style: TextStyle(
                                    color: black,
                                    fontSize: 15.sp,
                                  ),
                                  text: 'Privacy Policy',
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () async {
                                      await _launchURL();
                                    }),
                              TextSpan(
                                  text: '.',
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 16.sp)),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Center(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  bottomButtonGradientPurple,
                                  bottomButtonGradientBlue
                                ]),
                            borderRadius: BorderRadius.circular(35.r),
                          ),
                          height: 70.h,
                          width: 260.w,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(35.r),
                                ),
                                backgroundColor: Colors.transparent,
                                textStyle: TextStyle(
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.w600)),
                            onPressed: () async {
                              FocusScope.of(context).unfocus();
                              final isValid = formKey.currentState?.validate();
                              if (isValid == true) {
                                formKey.currentState?.save();
                                setState(() {
                                  isLoading = true;
                                });
                                print('message');
                                final message =
                                    await AuthService().registration(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                );
                                print(message);
                                setState(() {
                                  isLoading = false;
                                });
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
                            },
                            child: isLoading
                                ? Center(
                                    child: CircularProgressIndicator(
                                      color: white,
                                    ),
                                  )
                                : const Text(
                                    'Create an Account',
                                    textAlign: TextAlign.center,
                                  ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Center(
                        child: RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Already have an account? ',
                                style: GoogleFonts.outfit(
                                    textStyle:
                                        TextStyle(color: white, fontSize: 16)),
                              ),
                              TextSpan(
                                  style: GoogleFonts.outfit(
                                    textStyle: TextStyle(
                                        color: white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  text: 'Sign in',
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
      ),
    );
  }
}
