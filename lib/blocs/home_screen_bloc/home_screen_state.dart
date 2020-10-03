part of 'home_screen_bloc.dart';

@immutable
abstract class HomeScreenState {}

class HomeScreenInitial extends HomeScreenState {}

class TabChanged extends HomeScreenState {
  final HomeTabs tab;
  TabChanged({this.tab});
}

class OpenDrawerState extends HomeScreenState {}

class CloseSearchState extends HomeScreenState {}

// class ConfigChanged extends HomeScreenState {
//   final ConfigResponse config;
//   ConfigChanged({this.config});
// }

// class SlidesChanged extends HomeScreenState {
//   final List<Slide> slides;
//   SlidesChanged({this.slides});
// }

class FaveChanged extends HomeScreenState {}

class FaveErro extends HomeScreenState {
  final String msg;
  FaveErro({this.msg});
}

class ConfigErr extends HomeScreenState {
  final String msg;
  ConfigErr({this.msg});
}

// class SearchResultChanged extends HomeScreenState {
//   final ProductsResponse response;
//   SearchResultChanged({this.response});
// }

class SearchLoading extends HomeScreenState {}

class SearchEmpty extends HomeScreenState {}

class SearchErr extends HomeScreenState {}

class NewUserData extends HomeScreenState {
  // final User user ;
  // NewUserData({this.user});
}

class UserLoggedOut extends HomeScreenState {}

// class SearchResult extends HomeScreenState {
//   final ProductsResponse response;
//   SearchResult({this.response});
// }

// class MoreSearchResult extends HomeScreenState {
//   final ProductsResponse response;
//   MoreSearchResult({this.response});
// }

class Loading extends HomeScreenState {}
