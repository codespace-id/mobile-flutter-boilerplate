import 'dart:io';

class PostModel {
  int? userId;
  int? id;
  String? title;
  String? body;
  bool? isLiked;
  File? url;

  PostModel({
    this.id,
    this.userId,
    this.title,
    this.body,
    this.isLiked = false,
    this.url,
  });

  PostModel.fromJson(dynamic json) {
    userId = int.parse(json['userId'].toString());
    id = int.parse(json['id'].toString());
    title = json['title'].toString();
    body = json['body'].toString();
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    data['title'] = title;
    data['body'] = body;
    data['url'] = url;
    return data;
  }
}

class ListPost {
  static ListPost fromJson(List<dynamic> json) => ListPost(
      listPost: json.map((dynamic i) => PostModel.fromJson(i)).toList());

  ListPost({this.listPost});

  List<PostModel>? listPost;
}
