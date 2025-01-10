import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/screens/auth/signup_page.dart';
import 'package:chat_app/screens/splash_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/providers/auth_repository.dart';
import 'screens/auth/profile_page.dart';
import 'screens/auth/signin_page.dart';
import 'network/dependency_injection.dart';
import 'screens/onBoard/onboarding_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final prefs = await SharedPreferences.getInstance();
  final isFirst = prefs.getBool('firstOpen') ?? true;
  initializeDateFormatting().then((_) => runApp(MyApp(isFirst: isFirst)));

  DependencyInjection.init();
  //runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  final bool isFirst;
  const MyApp({
    super.key,
    required this.isFirst,
  });
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        RepositoryProvider(create: (ctx) => AuthRepository()),
        // ChangeNotifierProvider(create: (ctx) => CompRepository()),
      ],
      child: GetMaterialApp(
          title: 'Test Chat App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: const Color(0xFFf1f1f1),
            fontFamily: 'SukhumvitSet',
            colorScheme: ColorScheme.fromSwatch(
                    primarySwatch: Colors.blue,
                    accentColor: Colors.white,
                    backgroundColor: const Color(0xFFf1f1f1))
                .copyWith(
              secondary: Colors.grey.shade200,
            ),
            cardTheme: const CardTheme(
              color: Colors.white,
            ),
            checkboxTheme: CheckboxThemeData(
                side: const BorderSide(color: Colors.transparent),
                fillColor: WidgetStateColor.resolveWith(
                  (states) {
                    if (states.contains(WidgetState.selected)) {
                      return const Color.fromARGB(255, 255, 148,
                          148); // the color when checkbox is selected;
                    }
                    return Colors
                        .grey.shade300; //the color when checkbox is unselected;
                  },
                )),
            useMaterial3: true,
          ),
          home: const SplashPage(),
          routes: {
            SignInPage.routeName: (ctx) => const SignInPage(),
            SignUpPage.routeName: (ctx) => const SignUpPage(),
            ProfilePage.routeName: (ctx) => const ProfilePage(),
          }),
    );
  }
}
