class Module {
  final String id;
  final String title;

  Module({
    required this.id,
    required this.title,
  });

  factory Module.fromMap(Map<String, dynamic> map, String id) {
    return Module(
      id: id,
      title: map['title'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
    };
  }
}
