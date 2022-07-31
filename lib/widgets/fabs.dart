import 'package:flutter/material.dart';
import 'package:getit_ui/client/dtos.dart';
import 'package:getit_ui/widgets/dialogs.dart';

class AddItemButton extends StatefulWidget {
  final Function(ItemDataDto) createItem;

  const AddItemButton({required this.createItem, Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AddItemButtonState();
}

class _AddItemButtonState extends State<AddItemButton> {

  final _controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => showAddItemDialog(context, _controller, widget.createItem),
      child: const Icon(Icons.add),
    );
  }
}