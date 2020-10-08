part of 'posts_bloc.dart';

abstract class PostsEvent extends Equatable {
  final Key key;
  const PostsEvent({this.key});

  @override
  List<Object> get props => [key];
}

class LoadPosts extends PostsEvent {
  final PostType postType;
  final String status;

  LoadPosts({this.postType, Key key, this.status}) : super(key: key);

  @override
  List<Object> get props => super.props + [postType, status];

  @override
  String toString() => "LoadPosts(postType: ${this.postType})";
}
