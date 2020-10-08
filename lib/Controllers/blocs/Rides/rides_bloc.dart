import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cyclist/Controllers/repositories/home/repository.dart';
import 'package:cyclist/models/Rides/rides_response.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

part 'rides_event.dart';
part 'rides_state.dart';

class RidesBloc extends Bloc<RidesEvent, RidesState> {
  final HomeRepo homeRepo;
  RidesBloc({this.homeRepo}) : super(RidesInitial());

  @override
  Stream<RidesState> mapEventToState(
    RidesEvent event,
  ) async* {
    final currentState = state;
    if (event is LoadRides) {
      if (currentState is RidesInitial) {
        yield* _mapEventToState();
      } else if (currentState is LoadingRidesCompleted) {
        if (event.status == "refresh") {
          try {
            final result = await homeRepo.getRides();
            yield LoadingRidesCompleted(
              key: UniqueKey(),
              rides: result.data,
              nextPageUrl: result.nextPageUrl,
            );
          } catch (e) {
            yield LoadingRidesFailed(
              key: UniqueKey(),
              message: e.toString(),
            );
          }
        } else if (event.status == "swipe-refresh") {
          try {
            final result = await homeRepo.getRides();
            yield LoadingRidesCompleted(
              key: UniqueKey(),
              rides: result.data,
              nextPageUrl: result.nextPageUrl,
            );
          } catch (e) {
            yield LoadingRidesFailed(
              key: UniqueKey(),
              message: e.toString(),
            );
          }
        } else if (currentState.nextPageUrl != null) {
          try {
            final _result = await homeRepo.getRides(nextPageUrl: currentState.nextPageUrl);
            yield LoadingRidesCompleted(
              key: UniqueKey(),
              rides: currentState.rides + _result.data,
              nextPageUrl: _result.nextPageUrl,
            );
          } catch (e) {
            print("ERROR WHILE PAGINATTING $e");
          }
        } else {
          print("the End");
        }
      } else if (currentState is LoadingRidesFailed) {
        yield* _mapEventToState();
      }
    }
  }

  Stream<RidesState> _mapEventToState() async* {
    yield LoadingRides();
    try {
      final result = await homeRepo.getRides();
      yield LoadingRidesCompleted(
        key: UniqueKey(),
        rides: result.data,
        nextPageUrl: result.nextPageUrl,
      );
    } catch (e) {
      yield LoadingRidesFailed(
        key: UniqueKey(),
        message: e.toString(),
      );
    }
  }
}
