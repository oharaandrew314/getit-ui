class ListDto {
  final String userId;
  final String listId;
  final String name;

  const ListDto({
    required this.userId,
    required this.listId,
    required this.name
  });

  @override
  String toString() => "List: $name";

  static ListDto fromJson(Map<String, dynamic> json) => ListDto(
    userId: json["userId"],
    listId: json["listId"],
    name: json["name"]
  );
}

class ListDataDto {
  final String name;

  const ListDataDto({required this.name});

  @override
  String toString() => "ListData: $name";

  Map<String, dynamic> toJson() => {
    "name": name
  };
}

class ItemDto {
  final String listId;
  final String itemId;
  final String name;
  final bool completed;

  ItemDto({
    required this.listId,
    required this.itemId,
    required this.name,
    required this.completed
  });

  @override
  String toString() => "Item: $name";

  static ItemDto fromJson(Map<String, dynamic> json) => ItemDto(
    listId: json["listId"],
    itemId: json["itemId"],
    name: json["name"],
    completed: json["completed"]
  );
}

class ItemDataDto {
  final String name;
  final bool completed;

  const ItemDataDto({
    required this.name,
    required this.completed
  });

  @override
  String toString() => "Item Data: $name, completed: $completed";

  Map<String, dynamic> toJson() => {
    "name": name,
    "completed": completed
  };
}