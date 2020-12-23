class NotificationMessage {
  final String title;
  final String body;

  NotificationMessage({this.title, this.body});

  factory NotificationMessage.fromJson(Map<String, dynamic> message) {
    return NotificationMessage(
      title: message['notification']['title'] ?? 'Null',
      body: message['notification']['body'] ?? 'Null',
    );
  }
}
