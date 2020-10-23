import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:cyclist/Controllers/repositories/home/repository.dart';
import 'package:cyclist/models/Rides/ride_data.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

part 'ridecomments_event.dart';
part 'ridecomments_state.dart';

class RidecommentsBloc extends Bloc<RidecommentsEvent, RidecommentsState> {
  final HomeRepo homeRepo;
  RidecommentsBloc({this.homeRepo}) : super(RidecommentsInitial());

  List<Comment> _comments;
  List<Comment> get comments => _comments;

  void addComment({@required int rideId, @required String comment}) {
    final _timeNowFormate = DateFormat("yyyy-MM-dd h:mm a").format(DateTime.now());
    _comments.add(Comment(
      id: Random().nextInt(99),
      updatedAt: _timeNowFormate,
      createdAt: _timeNowFormate,
      comment: comment,
      rideId: rideId.toString(),
    ));
  }

  @override
  Stream<RidecommentsState> mapEventToState(
    RidecommentsEvent event,
  ) async* {
    final currentState = state;
    if (event is GetRideComments) {
      if (currentState is RidecommentsInitial) {
        yield* _mapEventToState(event: event);
      } else if (currentState is CommentsLoadedSuccessfuly) {
        if (event.status == "refresh") {
          yield* _mapEventToStateNoLoading(event: event);
        } else if (event.status == "swipe-refresh") {
          yield* _mapEventToStateNoLoading(event: event);
        } else if (event.status == "initial") {
          yield* _mapEventToState(event: event);
        } else if (currentState.hasNextPage) {
          try {
            final _result = await homeRepo.getComments(rideId: event.rideId, nextPageUrl: currentState.nextPageUrl);
            _comments = currentState.comments + _result.data;
            yield CommentsLoadedSuccessfuly(
              comments: currentState.comments + _result.data,
              nextPageUrl: _result.nextPageUrl,
            );
          } catch (e) {
            print("ERROR WHILE PAGINATTING $e");
          }
        } else {
          print("the End");
        }
      } else if (currentState is CommentsLoadedFailed) {
        yield* _mapEventToState(event: event);
      }
    }
  }

  Stream<RidecommentsState> _mapEventToState({GetRideComments event}) async* {
    yield LoadingComments();
    try {
      final result = await homeRepo.getComments(rideId: event.rideId);
      _comments = result.data;
      yield CommentsLoadedSuccessfuly(
        comments: result.data,
        nextPageUrl: result.nextPageUrl,
      );
    } catch (e) {
      yield CommentsLoadedFailed(
        message: e.toString(),
      );
    }
  }

  Stream<RidecommentsState> _mapEventToStateNoLoading({GetRideComments event}) async* {
    try {
      final result = await homeRepo.getComments(rideId: event.rideId);
      _comments = result.data;
      yield CommentsLoadedSuccessfuly(
        comments: result.data,
        nextPageUrl: result.nextPageUrl,
      );
    } catch (e) {
      yield CommentsLoadedFailed(
        message: e.toString(),
      );
    }
  }
}
