class Todo{
  final int? id;
  final String title;
  final String description;
  Todo({
    this.id,
    required this.title,
    required this.description
  });

  Map<String,Object?> toMap() {
    return {'id':id,'title':title,'description':description};
  }
}
