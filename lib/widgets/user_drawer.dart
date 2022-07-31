
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserDrawer extends StatelessWidget {
  final GoogleSignInAccount account;
  final VoidCallback logout;

  const UserDrawer({
    required this.account,
    required this.logout,
    Key? key
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        icon: GoogleUserCircleAvatar(identity: account),
        itemBuilder: (context) => [
          PopupMenuItem(
            child: ListTile(
              leading: GoogleUserCircleAvatar(identity: account),
              title: Text(account.displayName ?? ""),
              subtitle: Text(account.email),
            )
          ),
          PopupMenuItem(
              child: const Text("Logout"),
              onTap: logout
          )
        ]
    );
  }
}