import 'package:app/screens/todos_page.dart';
import 'package:app/screens/home_page.dart';
import 'package:app/screens/settings_page.dart';
import 'package:app/widget/exit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  bool isSwitched = false;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        title: 'My App',
        debugShowCheckedModeBanner: false,
        home: MainScreen(),
      );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  final List<Widget> _pages = [
    const HomePage(),
    const TodosPage(),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    Future<bool> showExitPopup() async {
      if(Navigator.of(context).userGestureInProgress){
        return false; // If there is a gesture in progress, do not show the dialog
      }else{
        if (Navigator.of(context).canPop()) {
          // If we can navigate back, do so
          Navigator.of(context).pop();
          return false;
        } else {
          // If we cannot navigate back, show the confirmation dialog
          return await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Exit App'),
              content: Text('Do you want to exit the app?'),
              actions: [
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text('No'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text('Yes'),
                ),
              ],
            ),
          ) ?? false;
        }
      }
    }
    return WillPopScope(
        onWillPop: showExitPopup,
        child: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.fork_right),
              label: 'Tasks',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
        tabBuilder: (context, index){
          switch (index) {
            case 0:
              return CupertinoTabView(
                builder: (context) =>const CupertinoPageScaffold(child: HomePage()),
              );
            case 1:
              return CupertinoTabView(
                builder: (context) =>const CupertinoPageScaffold(child: TodosPage()),
              );
            case 2:
              return CupertinoTabView(
                builder: (context) =>const CupertinoPageScaffold(child: SettingsPage()),
              );
          };
          throw Exception('No widget was returned from the build method.');
        }
    ));
  }
}
 