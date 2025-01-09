import 'package:chat_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/login_page.dart';
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
    return GetMaterialApp(
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
        home: widget.isFirst ? const OnBoardingPage() : const LoginPage(),
        routes: {
          LoginPage.routeName: (ctx) => const LoginPage(),
        });
  }
}
