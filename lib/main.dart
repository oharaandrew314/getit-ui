import 'package:flutter/material.dart';
import 'package:getit_ui/client/client.dart';
import 'package:getit_ui/screens/list_screen.dart';
import 'package:getit_ui/state/list_state_provider.dart';
import 'package:getit_ui/state/session.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final session = await Session.getInstance();
  session.login("user1");

  final client = Client(session.accessToken!);

  final state = await ListStateProvider.fromClient(client);

  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<ListStateProvider>(create: (_) => state),
        ],
        child: const MyApp(),
      )
  );

  // runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ListScreen(),
    );
  }
}