// ignore_for_file: public_member_api_docs, sort_constructors_first, no_leading_underscores_for_local_identifiers

class BlogPost {
  int? status;
  String? message;
  List<DataPost>? data;

  BlogPost({this.status, this.message, this.data});

  BlogPost.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    data = json["data"] == null
        ? null
        : (json["data"] as List).map((e) => DataPost.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["status"] = status;
    _data["message"] = message;
    if (data != null) {
      _data["data"] = data?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class DataPost {
  String? id;
  String? user;
  String? title;
  String? description;
  String? image;
  String? createdAt;
  String? updatedAt;
  int? v;

  DataPost(
      {this.id,
      this.user,
      this.title,
      this.description,
      this.image,
      this.createdAt,
      this.updatedAt,
      this.v});

  DataPost.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    user = json["user"];
    title = json["title"];
    description = json["description"];
    image = json["image"];
    createdAt = json["createdAt"];
    updatedAt = json["updatedAt"];
    v = json["__v"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["user"] = user;
    _data["title"] = title;
    _data["description"] = description;
    _data["image"] = image;
    _data["createdAt"] = createdAt;
    _data["updatedAt"] = updatedAt;
    _data["__v"] = v;
    return _data;
  }
}
