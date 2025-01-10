import 'package:chat_app/screens/auth/signin_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/auth/auth_bloc.dart';
import '../../constants/icons.dart';
import '../../constants/styles.dart';

class SignUpCard extends StatefulWidget {
  const SignUpCard({super.key});

  @override
  State<SignUpCard> createState() => _SignUpCardState();
}

class _SignUpCardState extends State<SignUpCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  var _showPass = false, _showCPass = false;
  final _passController = TextEditingController();
  final _cPassController = TextEditingController();

  Widget _passwordField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: 'Password',
        hintStyle: Constant.size14cCC4,
        prefixIcon: icPass,
        suffixIcon: IconButton(
          icon: Icon(
            _showPass ? Icons.visibility : Icons.visibility_off,
            color: const Color(0xFF236BBD),
          ),
          onPressed: () {
            // Update the state i.e. toogle the state of passwordVisible variable
            setState(() {
              _showPass = !_showPass;
            });
          },
        ),
        border: outline,
        focusedBorder: outlineB,
      ),
      obscureText: !_showPass,
      controller: _passController,
      onChanged: (value) {
        _authData['password'] = value;
      },
      validator: (value) {
        if (value!.isEmpty || value.length < 8) {
          return 'Password is too short!';
        }
        return null;
      },
      onSaved: (value) {
        _authData['password'] = value!;
      },
    );
  }

  Widget _cPassField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: 'Confirm Password',
        hintStyle:
            Constant.size14cCC4, // const TextStyle(color: Color(0xFFADADAD)),
        prefixIcon: icPass,
        suffixIcon: IconButton(
          icon: Icon(
            _showPass ? Icons.visibility : Icons.visibility_off,
            color: const Color(0xFF236BBD),
          ),
          onPressed: () {
            // Update the state i.e. toogle the state of passwordVisible variable
            setState(() {
              _showPass = !_showPass;
            });
          },
        ),

        border: outline,
        focusedBorder: outlineB,
      ),
      obscureText: !_showPass,
      controller: _cPassController,
      onChanged: (value) {
        _authData['password'] = value;
      },
      validator: (value) {
        if (value!.isEmpty || value.length < 8) {
          return 'Password is too short!';
        }

        if (value != _authData['password']) {
          return 'Password is not the same';
        }
        return null;
      },
      onSaved: (value) {
        _authData['password'] = value!;
      },
    );
  }

  Widget _usernameField() {
    return TextFormField(
      decoration: InputDecoration(
        // labelText: 'E-Mail',
        hintText: 'E-mail',
        hintStyle: Constant.size14cCC4,
        prefixIcon: icAccount,
        border: outline,
        focusedBorder: outlineB,
      ),
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty || !value.isValidEmail()) {
          return 'Invalid email!';
        }
        return null;
      },
      onChanged: (value) {
        _authData['email'] = value;
      },
      onSaved: (value) {
        _authData['email'] = value!;
      },
    );
  }

  Widget _signUpButton() {
    return BlocListener<AuthenticationBloc, AuthState>(
      listener: (context, state) {
        //debugPrint('_loginButton() ${state.toString()}');
        if (state is IsSingUp) {
          if (state.isSingUp) {
            Navigator.of(context).pushReplacementNamed(SignInPage.routeName);
          }
        }

        if (state is AuthUnauthenticated) {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (ctx) {
                return AlertDialog(
                  title: Text(
                    'Sorry',
                    style: Constant.size14cB6,
                  ),
                  content: Text(
                    'Can\'t sing uo right now',
                    style: Constant.size14cB4,
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(ctx);
                        },
                        child: const Text('Try Again')),
                  ],
                );
              });
        }
      },
      child:
          BlocBuilder<AuthenticationBloc, AuthState>(builder: (context, state) {
        debugPrint('state $state');
        if (state is AuthLodingState) {
          return Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          );
        }
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0XFF4296FF),
          ),
          child: TextButton(
              onPressed: () {
                if (!_formKey.currentState!.validate()) {
                  // Invalid!
                  return;
                }
                context
                    .read<AuthenticationBloc>()
                    .add(SignUp(_authData['email']!, _authData['password']!));
                // _submit();
              },
              child: const Text(
                'Sign Up',
                style: TextStyle(color: Colors.white),
              )),
        );
      }),
    );
  }

  Widget _signUpForm() {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            _usernameField(),
            const SizedBox(
              height: 15,
            ),
            _passwordField(),
            const SizedBox(
              height: 15,
            ),
            _cPassField(),
            const SizedBox(
              height: 20,
            ),
            _signUpButton(),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 8.0,
      child: Container(
        padding: const EdgeInsets.only(top: 35, left: 20, right: 20),
        child: _signUpForm(),
      ),
    );
  }
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}
