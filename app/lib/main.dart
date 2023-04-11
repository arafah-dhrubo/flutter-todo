import 'package:app/screens/todos_page.dart';
import 'package:app/screens/home_page.dart';
import 'package:app/screens/settings_page.dart';
import 'package:flutter/material.dart';

void main() {
  bool isSwitched = false;
  runApp(
      MaterialApp(
        theme: isSwitched ? ThemeData.dark() : ThemeData.light(),
      debugShowCheckedModeBanner: false,
      home: TodoApp())
  );
}

class TodoApp extends StatefulWidget {
  const TodoApp({Key? key}) : super(key: key);

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  int _currentIndex = 0;

  late String _appBarTitle;
  List<Widget> _appBarActions = [];
  late Color _appBarColor;

  final List<Widget> _pages = [
    const HomePage(),
    const TodosPage(),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check),
            label: 'Todos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
