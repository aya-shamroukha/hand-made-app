import 'package:hand_made_app/core/domin/model/ai_model/ai_model.dart';

class AiBlocEvent {}

class AiEventSuccess extends AiBlocEvent {
  final AiModel aiModel;

  AiEventSuccess({required this.aiModel});
}
class DownloadImageEvent extends AiBlocEvent{}