import 'package:dayday_flutter/src/connect/feed_connect.dart';
import 'package:dayday_flutter/src/model/feed_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final feedConnect = Get.put(FeedConnect());

class FeedController extends GetxController {
  List<FeedModel> list = [];

  feedIndex(String date, {int page = 1}) async {
    List jsonData = await feedConnect.getList(date, page);
    if (page == 1) {
      list.clear();
    }
    List<FeedModel> tmp = jsonData.map((m) => FeedModel.parse(m)).toList();
    list.addAll(tmp);
    update();
  }

  Future<bool> feedCreate(String title, String content) async {
    try {
      await feedConnect.storeItem(title, content);
      // await feedIndex();
      return true;
    } catch (e) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
        content: Text("$e"),
      ));
      return false;
    }
  }

  // Future<int> upload(String name, String path) async {
  //   Map data = await feedConnect.imageUpload(name, path);
  //   return data['id'];
  // }

  Future<bool> feedShow(int id) async {
    try {
      Map m = await feedConnect.showItem(id);
      return m['is_me'];
    } catch (e) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
        content: Text("$e"),
      ));
      return false;
    }
  }

  Future<bool> feedDelete(int id) async {
    try {
      String result = await feedConnect.deleteItem(id);
      list.removeWhere((element) => element.id == int.parse(result));
      update();
      return true;
    } catch (e) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
        content: Text("$e"),
      ));
      return false;
    }
  }

  Future<bool> feedUpdate(int id, String title, String content) async {
    try {
      Map data = await feedConnect.updateItem(id, title, content);
      int index = list.indexWhere((item) => item.id == id);
      if (index != -1) {
        list[index]
            .updateWith({'title': data['title'], 'content': data['content']});
        update(); // UI 업데이트
      }
      // await feedIndex();
      return true;
    } catch (e) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
        content: Text("$e"),
      ));
      return false;
    }
  }
}
