class TaskModel {
  final String text;
  final bool isCrossed;

  TaskModel({
    required this.text,
    this.isCrossed = false,
  });

  TaskModel copyWith({
    String? text,
    bool? isCrossed,
  }) {
    return TaskModel(
      text: text ?? this.text,
      isCrossed: isCrossed ?? this.isCrossed,
    );
  }

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      text: json['text'],
      isCrossed: json['isCrossed'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'isCrossed': isCrossed,
    };
  }
}
