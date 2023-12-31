class CommentModel {
  int? status;
  String? message;
  CommentData? data;

  CommentModel({this.status, this.message, this.data});

  CommentModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    data = json["data"] == null ? null : CommentData.fromJson(json["data"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["status"] = status;
    _data["message"] = message;
    if (data != null) {
      _data["data"] = data?.toJson();
    }
    return _data;
  }
}

class CommentData {
  String? user;
  String? post;
  String? content;
  String? id;
  String? createdAt;
  String? updatedAt;
  int? v;

  CommentData(
      {this.user,
      this.post,
      this.content,
      this.id,
      this.createdAt,
      this.updatedAt,
      this.v});

  CommentData.fromJson(Map<String, dynamic> json) {
    user = json["user"];
    post = json["postId"];
    content = json["content"];
    id = json["_id"];
    createdAt = json["createdAt"];
    updatedAt = json["updatedAt"];
    v = json["__v"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["user"] = user;
    _data["postId"] = post;
    _data["content"] = content;
    _data["_id"] = id;
    _data["createdAt"] = createdAt;
    _data["updatedAt"] = updatedAt;
    _data["__v"] = v;
    return _data;
  }
}
