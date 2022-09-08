import 'dart:convert';

class PostModel {
final String uid;
final String name;
final String imageurl;
final String date;
final String text;
final String ?postImageUrl;
  PostModel({
    required this.uid,
    required this.name,
    required this.imageurl,
    required this.date,
    required this.text,
    required this.postImageUrl,
  });




  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'uid': uid});
    result.addAll({'name': name});
    result.addAll({'image_url': imageurl});
    result.addAll({'date': date});
    result.addAll({'text': text});
    result.addAll({'post_image_url': postImageUrl});
  
    return result;
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      imageurl: map['image_url'] ?? '',
      date: map['date'] ?? '',
      text: map['text'] ?? '',
      postImageUrl: map['post_image_url'] ?? '',
    );
  }

}
