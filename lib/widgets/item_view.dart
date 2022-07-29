import 'package:flutter/material.dart';
import 'package:getit_ui/client/dtos.dart';

class ItemView extends StatefulWidget {
  final ItemDto item;
  final Function(ItemDataDto) update;
  final Function() delete;


  const ItemView({
    required this.item,
    required this.delete,
    required this.update, Key? key
  }): super(key: key);

  @override
  State<StatefulWidget> createState() => _ItemViewState();
}

class _ItemViewState extends State<ItemView> {
  final _controller = TextEditingController();

  void _handleCheck(bool? completed) {
    final data = ItemDataDto(name: widget.item.name, completed: completed ?? false);
    widget.update(data);
  }

  @override
  void initState() {
    super.initState();
    _controller.text = widget.item.name;
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Checkbox(
            value: widget.item.completed,
            onChanged: _handleCheck,
          )
        ),
        Expanded(
          flex: 10,
          child: SizedBox(
            width: 100,
            child: TextField(
              controller: _controller
            )
          )
        ),
        Expanded(
          child: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => widget.delete(),
          )
        )
      ]
    );
  }
}