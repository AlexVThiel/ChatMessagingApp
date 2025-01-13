import 'package:chat_app/core/constants/styles.dart';
import 'package:chat_app/core/widgets/auth/signIn_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/blocs/auth/auth_bloc.dart';
import '../../core/constants/icons.dart';
import '../../core/providers/auth_repository.dart';
import '../../core/widgets/auth/signup_card.dart';
import 'signup_page.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});
  static const routeName = '/signInPage';

  void goToSignUp(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(SignUpPage.routeName);
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
                        icAppSmall,
                        const Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Text(
                            'ChatApp',
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                    BlocBuilder<AuthenticationBloc, AuthState>(
                        builder: (context, state) {
                      /*   if (state is AuthLodingState) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        );
                      }*/
                      return Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 25, bottom: 20),
                            child: Text(
                              'Sign in to continue',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 15, right: 15),
                            child: SignInCard(),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 15, right: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  'Don\'t have account yet :',
                                  style: Constant.size12cW4,
                                ),
                                TextButton(
                                    onPressed: () {
                                      goToSignUp(context);
                                    },
                                    child: Text(
                                      textAlign: TextAlign.right,
                                      'Sign Up',
                                      style: Constant.size12cO4,
                                    ))
                              ],
                            ),
                          )
                        ],
                      );
                    }),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
