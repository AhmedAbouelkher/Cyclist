// To parse this JSON data, do
//
//     final postsResponse = postsResponseFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

PostsResponse postsResponseFromJson(String str) => PostsResponse.fromJson(json.decode(str));

String postsResponseToJson(PostsResponse data) => json.encode(data.toJson());

class PostsResponse {
  PostsResponse({
    this.posts,
  });

  final Posts posts;

  PostsResponse copyWith({
    Posts posts,
  }) =>
      PostsResponse(
        posts: posts ?? this.posts,
      );

  factory PostsResponse.fromJson(Map<String, dynamic> json) => PostsResponse(
        posts: json["posts"] == null ? null : Posts.fromJson(json["posts"]),
      );

  Map<String, dynamic> toJson() => {
        "posts": posts == null ? null : posts.toJson(),
      };
}

class Posts extends Equatable {
  Posts({
    this.data,
    this.total,
    this.perPage,
    this.currentPage,
    this.lastPage,
    this.basePageUrl,
    this.nextPageUrl,
    this.prevPageUrl,
  });

  final List<Post> data;
  final int total;
  final int perPage;
  final int currentPage;
  final int lastPage;
  final String basePageUrl;
  final String nextPageUrl;
  final String prevPageUrl;

  Posts copyWith({
    List<Post> data,
    int total,
    int perPage,
    int currentPage,
    int lastPage,
    String basePageUrl,
    String nextPageUrl,
    String prevPageUrl,
  }) =>
      Posts(
        data: data ?? this.data,
        total: total ?? this.total,
        perPage: perPage ?? this.perPage,
        currentPage: currentPage ?? this.currentPage,
        lastPage: lastPage ?? this.lastPage,
        basePageUrl: basePageUrl ?? this.basePageUrl,
        nextPageUrl: nextPageUrl ?? this.nextPageUrl,
        prevPageUrl: prevPageUrl ?? this.prevPageUrl,
      );

  factory Posts.fromJson(Map<String, dynamic> json) => Posts(
        data: json["data"] == null ? null : List<Post>.from(json["data"].map((x) => Post.fromJson(x))),
        total: json["total"] == null ? null : json["total"],
        perPage: json["per_page"] == null ? null : json["per_page"],
        currentPage: json["current_page"] == null ? null : json["current_page"],
        lastPage: json["last_page"] == null ? null : json["last_page"],
        basePageUrl: json["base_page_url"] == null ? null : json["base_page_url"],
        nextPageUrl: json["next_page_url"] == null ? null : json["next_page_url"],
        prevPageUrl: json["prev_page_url"] == null ? null : json["prev_page_url"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
        "total": total == null ? null : total,
        "per_page": perPage == null ? null : perPage,
        "current_page": currentPage == null ? null : currentPage,
        "last_page": lastPage == null ? null : lastPage,
        "base_page_url": basePageUrl == null ? null : basePageUrl,
        "next_page_url": nextPageUrl == null ? null : nextPageUrl,
        "prev_page_url": prevPageUrl == null ? null : prevPageUrl,
      };

  @override
  List<Object> get props => [
        this.data,
        this.total,
        this.perPage,
        this.currentPage,
        this.lastPage,
        this.basePageUrl,
        this.nextPageUrl,
        this.prevPageUrl,
      ];
}

class Post extends Equatable {
  Post({
    this.id,
    this.titel,
    this.imageHeader,
    this.post,
    this.createdAt,
    this.media,
  });

  final int id;
  final String titel;
  final String imageHeader;
  final String post;
  final DateTime createdAt;
  final List<Media> media;

  Post copyWith({
    int id,
    String titel,
    String imageHeader,
    String post,
    DateTime createdAt,
    List<Media> media,
  }) =>
      Post(
        id: id ?? this.id,
        titel: titel ?? this.titel,
        imageHeader: imageHeader ?? this.imageHeader,
        post: post ?? this.post,
        createdAt: createdAt ?? this.createdAt,
        media: media ?? this.media,
      );

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["id"] == null ? null : json["id"],
        titel: json["titel"] == null ? null : json["titel"],
        imageHeader: json["image_header"] == null ? null : "http://alaglate.ainzimati.tk" + json["image_header"],
        post: json["post"] == null ? null : json["post"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        media: json["media"] == null ? null : List<Media>.from(json["media"].map((x) => Media.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "titel": titel == null ? null : titel,
        "image_header": imageHeader == null ? null : imageHeader,
        "post": post == null ? null : post,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "media": media == null ? null : List<dynamic>.from(media.map((x) => x.toJson())),
      };
  @override
  List<Object> get props => [
        this.id,
        this.titel,
        this.imageHeader,
        this.post,
        this.createdAt,
        this.media,
      ];
}

enum MediaType { image, video }

class Media extends Equatable {
  Media({
    this.mimeType,
    this.path,
  });

  final String mimeType;
  final String path;

  Media copyWith({
    String mimeType,
    String file,
  }) =>
      Media(
        mimeType: mimeType ?? this.mimeType,
        path: file ?? this.path,
      );

  factory Media.fromJson(Map<String, dynamic> json) => Media(
        mimeType: json["mime_type"] == null ? null : json["mime_type"],
        path: json["file"] == null ? null : "http://alaglate.ainzimati.tk" + json["file"],
      );

  Map<String, dynamic> toJson() => {
        "mime_type": mimeType == null ? null : mimeType,
        "file": path == null ? null : path,
      };

  MediaType get madiaType {
    if (mimeType.contains("video")) {
      return MediaType.video;
    } else {
      return MediaType.image;
    }
  }

  @override
  List<Object> get props => [
        this.mimeType,
        this.path,
      ];
}
