import 'package:flutter/material.dart';
import 'package:getit_ui/client/dtos.dart';
import 'package:getit_ui/widgets/item_view.dart';

class ListItemsView extends StatefulWidget {
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
  State<StatefulWidget> createState() => _ListItemsViewState();
}

class _ListItemsViewState extends State<ListItemsView> {

  ItemDto? _selected;

  void _select(ItemDto? item) {
    setState(() => _selected = item);
  }

  void _check(ItemDto item, bool completed) {
    final data = ItemDataDto(name: item.name, completed: completed);
    widget.updateItem(item, data);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: widget.items.length,
            itemBuilder: (BuildContext context, int index) {
              final item = widget.items[index];
              return _selected == item
                ? EditableItem(
                  item: item,
                  update: (data) => widget.updateItem(item, data),
                  delete: () => widget.deleteItem(item),
                  deselect: () => _select(null)
                )
                : Item(
                  item: item,
                  select: () => _select(item),
                  check: (completed) => _check(item, completed ?? false),
                )
                ;

              // return ItemView(
              //   item: item,
              //   update: (data) => widget.updateItem(item, data),
              //   delete: () => widget.deleteItem(item),
              //   selected: _selected == item,
              //   select: (select) => _select(select ? item : null),
              // );
            }
        ),
        onRefresh: () async { widget.refreshItems?.call(); }
    );
  }

}