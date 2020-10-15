part of 'ridecomments_bloc.dart';

abstract class RidecommentsState extends Equatable {
  final Key key;
  const RidecommentsState({this.key});

  @override
  List<Object> get props => [key];
}

class RidecommentsInitial extends RidecommentsState {}

class LoadingComments extends RidecommentsState {}

class CommentsLoadedSuccessfuly extends RidecommentsState {
  final String nextPageUrl;
  final List<Comment> comments;

  const CommentsLoadedSuccessfuly({this.nextPageUrl, this.comments, Key key}) : super(key: key);

  @override
  List<Object> get props => super.props + [nextPageUrl, comments];

  bool get hasNextPage => this.nextPageUrl != null;
  @override
  String toString() => "CommentsLoadedSuccessfuly(comments: ${this.comments.isNotEmpty}, nextPageUrl: ${this.hasNextPage})";
}

class CommentsLoadedFailed extends RidecommentsState {
  final String message;
  final String status;

  const CommentsLoadedFailed({@required this.message, Key key, this.status})
      : assert(message != null),
        super(key: key);

  @override
  List<Object> get props => super.props + [message, status];

  @override
  String toString() => "CommentsLoadedFailed(message: ${this.message}, status: ${this.status})";
}
