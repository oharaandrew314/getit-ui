import 'package:flutter/material.dart';
import 'package:getit_ui/client/client.dart';
import 'package:getit_ui/client/dtos.dart';
import 'package:getit_ui/screens/login_screen.dart';
import 'package:getit_ui/widgets/dialogs.dart';
import 'package:getit_ui/widgets/fabs.dart';
import 'package:getit_ui/widgets/list_drawer.dart';
import 'package:getit_ui/widgets/list_items_view.dart';
import 'package:getit_ui/widgets/user_drawer.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:collection/collection.dart';

class ListScreen extends StatefulWidget {

  final GoogleSignInAccount account;
  final Client client;

  const ListScreen({
    required this.account,
    required this.client,
    Key? key
  }): super(key: key);

  static Future<Route> createRoute(GoogleSignInAccount account) async {
    final auth = await account.authentication;
    return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => ListScreen(
          account: account,
          client: Client(auth.idToken!)
        )
    );
  }

  @override
  State<ListScreen> createState() => _ListScreenState();
}


class _ListScreenState extends State<ListScreen> {

  final _googleSignIn = GoogleSignIn();
  final _dialogTextController = TextEditingController();

  List<ListDto> _lists = [];
  List<ItemDto> _items = [];
  ListDto? _currentList;

  @override
  void dispose() {
    super.dispose();
    _dialogTextController.dispose();
  }

  Future refreshLists({bool selectFirst = false}) async {
    final lists = await widget.client.getLists();

    setState(() {
      _lists = lists;
      if (selectFirst) {
        selectList(lists.firstOrNull);
      }
    });
  }

  Future refreshItems() async {
    final list = _currentList;
    if (list == null) return;
    final items = await widget.client.getItems(list.listId);
    setState(() => _items = items);
  }

  void selectList(ListDto? list) {
    setState(() {
      _currentList = list;
      _items = [];
    });
    refreshItems();
  }

  Future updateItem(ItemDto item, ItemDataDto data) async {
    final index = _items.indexOf(item);
    final updated = await widget.client.updateItem(item.listId, item.itemId, data);
    setState(() {
      if (index == -1) {
        _items.add(updated);
      } else {
        _items[index] = updated;
      }
    });
  }

  Future deleteItem(ItemDto item) async {
    setState(() {
      _items.remove(item);
    });
    await widget.client.deleteItem(item.listId, item.itemId);
  }

  Future createItem(ListDto list, ItemDataDto data) async {
    final item = await widget.client.createItem(list.listId, data);
    setState(() {
      _items.add(item);
    });
  }

  Future logout() async {
    await _googleSignIn.signOut();
    await Navigator.pushReplacement(context, LoginScreen.createRoute());
  }

  Future showCreateList() async {
    showAddListDialog(context, _dialogTextController, createList);
  }

  Future createList(ListDataDto data) async {
    final list = await widget.client.createList(data);
    setState(() => _lists.add(list));
  }

  @override
  void initState() {
    super.initState();
    refreshLists(selectFirst: true);
  }

  @override
  Widget build(BuildContext context) {
    final list = _currentList;
    final fab = list == null
        ? null
        : AddItemButton(createItem: (data) => createItem(list, data));

    return Scaffold(
        appBar: AppBar(
          title: ListTile(
            title: Text(_currentList?.name ?? 'GetIt Lists'),
            trailing: UserDrawer(account: widget.account, logout: logout),
          )
        ),
        drawer: SafeArea(
          child: ListSelectorDrawer(
            lists: _lists,
            current: _currentList,
            selectList: selectList,
            createList: showCreateList,
          )
        ),
        body: Center(
            child: ListItemsView(
              items: _items,
              updateItem: updateItem,
              deleteItem: deleteItem,
              refreshItems: refreshItems
            )
        ),
        floatingActionButton: fab
    );
  }
}
