import 'package:chat_app/core/models/user.dart';
import 'package:chat_app/screens/auth/signup_page.dart';
import 'package:chat_app/screens/chats/chat_room_page.dart';
import 'package:chat_app/screens/chats/new_chat_page.dart';
import 'package:chat_app/screens/splash_page.dart';
import 'package:flutter/material.dart';

import '../../screens/auth/signin_page.dart';
import '../../screens/home_nav_page.dart';

class RouteUtils {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/splashPage':
        return MaterialPageRoute(builder: (context) => const SplashPage());
      // Auth
      case '/signUpPage':
        return MaterialPageRoute(builder: (context) => const SignUpPage());
      case '/signInPage':
        return MaterialPageRoute(builder: (context) => const SignInPage());
      case '/mainPage':
        return MaterialPageRoute(
            builder: (context) => HomeNavPage(
                  tabIndex: 0,
                ));
      case '/newChatPage':
        return MaterialPageRoute(builder: (context) => const NewChatPage());
      case '/chatRoomPage':
        return MaterialPageRoute(
            builder: (context) => ChatRoomPage(
                  receiver: args as UserM,
                ));

      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(child: Text("No Route Found")),
          ),
        );
    }
  }
}
