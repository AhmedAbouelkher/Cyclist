part of 'rides_bloc.dart';

abstract class RidesEvent extends Equatable {
  final Key key;
  const RidesEvent({this.key});

  @override
  List<Object> get props => [key];
}

class LoadRides extends RidesEvent {
  final Key key;
  final String status;
  LoadRides({this.key, this.status}) : super(key: key);

  @override
  List<Object> get props => super.props + [status];
}
