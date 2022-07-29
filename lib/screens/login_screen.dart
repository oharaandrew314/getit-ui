import 'package:flutter/material.dart';
import 'package:getit_ui/screens/list_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State createState() => SignInScreenState();
}

class SignInScreenState extends State<SignInScreen> {

  final _log = Logger();
  final _googleSignIn = GoogleSignIn(
    scopes: ['email'],
  );

  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      _log.i("Logged in with account: $account");
      if (account == null) return;

      Navigator.pushReplacement(context, ListScreen.createRoute(account));
      // Navigator.pushReplacement(context, ListScreen.createRoute3(account));
    });
    _googleSignIn.signInSilently();
  }

  // Future<void> _handleSignOut() => _googleSignIn.disconnect();

  Widget _buildBody() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          const Text('You are not currently signed in.'),
          ElevatedButton(
            onPressed: () => _googleSignIn.signIn(),
            child: const Text('SIGN IN'),
          ),
        ],
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GetIt - Shopping Lists'),
      ),
      body: ConstrainedBox(
        constraints: const BoxConstraints.expand(),
        child: _buildBody(),
      )
    );
  }
}