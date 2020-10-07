import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cyclist/Controllers/repositories/UserToken/repository.dart';
import 'package:cyclist/models/Rides/ride_post_request.dart';
import 'package:cyclist/models/Rides/ride_response.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

part 'makeride_event.dart';
part 'makeride_state.dart';

class MakerideBloc extends Bloc<MakerideEvent, MakerideState> {
  final HomeRepo homeRepo;
  MakerideBloc({this.homeRepo}) : super(MakerideInitial());

  @override
  Stream<MakerideState> mapEventToState(MakerideEvent event) async* {
    if (event is MakeNewRide) {
      yield* _mapEventToState(event);
    }
  }

  Stream<MakerideState> _mapEventToState(MakeNewRide event) async* {
    yield MakingNewRide();
    try {
      final result = await homeRepo.storeRide(ridePost: event.ride);
      yield MakingNewRideCompleted(key: UniqueKey(), ride: result);
    } catch (e) {
      yield MakingRideFailed(message: e.toString(), key: UniqueKey());
    }
  }
}
