import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cyclist/utils/enums.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'home_screen_event.dart';
part 'home_screen_state.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  @override
  HomeScreenState get initialState => HomeScreenInitial();

  static HomeScreenBloc of(BuildContext context) => BlocProvider.of<HomeScreenBloc>(context);

  @override
  Stream<HomeScreenState> mapEventToState(
    HomeScreenEvent event,
  ) async* {
    if (event is ChangeTap) {
      yield TabChanged(tab: event.tab);
    } else if (event is OpenDrawer) {
      yield OpenDrawerState();
    } else if (event is CloseSearchCLicked) {
      yield CloseSearchState();
    } else if (event is SearchChanged) {
      yield SearchLoading();
      if (event.text == '') {
        yield CloseSearchState();
      } else {
        // try {
        //   ProductsResponse response = await ProductsRepo()
        //       .getProducts(keyWord: event.text, type: CatType.search);
        //   if (response.productsList.length == 0) {
        //     print('empty result form bloc');
        //     yield SearchEmpty();
        //   } else {
        //     yield SearchResultChanged(response: response);
        //   }
        // } catch (e) {
        //   yield SearchErr();
        // }
      }
    } else if (event is LogOut) {
      yield UserLoggedOut();
    }
    //  else if (event is UserDataChanged) {
    //   yield NewUserData(user: await AuthRepo().getCurrentUser());
    // }
  }
}
