class Post {
  String? id;
  final String title;
  final String description;

  Post({
    this.id,
    required this.title,
    required this.description,
  });

  Post copyWith({
    String? id,
    String? title,
    String? description,
  }) {
    return Post(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
    };
  }

  factory Post.fromFirestore(Map<String, dynamic> map, String id) {
    return Post(
      id: id,
      title: map['title'],
      description: map['description'],
    );
  }
}
