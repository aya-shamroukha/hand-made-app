import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/config/local_storage/shared_preferences.dart';
import '../../../../core/domin/service/ai_service.dart';
import 'ai_bloc_event.dart';
import 'ai_bloc_state.dart';

class AiBlocBloc extends Bloc<AiBlocEvent, AiBlocState> {
  final craftImagePath = getIt.get<SharedPreferences>().getString('craftimage');

  AiBlocBloc() : super(AiBlocInitial()) {
    on<AiEventSuccess>((event, emit) async {
      emit(AiLoadingState());
      try {
        print('---------------------------------------------------------');
        print('befor ai');
        final res = await AiImpl().sofaPillow(event.aiModel);
        dynamic data = (res['image_url']);
        print('---------------------------------------------------------');
        print(res);

        emit(AiSuccessState(imageUrl: data));
      } catch (e) {
        emit(AiErrorState(message: 'error'));
      }
    });
    on<DownloadImageEvent>(
      (event, emit) async {
        Dio dio = Dio();
        Directory directory = await getApplicationDocumentsDirectory();

        String filePath = '${directory.path}/downloaded_image.png';
        var response = await dio.download('$craftImagePath', filePath);
        print('--------------------');
        print(response.statusCode);
        final downloadedFile = File(filePath);
        // final File downloadedImage = await filePath;
        //   getIt.get<SharedPreferences>().set('image', filePath);
        if (downloadedFile.existsSync()) {
          print("Image downloaded successfully at: $filePath");
          await getIt.get<SharedPreferences>().setString('image', filePath);
          emit(DownLoadImageSate());
        } else {
          print("Image not saved correctly.");
        }
      },
    );
  }
}
