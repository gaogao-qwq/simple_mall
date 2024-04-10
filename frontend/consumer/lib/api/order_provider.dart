import 'package:consumer/env.dart';
import 'package:get/get.dart';

class OrderProvider extends GetConnect {

  @override
  void onInit() {
    httpClient.baseUrl = Env.apiUri;
    super.onInit();
  }

}
