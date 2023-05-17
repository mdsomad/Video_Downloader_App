// To parse this JSON data, do
//
//     final instagramReelModel = instagramReelModelFromJson(jsonString);

import 'dart:convert';

InstagramReelModel instagramReelModelFromJson(String str) => InstagramReelModel.fromJson(json.decode(str));

String instagramReelModelToJson(InstagramReelModel data) => json.encode(data.toJson());

class InstagramReelModel {
    String status;
    Response response;

    InstagramReelModel({
        required this.status,
        required this.response,
    });

    factory InstagramReelModel.fromJson(Map<String, dynamic> json) => InstagramReelModel(
        status: json["status"],
        response: Response.fromJson(json["response"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "response": response.toJson(),
    };
}

class Response {
    Author author;
    Video video;

    Response({
        required this.author,
        required this.video,
    });

    factory Response.fromJson(Map<String, dynamic> json) => Response(
        author: Author.fromJson(json["author"]),
        video: Video.fromJson(json["video"]),
    );

    Map<String, dynamic> toJson() => {
        "author": author.toJson(),
        "video": video.toJson(),
    };
}

class Author {
    String id;
    String image;
    String name;

    Author({
        required this.id,
        required this.image,
        required this.name,
    });

    factory Author.fromJson(Map<String, dynamic> json) => Author(
        id: json["id"],
        image: json["image"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "name": name,
    };
}

class Video {
    int likesCount;
    int commentCount;
    String type;
    DateTime uploadDate;
    String description;
    String name;
    String caption;
    String height;
    String width;
    String contentUrl;
    String thumbnailUrl;
    List<dynamic> genre;
    List<String> keywords;

    Video({
        required this.likesCount,
        required this.commentCount,
        required this.type,
        required this.uploadDate,
        required this.description,
        required this.name,
        required this.caption,
        required this.height,
        required this.width,
        required this.contentUrl,
        required this.thumbnailUrl,
        required this.genre,
        required this.keywords,
    });

    factory Video.fromJson(Map<String, dynamic> json) => Video(
        likesCount: json["likesCount"],
        commentCount: json["commentCount"],
        type: json["@type"],
        uploadDate: DateTime.parse(json["uploadDate"]),
        description: json["description"],
        name: json["name"],
        caption: json["caption"],
        height: json["height"],
        width: json["width"],
        contentUrl: json["contentUrl"],
        thumbnailUrl: json["thumbnailUrl"],
        genre: List<dynamic>.from(json["genre"].map((x) => x)),
        keywords: List<String>.from(json["keywords"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "likesCount": likesCount,
        "commentCount": commentCount,
        "@type": type,
        "uploadDate": uploadDate.toIso8601String(),
        "description": description,
        "name": name,
        "caption": caption,
        "height": height,
        "width": width,
        "contentUrl": contentUrl,
        "thumbnailUrl": thumbnailUrl,
        "genre": List<dynamic>.from(genre.map((x) => x)),
        "keywords": List<dynamic>.from(keywords.map((x) => x)),
    };
}
