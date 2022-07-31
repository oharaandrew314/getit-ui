import 'package:flutter/material.dart';
import 'package:getit_ui/client/dtos.dart';

Future showAddItemDialog(
    BuildContext context,
    TextEditingController controller,
    Function(ItemDataDto) createItem
) async {
  controller.text = "";

  return showDialog(context: context, builder: (context) => AlertDialog(
    title: const Text('Add Item'),
    content: TextField(
      autofocus: true,
      controller: controller,
        decoration: const InputDecoration(hintText: "Item Name")
    ),
    actions: <Widget>[
      TextButton(
          child: const Text('CANCEL'),
          onPressed: () => Navigator.pop(context)
      ),
      TextButton(
        child: const Text('OK'),
        onPressed: () {
          final data = ItemDataDto(name: controller.text, completed: false);
          createItem(data);
          Navigator.pop(context);
        },
      ),
    ],
  ));
}

Future showAddListDialog(
    BuildContext context,
    TextEditingController controller,
    Function(ListDataDto) createList
) async {
  controller.text = "";

  return showDialog(context: context, builder: (context) => AlertDialog(
    title: const Text('Create List'),
    content: TextField(
      autofocus: true,
      controller: controller,
      decoration: const InputDecoration(hintText: "List Name")
    ),
    actions: <Widget>[
      TextButton(
          child: const Text('CANCEL'),
          onPressed: () => Navigator.pop(context)
      ),
      TextButton(
        child: const Text('OK'),
        onPressed: () {
          final data = ListDataDto(name: controller.text);
          createList(data);
          Navigator.pop(context);
        },
      ),
    ],
  ));
}