class Favorite {
  final String itemId;
  final String itemType; // Vehicle | SparePart

  Favorite({
    required this.itemId,
    required this.itemType,
  });

  factory Favorite.fromJson(Map<String, dynamic> json) {
    return Favorite(
      itemId: json['itemId'],
      itemType: json['itemType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'itemId': itemId,
      'itemType': itemType,
    };
  }
}