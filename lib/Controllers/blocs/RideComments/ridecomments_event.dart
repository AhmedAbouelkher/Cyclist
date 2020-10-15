part of 'ridecomments_bloc.dart';

abstract class RidecommentsEvent extends Equatable {
  final Key key;
  const RidecommentsEvent({this.key});

  @override
  List<Object> get props => [key];
}

class GetRideComments extends RidecommentsEvent {
  final int rideId;
  final String status;

  const GetRideComments({this.rideId, this.status, Key key}) : super(key: key);

  @override
  List<Object> get props => super.props + [rideId, status];
}
