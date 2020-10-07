part of 'makeride_bloc.dart';

abstract class MakerideState extends Equatable {
  final Key key;
  const MakerideState({this.key});

  @override
  List<Object> get props => [key];
}

class MakerideInitial extends MakerideState {}

class MakingNewRide extends MakerideState {}

class MakingNewRideCompleted extends MakerideState {
  final RideResponse ride;

  MakingNewRideCompleted({this.ride, Key key}) : super(key: key);

  @override
  List<Object> get props => super.props + [ride];

  @override
  String toString() => "MakingNewRideCompleted(message: ${this.ride.message})";
}

class MakingRideFailed extends MakerideState {
  final String message;
  final String status;

  MakingRideFailed({@required this.message, Key key, this.status})
      : assert(message != null),
        super(key: key);

  @override
  List<Object> get props => super.props + [message, status];

  @override
  String toString() => "MakingRideFailed(message: ${this.message}, status: ${this.status})";
}
