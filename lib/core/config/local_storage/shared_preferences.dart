import 'package:get_it/get_it.dart';
import 'package:hand_made_app/core/config/local_storage/sqflite.dart';
import 'package:shared_preferences/shared_preferences.dart';

 final GetIt getItSql = GetIt.instance;
final getIt = GetIt.instance;
initgetit() async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();

  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
   getIt.registerLazySingleton<Sqflite>(() => Sqflite());
}





// class SharedPreferencesUtil{
//   final SharedPreferences sharedPreferences;

//   SharedPreferencesUtil({required this.sharedPreferences});

//  static String namekey='aya';
//  String? getName({required String string}){
//   return  sharedPreferences.getString(string);
  
//  }
//  Future<bool>setName(String name)async{
//   return sharedPreferences.setString(namekey, name);
//  }
//  int? getInt({required String intt}){
//   return sharedPreferences.getInt(intt);
//  }
// }
