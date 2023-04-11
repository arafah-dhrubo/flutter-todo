import 'package:flutter/material.dart';

class TodoCard extends StatelessWidget {
  final List<dynamic>? items;
  final Function(Map<String, dynamic>) navigateToEditPage;
  final Function(int) deleteById;

  const TodoCard({
    Key? key,
    required this.items,
    required this.navigateToEditPage,
    required this.deleteById,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 5.0),
        child: Visibility(
          visible: items != null && items!.isNotEmpty,
          replacement: const Center(
            child: Text(
              'No Todos',
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
          ),
          child: ListView.builder(
            itemCount: items!.length,
            itemBuilder: (context, index) {
              final todo = items![index];
              return Card(
                  child: Padding(
                padding: const EdgeInsets.only(
                    left: 5.0, right: 5.0, top: 5.0),
                child: ListTile(
                    leading: CircleAvatar(
                      child: Text('${index + 1}'),
                    ),
                    title: Text(todo['title']),
                    subtitle: Text(todo['description']),
                    trailing: PopupMenuButton(
                      onSelected: (value) {
                        if (value == 'Edit') {
                          navigateToEditPage(todo);
                        } else if (value == 'Delete') {
                          deleteById(todo['id']);
                        }
                      },
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: 'Edit',
                          child: Text('Edit'),
                        ),
                        const PopupMenuItem(
                            value: 'Delete', child: Text('Delete')),
                      ],
                    )),
              )
              );
            },
          ),
        ),
    );
  }
}
