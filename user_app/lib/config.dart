class AppConfig {

  AppConfig._internal();

  static AppConfig instance = AppConfig._internal();

  String baseUrl = "http://192.168.3.6:8000";
  String token = "";
  String userId = "";
  String userName = "";
  String email = "";

}