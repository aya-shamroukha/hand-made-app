import 'package:dio/dio.dart';
import 'package:hand_made_app/core/domin/model/order_model/add_order_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/local_storage/shared_preferences.dart';
import '../model/error_model.dart';

abstract class OrderService {
  getOrder();
  addOrder(AddOrderModel addorder);
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
            "Authorization":
                'Token ${getIt.get<SharedPreferences>().getString('token')}'
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

  @override
  addOrder(AddOrderModel addorder) async {
    Dio dio = Dio();
    try {
      Response response = await dio.post('${baseUrl}order/for_customer',
          data: addorder.toJson(),
          options: Options(sendTimeout: const Duration(seconds: 60), headers: {
            "Content-Type": "application/json",
            "Connection": "keep-alive",
            "Authorization":
                'Token ${getIt.get<SharedPreferences>().getString('token')}'
          }));

      if (response.statusCode == 200) {
        print(response.data);

        return true; // Return success
      } else {
        return false; // Return error
      }
    } on DioException catch (e) {
      print(e.toString());
      print(ErrorModel(message: e.message.toString()));
      return 'false'; // Return error
    }
  }
}
