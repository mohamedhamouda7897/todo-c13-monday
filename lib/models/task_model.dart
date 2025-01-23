class TaskModel {
  String id;
  String title;
  String description;
  String category;
  String userId;
  int date;
  bool isDone;

  TaskModel({
    this.id = "",
    required this.date,
    required this.category,
    required this.title,
    required this.userId,
    this.isDone = false,
    required this.description,
  });

  TaskModel.fromJson(Map<String, dynamic> json)
      : this(
          date: json['date'],
          id: json['id'],
          category: json['category'],
          userId: json['userId'],
          title: json['title'],
          isDone: json['isDone'],
          description: json['description'],
        );

  Map<String, dynamic> toJson() {
    return {
      "date": date,
      "id": id,
      "userId": userId,
      "category": category,
      "title": title,
      "isDone": isDone,
      "description": description,
    };
  }
}
