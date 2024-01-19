import 'package:funeral_menu/model/category_model.dart';
import 'package:funeral_menu/state/state.dart';

abstract class CategoryState {}

class CategoryStateNone extends NoneState implements CategoryState {}

class CategoryStateLoading extends LoadingState implements CategoryState {}

class CategoryStateSuccess extends SuccessState<List<CategoryModel>>
    implements CategoryState {
  CategoryStateSuccess(super.data);
}

class CategoryStateError extends ErrorState implements CategoryState {
  CategoryStateError(super.message);
}
