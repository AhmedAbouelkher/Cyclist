part of 'posts_bloc.dart';

abstract class PostsEvent extends Equatable {
  final Key key;
  const PostsEvent({this.key});

  @override
  List<Object> get props => [key];
}

class LoadPosts extends PostsEvent {
  final int categoryId;
  final String status;

  LoadPosts({this.categoryId, Key key, this.status}) : super(key: key);

  @override
  List<Object> get props => super.props + [categoryId, status];

  @override
  String toString() => "LoadPosts(categoryId: ${this.categoryId})";
}
