import 'package:flutter/material.dart';
import 'package:getit_ui/client/dtos.dart';


class ListSelectorDrawer extends StatelessWidget {
  final List<ListDto> lists;
  final ListDto? current;
  final Function(ListDto) selectList;
  final VoidCallback createList;

  const ListSelectorDrawer({
    required this.lists,
    required this.current,
    required this.selectList,
    required this.createList,
    Key? key
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: lists.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return ElevatedButton(
              onPressed: createList,
              child: const ListTile(
                  leading: Icon(Icons.add_circle_outline),
                  title: Text("New List")
              )
            );
          }

          final list = lists[index - 1];
          return TextButton(
            child: Text(
              list.name,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            onPressed: () {
              selectList(list);
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(
              backgroundColor: current == list ? Colors.grey : null
            )
          );
        },
      )
    );
  }
}