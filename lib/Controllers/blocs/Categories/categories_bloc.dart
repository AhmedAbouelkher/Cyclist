import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cyclist/Controllers/repositories/home/repository.dart';
import 'package:cyclist/models/Categories/categories_response.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' hide Category;

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final HomeRepo homeRepo;
  CategoriesBloc({this.homeRepo}) : super(CategoriesInitial());

  @override
  Stream<CategoriesState> mapEventToState(
    CategoriesEvent event,
  ) async* {
    final currentState = state;
    if (event is LoadCategories) {
      if (currentState is CategoriesInitial) {
        yield* _mapEventToState(event: event);
      } else if (currentState is CategoriesLoaded) {
        if (event.status == "refresh") {
          yield* _mapEventToStateNoLoading(event: event);
        } else if (event.status == "swipe-refresh") {
          yield* _mapEventToStateNoLoading(event: event);
        } else if (event.status == "initial") {
          yield* _mapEventToState(event: event);
        } else if (currentState.nextPageUrl != null) {
          try {
            final _result = await homeRepo.getCategories(nextPageUrl: currentState.nextPageUrl);
            yield CategoriesLoaded(
              categories: currentState.categories + _result.data,
              nextPageUrl: _result.nextPageUrl,
            );
          } catch (e) {
            print("ERROR WHILE PAGINATTING $e");
          }
        } else {
          print("the End");
        }
      } else if (currentState is LoadingCategoriesFailed) {
        yield* _mapEventToState(event: event);
      }
    }
  }

  Stream<CategoriesState> _mapEventToState({LoadCategories event}) async* {
    yield LoadingCategories();
    try {
      final result = await homeRepo.getCategories();
      yield CategoriesLoaded(
        categories: result.data,
        nextPageUrl: result.nextPageUrl,
      );
    } catch (e) {
      yield LoadingCategoriesFailed(
        message: e.toString(),
      );
    }
  }

  Stream<CategoriesState> _mapEventToStateNoLoading({LoadCategories event}) async* {
    try {
      final result = await homeRepo.getCategories();
      yield CategoriesLoaded(
        categories: result.data,
        nextPageUrl: result.nextPageUrl,
      );
    } catch (e) {
      yield LoadingCategoriesFailed(
        message: e.toString(),
      );
    }
  }
}
