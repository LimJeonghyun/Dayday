import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

final GetStorage _storage = GetStorage();

// 회원 관련된 통신 담당

class UserConnect extends GetConnect {
  Future sendRegister(String email, String name, String password) async {
    Response response = await post('/api/user/register', {
      'email': email,
      'name': name,
      'password': password,
    });

    Map<String, dynamic> body = response.body;

    if (body['result'] == 'fail') {
      throw Exception(body['message']);
    }
    return body['access_token'];
  }

  Future sendLogin(String email, String password) async {
    Response response = await post('/api/user/login', {
      'email': email,
      'password': password,
    });

    Map<String, dynamic> body = response.body;

    if (body['result'] == 'fail') {
      throw Exception(body['message']);
    }
    return body['access_token'];
  }

  Future<Map> getMyInfo() async {
    Response response =
        await get('/api/user/mypage', headers: {'token': await getToken});
    Map<String, dynamic> body = response.body;

    if (body['result'] == 'fail') {
      throw Exception(body['message']);
    }
    return body;
  }

  get getToken async {
    return _storage.read("accesToken");
  }

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
