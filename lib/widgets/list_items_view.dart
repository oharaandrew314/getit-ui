import 'package:flutter/material.dart';
import 'package:getit_ui/client/dtos.dart';
import 'package:getit_ui/widgets/item_view.dart';

class ListItemsView extends StatelessWidget {
  final List<ItemDto> items;
  final Function(ItemDto, ItemDataDto) updateItem;
  final Function(ItemDto) deleteItem;
  final Function? refreshItems;

  const ListItemsView({
    required this.items,
    required this.updateItem,
    required this.deleteItem,
    this.refreshItems,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) {
            final item = items[index];
            return ItemView(
              item: item,
              update: (data) => updateItem(item, data),
              delete: () => deleteItem(item),
            );
          }
        ),
        onRefresh: () async { refreshItems?.call(); }
    );
  }
}