import 'package:dayday_flutter/src/connect/user_connect.dart';
import 'package:dayday_flutter/src/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'src/app.dart';

void main() async {
  await GetStorage.init();

  // 로그인 여부 체크
  final userController = Get.put(UserController());
  bool isLogin = await userController.isLogin();

  runApp(MyApp(isLogin));
}
