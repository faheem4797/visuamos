import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:visuamos/ui/colors/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:visuamos/ui/screens/login.dart';

//TODO: MAKE ANDROID ICON BETTER AND FIT THE AVATAR CIRCLE

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Stripe.publishableKey =
  'pk_test_51MMw6GBP9cs9PLZwOy2k01XDMoqz2ZeQaNdQUsbV5rPGTa9hv32aXNHPfOQflxmkru7hxqLgUwtgIPXbvSXBeGS400wNIjMJ0U';

  await Stripe.instance.applySettings();
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
              fontFamily: 'OpenSans',
            ),
            home: child,
            debugShowCheckedModeBanner: false,
          );
        },
        child: Login());
  }
}
