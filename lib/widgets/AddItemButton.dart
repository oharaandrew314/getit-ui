import 'package:flutter/material.dart';
import 'package:getit_ui/client/dtos.dart';

class AddItemButton extends StatefulWidget {
  final Function(ItemDataDto) createItem;

  const AddItemButton({required this.createItem, Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AddItemButtonState();
}

class _AddItemButtonState extends State<AddItemButton> {

  final _textFieldController = TextEditingController();
  String _name = "";

  Future _showAddItem(BuildContext context) async {
    setState(() { _name = "";});
    _textFieldController.clear();

    return showDialog(context: context, builder: (context) => AlertDialog(
      title: const Text('Add Item'),
      content: TextField(
        onChanged: (value) => setState(() => _name = value),
        autofocus: true,
        controller: _textFieldController,
      ),
      actions: <Widget>[
        TextButton(
            child: const Text('CANCEL'),
            onPressed: () => Navigator.pop(context)
        ),
        TextButton(
          child: const Text('OK'),
          onPressed: () {
            final data = ItemDataDto(name: _name, completed: false);
            widget.createItem(data);
            Navigator.pop(context);
          },
        ),
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        _showAddItem(context);
      },
      child: const Icon(Icons.add),
    );
  }
}