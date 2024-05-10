import 'package:flutter/material.dart';
import 'package:flutter_manajemen_waktu/Screens/Dashboard/dashboard_screen.dart';
import 'package:flutter_manajemen_waktu/Screens/Profile/profile_screen.dart';
import 'package:flutter_manajemen_waktu/Screens/SignIn/login_screen.dart';
import 'package:flutter_manajemen_waktu/Screens/Signup/signup_screen.dart';
import 'package:flutter_manajemen_waktu/Screens/Welcome/welcome_screen.dart';
import 'package:flutter_manajemen_waktu/constants.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sistem Manajemen Waktu',
      initialRoute: "/",
      routes: {
        "/welcome": (context) => const WelcomeScreen(),
        "/login": (context) => const LoginScreen(),
        "/signup": (context) => const SignUpScreen(),
        "/dashboard": (context) => const DashboardScreen(),
        "/profile": (context) => const ProfileScreen(),
      },
      theme: ThemeData(
          iconTheme: const IconThemeData(color: kPrimaryColor),
          scaffoldBackgroundColor: Colors.white,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              foregroundColor: Colors.white,
              shape: const StadiumBorder(),
              maximumSize: const Size(double.infinity, 56),
              minimumSize: const Size(double.infinity, 56),
            ),
          ),
          inputDecorationTheme: const InputDecorationTheme(
            filled: true,
            contentPadding: EdgeInsets.symmetric(
              horizontal: defaultPadding,
              vertical: defaultPadding,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              borderSide: BorderSide.none,
            ),
          )),
      home: const DashboardScreen(),
    );
  }
}
