import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:visuamos/ui/colors/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:visuamos/ui/screens/simple_image.dart';
import 'package:visuamos/ui/screens/balance_slip_form.dart';
import 'package:visuamos/ui/screens/dashboard.dart';
import 'package:visuamos/ui/screens/login.dart';
import 'package:visuamos/ui/screens/onboarding.dart';
import 'package:visuamos/ui/screens/signup.dart';
import 'package:visuamos/ui/widgets/balanceSlipWidget.dart';
import 'package:visuamos/ui/widgets/bankStatementWidget.dart';
import 'package:visuamos/ui/widgets/dreamCheckWidget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(428, 926),
        builder: (context, child) {
          return MaterialApp(
            theme: ThemeData(
              inputDecorationTheme: const InputDecorationTheme(
                floatingLabelStyle: TextStyle(color: darkBlue),
              ),
              fontFamily: 'Merriweather',
            ),
            home: child,
            debugShowCheckedModeBanner: false,
          );
        },
        child: Dashboard());
  }
}
