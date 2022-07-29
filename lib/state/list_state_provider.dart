import 'package:flutter/widgets.dart';
import 'package:getit_ui/client/client.dart';
import 'package:getit_ui/client/dtos.dart';
import 'package:logger/logger.dart';
import 'package:collection/collection.dart';

class ListStateProvider extends ChangeNotifier {

  final _log = Logger();
  bool _loading = false;

  final Client _client;
  List<ListDto> _lists;
  List<ItemDto> _items = [];
  ListDto? _current;

  ListStateProvider({
    required Client client,
    required List<ListDto> lists,
    required List<ItemDto> items,
    required ListDto? current
  }):
    _client = client,
    _lists = lists,
    _items = items,
    _current = current;

  static Future<ListStateProvider> fromClient(Client client) async {
    final lists = await client.getLists();
    final current = lists.firstOrNull;
    final List<ItemDto> items = current == null ? [] :  await client.getItems(current.listId);

    return ListStateProvider(
        client: client,
        lists: lists,
        items: items,
        current: current
    );
  }

  bool get loading => _loading;
  UnmodifiableListView<ListDto> get lists => UnmodifiableListView(_lists);
  UnmodifiableListView<ItemDto> get items => UnmodifiableListView(_items);
  ListDto? get current => _current;

  Future refreshLists() async {
    _log.i("Refresh lists");
    _loading = true;
    notifyListeners();

    _lists = await _client.getLists();
    _log.i("Got ${_lists.length} lists");

    _loading = false;
    notifyListeners();
  }

  Future selectList(ListDto list) async {
    _loading = true;
    _current = list;
    _items = [];
    notifyListeners();

    _items = await _client.getItems(list.listId);
    _log.i("Got ${_items.length} items for list ${list.listId}");

    _loading = false;
    notifyListeners();
  }

  Future createList(ListDataDto data) async {
    _loading = true;
    notifyListeners();

    final list = await _client.createList(data);
    _lists.add(list);
    _current = list;

    _loading = false;
    notifyListeners();
  }

  Future createItem(ListDto list, ItemDataDto data) async {
    _loading = true;
    notifyListeners();

    final item = await _client.createItem(list.listId, data);
    _items.add(item);

    _log.i("Created $item");

    _loading = false;
    notifyListeners();
  }

  Future updateItem(ItemDto item, ItemDataDto data) async {
    _loading = true;
    notifyListeners();

    final updated = await _client.updateItem(item.listId, item.itemId, data);

    _items.removeWhere((i) => i.itemId == item.itemId);
    _items.add(updated);
    _loading = false;
    notifyListeners();
  }

  Future refreshItems(ListDto list) async {
    _loading = true;
    notifyListeners();

    final items = await _client.getItems(list.listId);

    _items = items;
    _loading = false;
    notifyListeners();
  }
}