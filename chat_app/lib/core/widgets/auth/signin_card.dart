import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../constants/styles.dart';

class SignInCard extends StatefulWidget {
  const SignInCard({super.key});

  @override
  State<SignInCard> createState() => _SignInCardState();
}

class _SignInCardState extends State<SignInCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  var _showPass = false;
  final _passwordController = TextEditingController();

  Widget _passwordField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: 'Password',
        hintStyle: const TextStyle(color: Color(0xFFADADAD)),
        prefixIcon: const Icon(
          Icons.lock,
          color: Color(0xFF236BBD),
        ),
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
        border: OutlineInputBorder(
          borderRadius: Constant.borderRd15,
          borderSide: const BorderSide(color: Color(0xFFADADAD), width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFF236BBD), width: 1.0),
          borderRadius: Constant.borderRd15,
        ),
      ),
      obscureText: !_showPass,
      controller: _passwordController,
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

  Widget _usernameField() {
    return TextFormField(
      decoration: InputDecoration(
        // labelText: 'E-Mail',
        hintText: 'E-mail',
        hintStyle: const TextStyle(color: Color(0xFFADADAD)),
        prefixIcon: const Icon(
          Icons.account_circle_rounded,
          color: Color(0xFF236BBD),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(color: Color(0xFFADADAD), width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFF236BBD), width: 1.0),
          borderRadius: BorderRadius.circular(15.0),
        ),
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

  /* Widget _signInButton() {
    return BlocListener<AuthenticationBloc, AuthState>(
      listener: (context, state) {
        //debugPrint('_loginButton() ${state.toString()}');
        if (state is AuthAuthenticated) {
          if (state.auth) {
            Navigator.of(context)
                .pushReplacementNamed(ProfilePage.routeName);
          } else {
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
                      'Username or Password is not correct',
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
        }

        if (state is AuthUnauthenticated) {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (ctx) {
                return AlertDialog(
                  title: Text(
                    'ขออภัย',
                    style: Constant.size14cB6,
                  ),
                  content: Text(
                    'Username หรือ Password ไม่ถูกต้อง',
                    style: Constant.size14cB4,
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(ctx);
                        },
                        child: const Text('ลองอีกครั้ง')),
                  ],
                );
              });
        }
      },
      child:
          BlocBuilder<AuthenticationBloc, AuthState>(builder: (context, state) {
        //debugPrint('state $state');
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
                    .add(LoggedIn(_authData['email']!, _authData['password']!));
                // _submit();
              },
              child: const Text(
                'ลงชื่อเข้าสู่ระบบ',
                style: TextStyle(color: Colors.white),
              )),
        );
      }),
    );
  }
*/
  Widget _loginForm() {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            _usernameField(),
            const SizedBox(
              height: 10,
            ),
            _passwordField(),
            const SizedBox(
              height: 20,
            ), // _signInButton(),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 15),
              alignment: Alignment.centerRight,
              child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    textAlign: TextAlign.right,
                    'Forget Password',
                    style: TextStyle(color: Color(0xFFFF9F0A)),
                  )),
            ),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 20, left: 20),
            child: Text(
              'Welcome back',
              style: TextStyle(
                color: Color(0xFF525252),
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: _loginForm(),
          ),
        ],
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
