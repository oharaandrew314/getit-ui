import 'package:flutter/material.dart';
import 'package:getit_ui/state/list_state_provider.dart';
import 'package:getit_ui/widgets/AddItemButton.dart';
import 'package:getit_ui/widgets/list_drawer.dart';
import 'package:getit_ui/widgets/list_items_view.dart';
import 'package:provider/provider.dart';

class ListScreen extends StatefulWidget {

  const ListScreen({Key? key}) : super(key: key);

  static Route createRoute() => PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const ListScreen()
  );

  @override
  State<ListScreen> createState() => _ListScreenState();
}


class _ListScreenState extends State<ListScreen> {

  @override
  Widget build(BuildContext context) {
    return Consumer<ListStateProvider>(
      builder: (context, state, child) {
        final current = state.current;
        final fab = current == null
            ? null
            : AddItemButton(
              createItem: (data) => state.createItem(current, data)
            );

        return Scaffold(
            appBar: AppBar(
              title: Text(current?.name ?? 'GetIt Lists'),
            ),
            drawer: ListSelectorDrawer(
                lists: state.lists,
                selectList: state.selectList
            ),
            body: Center(
                child: ListItemsView(
                  items: state.items,
                  updateItem: state.updateItem,
                  refreshItems: () {
                    if (current != null) state.refreshItems(current);
                  },
                )
            ),
            floatingActionButton: fab
        );
      },
    );
  }
}
