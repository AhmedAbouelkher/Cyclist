part of 'makeride_bloc.dart';

abstract class MakerideEvent extends Equatable {
  final Key key;
  const MakerideEvent({this.key});

  @override
  List<Object> get props => [key];
}

class MakeNewRide extends MakerideEvent {
  final RidePost ride;

  MakeNewRide({
    Key key,
    @required this.ride,
  })  : assert(ride != null),
        super(key: key);

  @override
  List<Object> get props => super.props + [ride];

  // @override
  // String toString() => "MakeNewRide(ride: ${this.ride})";
}
