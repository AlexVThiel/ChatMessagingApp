import 'dart:async';

import 'package:chat_app/screens/chats/main_chat_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../core/constants/icons.dart';
import 'auth/signin_page.dart';
import 'home_nav_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});
  static const routeName = '/splashPage';

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
    /*_timer = Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushNamed(SignInPage.routeName);
    });*/
  }

  Future<void> _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 2)); // Simulate loading

    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // User is already signed in, navigate to home screen
      Navigator.pushReplacementNamed(context, HomeNavPage.routeName);
    } else {
      // User is not signed in, navigate to sign-in screen
      Navigator.pushReplacementNamed(context, SignInPage.routeName);
    }
  }

  @override
  void dispose() {
    super.dispose();

    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        color: const Color(0xFF1B52AC),
        child: Center(
          child: icApp,
        ),
      ),
    );
  }
}
