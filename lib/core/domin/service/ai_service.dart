
import 'package:dio/dio.dart';
import 'package:hand_made_app/core/domin/model/ai_model/ai_model.dart';


import '../model/error_model.dart';

abstract class AiService {
  sofaPillow(AiModel aimodel);
  late String baseUrl = 'http://199.192.19.220:5400/';
}

class AiImpl extends AiService {
  @override
  sofaPillow(aimodel) async {
    FormData formData = FormData.fromMap(aimodel.toMultipartData());
    Dio dio = Dio();
    final response = await dio.post(
      'http://199.192.19.220:5400/ml_model/sofaPillowImage/',
      data: formData,
      options: Options(
        headers: {
          "Content-Type": "multipart/form-data",
          "Connection": "keep-alive",
        },
      ),
    );

    if (response.statusCode == 200) {
      // print(response.toString());
      return response.data;
    } else {
      return ErrorModel(
          message: 'The Status Code is not 200. Please check the endpoint.');
    }
  }
}


