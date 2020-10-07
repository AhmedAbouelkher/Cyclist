part of 'rides_bloc.dart';

abstract class RidesState extends Equatable {
  final Key key;
  const RidesState({this.key});

  @override
  List<Object> get props => [key];
}

class RidesInitial extends RidesState {}

class LoadingRides extends RidesState {}

class LoadingRidesCompleted extends RidesState {
  final List<Ride> rides;
  final String nextPageUrl;

  LoadingRidesCompleted({this.rides, Key key, this.nextPageUrl}) : super(key: key);

  bool get hasNextPage => this.nextPageUrl != null;

  @override
  List<Object> get props => super.props + [rides, nextPageUrl];

  @override
  String toString() => "LoadingRidesCompleted(rides: ${this.rides.isNotEmpty}, nextPageUrl: $hasNextPage)";
}

class LoadingRidesFailed extends RidesState {
  final String message;
  final String status;

  LoadingRidesFailed({@required this.message, Key key, this.status})
      : assert(message != null),
        super(key: key);

  @override
  List<Object> get props => super.props + [message, status];

  @override
  String toString() => "LoadingOrdersFailed(message: ${this.message}, status: ${this.status})";
}
