import 'dart:convert';

import 'package:app/widget/todo_card.dart';
import 'package:flutter/material.dart';
import '../services/todo_services.dart';
import '../utils/snackbar_helper.dart';
import '../widget/exit.dart';
import 'add_page.dart';

class TodosPage extends StatefulWidget {
  const TodosPage({Key? key}) : super(key: key);

  @override
  State<TodosPage> createState() => _TodosPageState();
}

class _TodosPageState extends State<TodosPage> {
  late Future<List<dynamic>> items;

  @override
  void initState() {
    super.initState();
    items = fetchTodos();
  }

  Future<List<dynamic>> fetchTodos() async {
    final helper = Helper(context);
    final response = await TodoService.fetchTodos();
    if (response != null) {
      setState(() {
        items = Future.value(response);
      });
    } else {
      helper.showErrorMessage('Failed to load todos');
    }
    return response;
  }

  Future<void> _refreshTodos() async {
    setState(() {
      items = fetchTodos();
    });
  }

  Future<void> deleteById(int id) async {
    final isSuccess = await TodoService.deleteById(id);
    if (isSuccess) {
      _refreshTodos();
    } else {
      throw Exception('Failed to delete todo');
    }
  }

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
                child: Text('Tasks'),
              ),
              centerTitle: true,
            ),
            body: FutureBuilder<List<dynamic>>(
              future: items,
              builder: (context, items) {
                if (items.hasData) {
                  return RefreshIndicator(
                      onRefresh: _refreshTodos,
                      child: TodoCard(
                        deleteById: deleteById,
                        navigateToEditPage: navigateToEditPage,
                        items: items.data!,
                      ));
                } else if (items.hasError) {
                  return Center(
                    child: Text('${items.error}'),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
            floatingActionButton: Container(
              margin: const EdgeInsets.only(bottom:60),
              height: 60,
              width: 60,
              child: FittedBox(
                child: FloatingActionButton(
                  onPressed: navigateToAddPage,
                  child: const Icon(Icons.add),
                ),
              ),
            )
            // This trailing comma makes auto-formatting nicer for build methods.
            )
    );
  }

  Future<void> navigateToAddPage() async {
    final route = MaterialPageRoute(builder: (context) => const AddTodo());
    await Navigator.push(context, route);
  }

  void navigateToEditPage(Map item) {
    final route = MaterialPageRoute(builder: (context) => AddTodo(todo: item));
    Navigator.push(context, route);
  }
}
