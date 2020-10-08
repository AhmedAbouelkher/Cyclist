part of 'categories_bloc.dart';

abstract class CategoriesState extends Equatable {
  final Key key;
  const CategoriesState({this.key});

  @override
  List<Object> get props => [key];
}

class CategoriesInitial extends CategoriesState {}

class LoadingCategories extends CategoriesState {}

class CategoriesLoaded extends CategoriesState {
  final List<Category> categories;
  final String nextPageUrl;
  const CategoriesLoaded({this.categories, Key key, this.nextPageUrl}) : super(key: key);

  @override
  List<Object> get props => super.props + [categories, nextPageUrl];

  bool get hasNextPage => this.nextPageUrl != null;

  @override
  String toString() => "CategoriesLoaded(categories: ${this.categories.isNotEmpty}, nextPageUrl: ${this.hasNextPage})";
}

class LoadingCategoriesFailed extends CategoriesState {
  final String message;
  final String status;

  const LoadingCategoriesFailed({@required this.message, Key key, this.status})
      : assert(message != null),
        super(key: key);

  @override
  List<Object> get props => super.props + [message, status];

  @override
  String toString() => "LoadingCategoriesFailed(message: ${this.message}, status: ${this.status})";
}
