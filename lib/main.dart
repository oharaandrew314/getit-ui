import 'package:flutter/material.dart';
import 'package:getit_ui/client/client.dart';
import 'package:getit_ui/screens/list_screen.dart';
import 'package:getit_ui/screens/login_screen.dart';
import 'package:getit_ui/state/list_state_provider.dart';
import 'package:getit_ui/state/session.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final log = Logger();

  final session = await Session.getInstance();
  session.login("user1");

  final client = Client(session.accessToken!);

  final state = await ListStateProvider.fromClient(client);

  // runApp(
  //     MultiProvider(
  //       providers: [
  //         ChangeNotifierProvider<ListStateProvider>(create: (_) => state),
  //       ],
  //       child: const MyApp(),
  //     )
  // );

  runApp(const MyApp(child: SignInScreen()));
}

class MyApp extends StatelessWidget {
  final Widget child;

  const MyApp({required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: child,
    );
  }
}