
class Task {
  String title;
  String description;
  bool completed;

  Task({required this.title, required this.description, this.completed = false});

  // Преобразование объекта Task в Map для сохранения в JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'completed': completed,
    };
  }

  // Конструктор для создания объекта Task из Map
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      title: json['title'],
      description: json['description'],
      completed: json['completed'],
    );
  }
}