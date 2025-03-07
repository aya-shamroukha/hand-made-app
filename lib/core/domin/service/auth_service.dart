// ignore_for_file: avoid_print
import 'package:dio/dio.dart';
import 'package:hand_made_app/core/config/local_storage/shared_preferences.dart';
import 'package:hand_made_app/core/domin/model/auth_model/login_model.dart';
import 'package:hand_made_app/core/domin/model/auth_model/signup_model.dart';
import 'package:hand_made_app/core/domin/model/error_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthService {
  logOut();
  signUp(SignUpModel signup);
  logIn(LogInModel login);
  late String baseUrl = 'https://nourwanli.pythonanywhere.com/';
}

class AuthServiceImpl extends AuthService {
  @override
  logIn(login) async {
    Dio dio = Dio();
    try {
      Response response = await dio.post('${baseUrl}customers/login',
          options: Options(sendTimeout: const Duration(seconds: 60), headers: {
            "Content-Type": "application/json",
            "Connection": "keep-alive"
          }),
          data: login.toJson());
      if (response.statusCode == 200) {
        print(response.data);
        print(response.data['token']);
        getIt
            .get<SharedPreferences>()
            .setString('token', response.data['token']);
        return true;
      } else {
        print(ErrorModel(message: 'The Status Code is not 200').message);
        return false;
      }
    } on DioException catch (e) {
      print(ExceptionModel(message: e.message.toString()).message);
      return false;
    }
  }

  @override
  signUp(signup) async {
    Dio dio = Dio();
    try {
      Response response = await dio.post('${baseUrl}customers/register',
          options: Options(sendTimeout: const Duration(seconds: 60), headers: {
            "Content-Type": "application/json",
            "Connection": "keep-alive"
          }),
          data: signup.toJson());
      if (response.statusCode == 200) {
        print(response);
        print(response.data['token']);
        getIt
            .get<SharedPreferences>()
            .setString('token', response.data['token']);
        return true;
      } else {
        print(ErrorModel(message: 'The Status Code is not 200').message);
        return false;
      }
    } on DioException catch (e) {
      print(ExceptionModel(message: e.message.toString()).message);
      return false;
    }
  }

  @override
  logOut() async {
    Dio dio = Dio();
    try {
      Response response = await dio.post(
        '${baseUrl}customers/logout',
        options: Options(sendTimeout: const Duration(seconds: 60), headers: {
          "Content-Type": "application/json",
          "Connection": "keep-alive",
          "Authorization":
              "Token ${getIt.get<SharedPreferences>().getString('token')}"
        }),
      );
      if (response.statusCode == 200) {
        print(response);
        // print(response.data['token']);
        // getIt
        //     .get<SharedPreferences>()
        //     .setString('token', response.data['token']);
        return true;
      } else {
        print(ErrorModel(message: 'The Status Code is not 200').message);
        return false;
      }
    } on DioException catch (e) {
      print(ExceptionModel(message: e.message.toString()).message);
      return false;
    }
  }
}
// import 'package:dartz/dartz.dart';
// import 'package:dio/dio.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// Future<Either<ErrorModel, bool>> logIn(login) async {
//   Dio dio = Dio();
//   try {
//     Response response = await dio.post('${baseUrl}customers/login',
//         options: Options(sendTimeout: const Duration(seconds: 60), headers: {
//           "Content-Type": "application/json",
//           "Connection": "keep-alive"
//         }),
//         data: login.toJson());
    
//     if (response.statusCode == 200) {
//       print(response.data);
//       print(response.data['token']);
//       await getIt.get<SharedPreferences>().setString('token', response.data['token']);
//       return Right(true); // Return success
//     } else {
//       return Left(ErrorModel(message: 'The Status Code is not 200')); // Return error
//     }
//   } on DioException catch (e) {
//     return Left(ExceptionModel(message: e.message.toString())); // Return error
//   }
// }
