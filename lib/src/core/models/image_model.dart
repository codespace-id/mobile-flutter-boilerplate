class ImageModels {
  ImageModels({
    this.id,
    this.attachment,
  });

  final String? id;
  final String? attachment;

  factory ImageModels.fromJson(Map<String, dynamic> json) => ImageModels(
        id: json["id"],
        attachment: json["attachment"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "attachment": attachment,
      };
}
