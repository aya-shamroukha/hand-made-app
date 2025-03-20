import 'package:dio/dio.dart';

import '../model/error_model.dart';

abstract class OrderService {
  getOrder();
  late String baseUrl = 'http://199.192.19.220:5400/';
}

class OrderImpl extends OrderService {
  @override
  getOrder() async {
    Dio dio = Dio();
    try {
      Response response = await dio.get('${baseUrl}order/for_customer',
          options: Options(sendTimeout: const Duration(seconds: 60), headers: {
            "Content-Type": "application/json",
            "Connection": "keep-alive",
            "Authorization": 'Token 7056cf4f396977620f5a1852244567fde08117ef'
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
