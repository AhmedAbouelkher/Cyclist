part of 'home_screen_bloc.dart';

@immutable
abstract class HomeScreenEvent {}

class ChangeTap extends HomeScreenEvent {
  final HomeTabs tab;
  ChangeTap({this.tab});
}

class OpenDrawer extends HomeScreenEvent {}

class CloseSearchCLicked extends HomeScreenEvent {}

class GetConfig extends HomeScreenEvent {}

class GetFAV extends HomeScreenEvent {}

class LogOut extends HomeScreenEvent {}
class UserDataChanged extends HomeScreenEvent {}

class SearchChanged extends HomeScreenEvent {
  final String text;
  SearchChanged({this.text});
}

// class UserReachedBottm extends HomeScreenEvent {
//   final ProductsResponse response;
//   UserReachedBottm({this.response});
// }
