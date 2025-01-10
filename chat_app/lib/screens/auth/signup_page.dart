import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/blocs/auth/auth_bloc.dart';
import '../../core/constants/styles.dart';
import '../../core/providers/auth_repository.dart';
import '../../core/widgets/auth/signup_card.dart';
import 'signin_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});
  static const routeName = '/signUpPage';

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  void goToSignIn(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(SignInPage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => AuthenticationBloc(
        RepositoryProvider.of<AuthRepository>(context),
      )..add(CheckAuth()),
      child: Scaffold(
        body: Container(
          height: double.infinity,
          color: const Color(0xFF1B52AC),
          child: SingleChildScrollView(
            child: SizedBox(
              height: deviceSize.height,
              width: deviceSize.width,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        /* Image.asset(
                      'assets/logo.png',
                      fit: BoxFit.cover,
                      height: 30,
                    ),*/
                        const Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Text(
                            'Create Account',
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Constant.sizedBoxH20,
                    const Padding(
                      padding: EdgeInsets.only(left: 15, right: 15),
                      child: SignUpCard(),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Alraedy have account',
                            style: Constant.size12cW4,
                          ),
                          TextButton(
                              onPressed: () {
                                goToSignIn(context);
                              },
                              child: Text(
                                textAlign: TextAlign.right,
                                'Sign In',
                                style: Constant.size12cO4,
                              ))
                        ],
                      ),
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
