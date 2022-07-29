import 'package:flutter/material.dart';
import 'package:getit_ui/client/dtos.dart';

class ItemView extends StatelessWidget {
  final ItemDto item;
  final Function(ItemDto, ItemDataDto) onUpdate;

  const ItemView({ required this.item, required this.onUpdate, Key? key}): super(key: key);

  void _handleCheck(bool? completed) {
    final data = ItemDataDto(name: item.name, completed: completed ?? false);
    onUpdate(item, data);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
            value: item.completed,
            onChanged: _handleCheck,
        ),
        Text(item.name)
      ],
    );
  }
}