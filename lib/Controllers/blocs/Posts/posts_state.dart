part of 'posts_bloc.dart';

abstract class PostsState extends Equatable {
  final Key key;
  const PostsState({this.key});

  @override
  List<Object> get props => [key];
}

class PostsInitial extends PostsState {}

class LoadingPosts extends PostsState {}

class PostsLoaded extends PostsState {
  final List<Post> posts;
  final String nextPageUrl;
  const PostsLoaded({this.posts, Key key, this.nextPageUrl}) : super(key: key);

  @override
  List<Object> get props => super.props + [posts, nextPageUrl];

  bool get hasNextPage => this.nextPageUrl != null;

  @override
  String toString() => "PostsLoaded(posts: ${this.posts.isNotEmpty}, nextPageUrl: ${this.hasNextPage})";
}

class LoadingPostsFailed extends PostsState {
  final String message;
  final String status;

  const LoadingPostsFailed({@required this.message, Key key, this.status})
      : assert(message != null),
        super(key: key);

  @override
  List<Object> get props => super.props + [message, status];

  @override
  String toString() => "LoadingPostsFailed(message: ${this.message}, status: ${this.status})";
}
