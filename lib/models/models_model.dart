class ModelsModel {
  final String id;
  final int created;
  final String root;

  ModelsModel({
    required this.created,
    required this.id,
    required this.root,
  });

  factory ModelsModel.fromJson(Map<String, dynamic> json) => ModelsModel(
        created: json["created"],
        id: json["id"],
        root: json["root"],
      );

  static List<ModelsModel> modelsFromSnapshot(List modelSnapShot) {
    return modelSnapShot.map((data) => ModelsModel.fromJson(data)).toList();
  }
}
