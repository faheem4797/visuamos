import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visuamos/services/authService.dart';
import 'package:visuamos/ui/colors/colors.dart';
import 'package:visuamos/ui/screens/dashboard.dart';
import 'package:visuamos/ui/screens/signup.dart';
import 'package:visuamos/ui/widgets/customTextFormField.dart';

class Login extends StatefulWidget {
  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool isLoading = false;

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
                            return 'Please enter a valid email';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: 20.h,
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
                      SizedBox(
                        height: 40.h,
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

                                final message = await AuthService().login(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                );
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
                                    'Login',
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
                                text: "Don't have an account yet? ",
                                style: GoogleFonts.outfit(
                                    textStyle:
                                        TextStyle(color: white, fontSize: 16)),
                              ),
                              TextSpan(
                                  style: GoogleFonts.outfit(
                                      textStyle: TextStyle(
                                          color: white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)),
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
      ),
    );
  }
}
