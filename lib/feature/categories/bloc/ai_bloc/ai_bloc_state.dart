
class AiBlocState {}

final class AiBlocInitial extends AiBlocState {}

class AiSuccessState extends AiBlocState {
  final dynamic imageUrl;

  AiSuccessState({required this.imageUrl});
}

class AiLoadingState extends AiBlocState {}

class AiErrorState extends AiBlocState {
  final String message;

  AiErrorState({required this.message});
}
class DownLoadImageSate extends AiBlocState{}