class NotificationModel {
  final String id;
  final String? from;
  final String type;
  final String title;
  final String body;
  final Map<String, dynamic> payload;
  bool isRead;
  final DateTime createdAt;

  NotificationModel({
    required this.id,
    this.from,
    required this.type,
    required this.title,
    required this.body,
    required this.payload,
    this.isRead = false,
    required this.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['_id'],
      from: json['from'],
      type: json['type'],
      title: json['title'],
      body: json['body'],
      payload: Map<String, dynamic>.from(json['payload'] ?? {}),
      isRead: json['isRead'] ?? false,
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}