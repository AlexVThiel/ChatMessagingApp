import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  final _auth = FirebaseAuth.instance;

  Future<bool> isUserSignedIn() async {
    User? u;
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        log('User is currently signed out!');
        u = user;
      } else {
        log('User is signed in!');
      }
    });

    if (u != null) {
      return true;
    }
    return false;
  }

  Future<bool> singUp({required String email, required String password}) async {
    debugPrint('-----singUp-----');
    try {
      final authCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      if (authCredential.user != null) {
        log("User created successfully");
        return true;
      }
    } on FirebaseAuthException catch (e) {
      log(e.message!);
      rethrow;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
    return false;
  }

  /* Future<bool> singIn(
      {required String username, required String password}) async {
    safePrint('-----login-----');
    if (await signOutCurrentUser()) {
      try {
        final result = await Amplify.Auth.signIn(
            username: username,
            password: password,
            options: const SignInOptions(
              pluginOptions: CognitoSignInPluginOptions(
                clientMetadata: {
                  "app": "company",
                },
              ),
            ));

        safePrint('signing in  success');
        //safePrint('signing in  result: ${result.toString()}');
        final getUser = await _getUserIdFromAttributes();
        return getUser; //result.isSignedIn; //await _getUserIdFromAttributes();
      } on AuthException catch (e) {
        safePrint('error signing in : ${e.toString()}');
        return false;
      }
    }

    return false;
  }

  Future<bool> _getUserIdFromAttributes() async {
    safePrint('-----getUserIdFromAttributes-----');
    try {
      final cognitoPlugin =
          Amplify.Auth.getPlugin(AmplifyAuthCognito.pluginKey);
      final result = await cognitoPlugin.fetchAuthSession();
      final identityId = result.userPoolTokensResult;
      final user = await cognitoPlugin.fetchUserAttributes();

      /*safePrint('user : ${user.toString()}');
      safePrint('-----------------------');

      safePrint(
          'identityId : ${CognitoAccessToken(identityId.value.accessToken).username}');
      safePrint('-----------------------');*/
      final userrole = user.firstWhere(
          (element) => element.userAttributeKey.key == 'custom:userrole');
      final idenId = user.firstWhere(
          (element) => element.userAttributeKey.key == 'custom:identityid');
      List<String> accessToken = identityId.value.accessToken.groups;

      //  safePrint('identityId : ${identityId.value.accessToken.toString()}');
      final shared = await SharedPreferences.getInstance(); //
      shared.setStringList('companygroup', accessToken);
      if (userrole.value == 'owner') {
        shared.setString('userrole', userrole.value);
        shared.setString('identityId', idenId.value);
      }

      // .setString('companygroup', accessToken as String);
      // safePrint('identityId : ${identityId.value.accessToken}');
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> signOutCurrentUser() async {
    if (await isUserSignedIn()) {
      try {
        await Amplify.Auth.signOut().then((value) {});
        final shared = await SharedPreferences.getInstance(); //
        //shared.clear();
        shared.setStringList('companygroup', []);
        shared.setString('userrole', '');
        shared.setString('identityId', '');

        return true;
      } on AuthException catch (e) {
        safePrint('error signing out : ${e.toString()}');
      }
      return false;
    } else {
      return true;
    }
  }
*/
}
