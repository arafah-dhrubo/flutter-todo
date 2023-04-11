import 'package:http/http.dart' as http;
import 'dart:convert';

class TodoService{
  // Get all the todos
  static Future<List<dynamic>> fetchTodos() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:5000/'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch todos');
    }
  }

  // Delete todos by id
  static Future<bool> deleteById(int id) async {
    final response = await http.delete(Uri.parse('http://10.0.2.2:5000/$id/'));
    if (response.statusCode == 204) {
      return true;
    } else {
      throw Exception('Failed to delete todo');
    }
  }

  // Update Todos
  static Future<bool> updateTodoById(id, body) async {
    print(body);
    final uri = Uri.parse('http://10.0.2.2:5000/$id/');
    final response = await http.put(
      uri,
      body: jsonEncode(body),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  // Add Todos
  static Future<bool> addTodo(body) async {
    final uri = Uri.parse('http://10.0.2.2:5000/');
    final response = await http.put(
      uri,
      body: jsonEncode(body),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
}