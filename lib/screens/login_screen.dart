import 'package:flutter/material.dart';
import 'package:getit_ui/screens/list_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static Route createRoute() => PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const LoginScreen()
  );

  @override
  State createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {

  final _googleSignIn = GoogleSignIn(
    scopes: ['email'],
  );

  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) async {
      final route = account == null
        ? LoginScreen.createRoute()
        : await ListScreen.createRoute(account);
      Navigator.pushReplacement(context, route);
    });
    _googleSignIn.signInSilently();
  }

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