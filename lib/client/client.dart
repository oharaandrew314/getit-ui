import 'dart:convert';
import 'dart:io';

import 'package:getit_ui/client/dtos.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class Client {
  final Uri host;
  final String accessToken;

  final _log = Logger();

  Client(this.accessToken, {Uri? host})
    : host = host ?? Uri.https("getit-api.andrewohara.com", "");

  Future<List<ListDto>> getLists() async {
    _log.i("Get lists");
    final resp = await http.get(
        host.resolve('/v1/lists'),
        headers: { 'Authorization': 'Bearer $accessToken'}
    );

    if (resp.statusCode != 200) throw HttpException("${resp.statusCode}: ${resp.body}");

    return (jsonDecode(resp.body) as List)
      .map((item) => ListDto.fromJson(item))
      .toList();
  }

  Future<ListDto> createList(ListDataDto data) async {
    final resp = await http.post(
        host.resolve('/v1/lists'),
        body: jsonEncode(data.toJson()),
        headers: { 'Authorization': 'Bearer $accessToken'}
    );

    if (resp.statusCode != 200) throw HttpException("${resp.statusCode}: ${resp.body}");

    return ListDto.fromJson(jsonDecode(resp.body));
  }

  Future<void> deleteList(String listId) async {
    final resp = await http.delete(
        host.resolve('/v1/lists/$listId'),
        headers: { 'Authorization': 'Bearer $accessToken'}
    );

    if (resp.statusCode != 200) throw HttpException("${resp.statusCode}: ${resp.body}");
  }

  Future<List<ItemDto>> getItems(String listId) async {
    final resp = await http.get(
        host.resolve('/v1/lists/$listId/items'),
        headers: { 'Authorization': 'Bearer $accessToken'}
    );

    if (resp.statusCode != 200) throw HttpException("${resp.statusCode}: ${resp.body}");

    return (jsonDecode(resp.body) as List)
        .map((item) => ItemDto.fromJson(item))
        .toList();
  }

  Future<ItemDto> createItem(String listId, ItemDataDto data) async {
    final resp = await http.post(
        host.resolve('/v1/lists/$listId/items'),
        body: jsonEncode(data.toJson()),
        headers: { 'Authorization': 'Bearer $accessToken'}
    );

    if (resp.statusCode != 200) throw HttpException("${resp.statusCode}: ${resp.body}");

    return ItemDto.fromJson(jsonDecode(resp.body));
  }

  Future<void> deleteItem(String listId, String itemId) async {
    final resp = await http.delete(
        host.resolve('/v1/lists/$listId/items/$itemId'),
        headers: { 'Authorization': 'Bearer $accessToken'}
    );

    if (resp.statusCode != 200) throw HttpException("${resp.statusCode}: ${resp.body}");
  }

  Future<ItemDto> updateItem(String listId, String itemId, ItemDataDto data) async {
    final resp = await http.put(
        host.resolve('/v1/lists/$listId/items/$itemId'),
        body: jsonEncode(data.toJson()),
        headers: { 'Authorization': 'Bearer $accessToken'}
    );

    if (resp.statusCode != 200) throw HttpException("${resp.statusCode}: ${resp.body}");
    return ItemDto.fromJson(jsonDecode(resp.body));
  }
}