import 'package:funeral_menu/model/image_model.dart';
import 'package:funeral_menu/state/state.dart';

abstract class ImageListViewState {}

class ImageListViewStateNone extends NoneState implements ImageListViewState {}

class ImageListViewStateLoading extends LoadingState
    implements ImageListViewState {}

class ImageListViewStateSuccess extends SuccessState<List<ImageModel>>
    implements ImageListViewState {
  ImageListViewStateSuccess(super.data);
}

class ImageListViewStateError extends ErrorState implements ImageListViewState {
  ImageListViewStateError(super.message);
}
