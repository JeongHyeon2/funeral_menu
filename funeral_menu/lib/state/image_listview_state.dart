import 'package:funeral_menu/state/state.dart';

abstract class ImageListViewState {}

class ImageListViewStateNone extends NoneState implements ImageListViewState {}

class ImageListViewStateLoading extends LoadingState
    implements ImageListViewState {}

class ImageListViewStateSuccess extends SuccessState<List<String>>
    implements ImageListViewState {
  ImageListViewStateSuccess(super.data);
}

class ImageListViewStateError extends ErrorState implements ImageListViewState {
  ImageListViewStateError(super.message);
}
