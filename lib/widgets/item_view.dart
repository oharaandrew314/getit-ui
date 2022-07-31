import 'package:flutter/material.dart';
import 'package:getit_ui/client/dtos.dart';

class Item extends StatelessWidget {
  final ItemDto item;

  final VoidCallback select;
  final Function(bool?) check;

  const Item({
    required this.item,
    required this.select,
    required this.check,
    Key? key
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    final content = Row(
        children: [
          Expanded(
              child: Checkbox(
                value: item.completed,
                onChanged: check,
              )
          ),
          Expanded(
              flex: 10,
              child: Text(item.name)
          ),
        ]
    );

    return InkWell(
      child: content,
      onTap: select
    );
  }
}

class EditableItem extends StatelessWidget {
  final ItemDto item;

  final Function(ItemDataDto) update;
  final Function() delete;
  final VoidCallback deselect;

  const EditableItem({
    required this.item,
    required this.update,
    required this.delete,
    required this.deselect,
    Key? key
  }): super(key: key);

  void _handleCheck(bool? completed) {
    final data = ItemDataDto(name: item.name, completed: completed ?? false);
    update(data);
  }

  void _handleRename(String name) {
    final data = ItemDataDto(name: name, completed: item.completed);
    update(data);
    deselect();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
        children: [
          Expanded(
              child: Checkbox(
                value: item.completed,
                onChanged: _handleCheck,
              )
          ),
          Expanded(
              flex: 10,
              child: TextFormField(
                initialValue: item.name,
                autofocus: true,
                onFieldSubmitted: _handleRename
              )
          ),
          Expanded(
              child: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => delete(),
              )
          )
        ]
    );
  }
}