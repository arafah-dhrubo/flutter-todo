import 'package:app/services/todo_services.dart';
import 'package:app/utils/snackbar_helper.dart';
import 'package:flutter/material.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({Key? key, this.todo}) : super(key: key);
  final Map? todo;
  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool isEdit = false;

  @override
  void initState() {
    super.initState();
    final todo=widget.todo;
    if(todo != null){
      isEdit = true;


      titleController.text = todo['title'];
      descriptionController.text = todo['description'];
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Edit Todo' : 'Add Todo'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),

              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              filled: true,

              border: InputBorder.none,
              hintText: 'Enter Todo',
              hintStyle: const TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          TextField(
            controller: descriptionController,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),

              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              filled: true,
              border: InputBorder.none,
              hintText: 'Enter Description',
              hintStyle: const TextStyle(
                color: Colors.grey,
              ),
            ),
            keyboardType: TextInputType.multiline,
            minLines: 5,
            maxLines: 10,
          ),
          const SizedBox(height: 20.0),
          ElevatedButton(
              onPressed: isEdit?updateTodo:submitTodo,
              style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(20.0),
                foregroundColor: Colors.blue[50],
                shape: const StadiumBorder(),
              ),
              child: Text(isEdit ? 'Update' : 'Submit')
          )
        ],
      ),
    );
  }

  Future<void> updateTodo() async {
    final id = widget.todo!['id'];
    final helper = Helper(context);
    final isSuccess = await TodoService.updateTodoById(id, body);
    if (isSuccess) {
      helper.showSuccessMessage('Todo updated');
      helper.navigateToTodosPage();
    } else {
      helper.showErrorMessage('Todo not updated');
    }
  }

  Future<void> submitTodo() async {
    final isSuccess = await TodoService.addTodo(body);
    final helper = Helper(context);
    if(isSuccess){
      helper.showSuccessMessage('Todo added');
      helper.navigateToTodosPage();
    }else{
      helper.showErrorMessage('Todo not added');
    }
  }

Map get body{
  final title = titleController.text;
  final description = descriptionController.text;

  return{
    'title': title,
    'description': description,
    'isCompleted': false,
  };
}
}

