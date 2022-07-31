import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
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
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.all(20),
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: Text(
              "GetIt",
              style: Theme.of(context).textTheme.displayLarge
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
                "Shopping Lists",
              style: Theme.of(context).textTheme.displayMedium
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(20),
          ),
          SignInButton(
            Buttons.Google,
            onPressed: () => _googleSignIn.signIn()
          )
        ],
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: ConstrainedBox(
        constraints: const BoxConstraints.expand(),
        child: _buildBody(),
      )
    );
  }
}