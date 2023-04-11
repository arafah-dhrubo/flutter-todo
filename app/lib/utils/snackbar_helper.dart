import 'package:app/screens/home_page.dart';
import 'package:flutter/material.dart';

import '../screens/todos_page.dart';

class Helper {
  final BuildContext context;

  Helper(this.context);

  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
  GlobalKey<ScaffoldMessengerState>();

  void showSuccessMessage(String message) {
    _showSnackBar(message, Colors.green);
  }

  void showErrorMessage(String message) {
    _showSnackBar(message, Colors.red);
  }

  void _showSnackBar(String message, Color color) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: color,
    );
    scaffoldMessengerKey.currentState?.showSnackBar(snackBar);
  }

  Future<void> navigateToHomePage() async {
    final route = MaterialPageRoute(builder: (context) => const HomePage());
    await Navigator.push(context, route);
  }

  Future<void> navigateToTodosPage() async {
    final route = MaterialPageRoute(builder: (context) => const TodosPage());
    await Navigator.push(context, route);
  }
}
