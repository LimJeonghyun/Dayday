import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

final GetStorage _storage = GetStorage();

class FeedConnect extends GetConnect {
  getList(String date, int page) async {
    Response response = await get(
      '/api/feed/$date',
      query: {'page': page.toString()},
      headers: {'token': await getToken},
    );
    if (response.statusCode == null) throw Exception('통신 에러');

    // print(response.bodyString);
    Map<String, dynamic> body = response.body;
    print(body);
    if (body['result'] == 'fail') {
      throw Exception(body['message']);
    }
    return body['data'];
  }

  storeItem(String title, String content) async {
    Response response = await post(
      '/api/feed',
      {
        'title': title,
        'content': content,
      },
      headers: {'token': await getToken},
    );
    if (response.statusCode == null) throw Exception('통신 에러');
    Map<String, dynamic> body = response.body;
    if (body['result'] == 'fail') {
      throw Exception(body['message']);
    }
    return body['data'];
  }

  // imageUpload(String name, String path) async {
  //   final form = FormData({'file': MultipartFile(path, filename: name)});
  //   Response response = await post('/api/file', form);
  //   if (response.statusCode == null) throw Exception('통신 에러');
  //   return response.body;
  // }

  showItem(int id) async {
    Response response = await get(
      '/api/feed/show/$id',
      headers: {'token': await getToken},
    );
    if (response.statusCode == null) throw Exception('통신 에러');
    Map<String, dynamic> body = response.body;
    print(body);
    if (body['result'] == 'fail') {
      throw Exception(body['message']);
    }
    return body['data'];
  }

  deleteItem(int id) async {
    Response response = await delete(
      '/api/feed/$id',
      headers: {'token': await getToken},
    );
    if (response.statusCode == null) throw Exception('통신 에러');
    Map<String, dynamic> body = response.body;
    if (body['result'] == 'fail') {
      throw Exception(body['message']);
    }
    return body['data'];
  }

  updateItem(int id, String title, String content) async {
    Response response = await put(
      '/api/feed/$id',
      {'title': title, 'content': content},
      headers: {'token': await getToken},
    );
    if (response.statusCode == null) throw Exception('통신 에러');
    Map<String, dynamic> body = response.body;
    if (body['result'] == 'fail') {
      throw Exception(body['message']);
    }
    return body['data'];
  }

  get getToken => _storage.read("access_token");

  @override
  void onInit() {
    allowAutoSignedCert = true;
    httpClient.baseUrl = 'http://localhost:3000';
    httpClient.addRequestModifier<void>((request) {
      request.headers['Accept'] = 'application/json';
      return request;
    });
    super.onInit();
  }
}
