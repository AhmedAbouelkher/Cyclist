part of 'categories_bloc.dart';

abstract class CategoriesEvent extends Equatable {
  final Key key;
  const CategoriesEvent({this.key});

  @override
  List<Object> get props => [key];
}

class LoadCategories extends CategoriesEvent {
  final String status;

  const LoadCategories({Key key, this.status}) : super(key: key);

  @override
  List<Object> get props => super.props + [status];

  @override
  String toString() => "LoadCategories()";
}
