import 'package:flutter/material.dart';

import '../widget/exit.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
      // Show confirmation dialog
      bool confirm = await showDialog(
        context: context,
        builder: (context) => const ExitConfirmationDialog(),
      );

      // Return true if the user confirmed, false otherwise
      return confirm ?? false;
    },
    child: Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Center(
          child: Text('Settings'),
        ),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('Settings Page'),
      ),
    ));
  }
}
