import 'package:flutter/material.dart';
import 'package:getit_ui/client/dtos.dart';

class ListDrawerHeader extends StatelessWidget {

  const ListDrawerHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      decoration: const BoxDecoration(
        color: Colors.blue, // TODO replace with theme colour
      ),
      child: ElevatedButton(
          onPressed: () {},
          child: Row(
            children: const [
              Icon(Icons.add_circle_outline),
              Text("Create List")
            ],
          )
      )
    );
  }
}

class ListSelectorDrawer extends StatelessWidget {
  final List<ListDto> lists;
  final Function(ListDto) selectList;

  const ListSelectorDrawer({
    required this.lists,
    required this.selectList,
    Key? key
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: lists.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) return const ListDrawerHeader();

          final list = lists[index - 1];
          return TextButton(
            child: Text(list.name),
            onPressed: () {
              selectList(list);
              Navigator.pop(context);
            },
          );
        },
      )
    );
  }
}