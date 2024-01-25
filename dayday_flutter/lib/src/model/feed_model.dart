class FeedModel {
  int? id;
  String? title;
  String? content;
  DateTime? createdAt;
  int? userId;

  FeedModel.parse(Map m) {
    id = m['id'];
    title = m['title'];
    content = m['content'];
    createdAt = DateTime.parse(m['created_at']);
    userId = m['user_id'];
  }

  void updateWith(Map<String, dynamic> newValues) {
    title = newValues['title'] ?? title;
    content = newValues['content'] ?? content;
  }
}
