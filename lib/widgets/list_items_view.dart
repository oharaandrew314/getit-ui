import 'package:flutter/material.dart';
import 'package:getit_ui/client/dtos.dart';
import 'package:getit_ui/widgets/item_view.dart';

class ListItemsView extends StatelessWidget {
  final List<ItemDto> items;
  final Function(ItemDto, ItemDataDto) updateItem;
  final Function? refreshItems;

  const ListItemsView({
    required this.items,
    required this.updateItem,
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
              onUpdate: updateItem,
            );
          }
        ),
        onRefresh: () async { refreshItems?.call(); }
    );
  }
}