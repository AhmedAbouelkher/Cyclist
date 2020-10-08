import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cyclist/Controllers/repositories/home/repository.dart';
import 'package:cyclist/models/posts/posts_response.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final HomeRepo homeRepo;
  PostsBloc({this.homeRepo}) : super(PostsInitial());

  @override
  Stream<PostsState> mapEventToState(
    PostsEvent event,
  ) async* {
    final currentState = state;
    if (event is LoadPosts) {
      if (currentState is PostsInitial) {
        yield* _mapEventToState(event: event);
      } else if (currentState is PostsLoaded) {
        if (event.status == "refresh") {
          yield* _mapEventToStateNoLoading(event: event);
        } else if (event.status == "swipe-refresh") {
          yield* _mapEventToStateNoLoading(event: event);
        } else if (event.status == "initial") {
          yield* _mapEventToState(event: event);
        } else if (currentState.nextPageUrl != null) {
          try {
            final _result = await homeRepo.getPosts(categoryId: event.categoryId, nextPageUrl: currentState.nextPageUrl);
            yield PostsLoaded(
              key: UniqueKey(),
              posts: currentState.posts + _result.data,
              nextPageUrl: _result.nextPageUrl,
            );
          } catch (e) {
            print("ERROR WHILE PAGINATTING $e");
          }
        } else {
          print("the End");
        }
      } else if (currentState is LoadingPostsFailed) {
        yield* _mapEventToState(event: event);
      }
    }
  }

  Stream<PostsState> _mapEventToState({LoadPosts event}) async* {
    yield LoadingPosts();
    try {
      final result = await homeRepo.getPosts(categoryId: event.categoryId);
      yield PostsLoaded(
        key: UniqueKey(),
        posts: result.data,
        nextPageUrl: result.nextPageUrl,
      );
    } catch (e) {
      yield LoadingPostsFailed(
        key: UniqueKey(),
        message: e.toString(),
      );
    }
  }

  Stream<PostsState> _mapEventToStateNoLoading({LoadPosts event}) async* {
    try {
      final result = await homeRepo.getPosts(categoryId: event.categoryId);
      yield PostsLoaded(
        key: UniqueKey(),
        posts: result.data,
        nextPageUrl: result.nextPageUrl,
      );
    } catch (e) {
      yield LoadingPostsFailed(
        key: UniqueKey(),
        message: e.toString(),
      );
    }
  }
}
