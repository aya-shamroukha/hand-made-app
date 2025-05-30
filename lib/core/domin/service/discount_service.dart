import 'package:dio/dio.dart';


import '../model/error_model.dart';

abstract class DiscountService {
  getAllDiscount();
  late String baseUrl = 'http://199.192.19.220:5400/';
}

class DiscountImpl extends DiscountService {
  @override
  getAllDiscount() async {
    Dio dio = Dio();
    try {
      Response response = await dio.get('${baseUrl}discount/',
          options: Options(sendTimeout: const Duration(seconds: 60), headers: {
            "Connection": "keep-alive",
            "Authorization":
                'Token 312cf2d49d5b03d61839937a5652bc56be94eb7c'
          }));

      if (response.statusCode == 200) {
        print(response.data);

        return response.data; // Return success
      } else {
        return 'false'; // Return error
      }
    } on DioException catch (e) {
      print(ErrorModel(message: e.message.toString()));
      return 'false'; // Return error
    }
  }
}
