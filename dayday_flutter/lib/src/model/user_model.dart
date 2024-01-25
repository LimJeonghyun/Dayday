class UserModel {
  int? id;
  String? name;
  String? email;

  UserModel.fromJson(Map m) {
    id = m['id'];
    name = m['name'];
    email = m['email'];
  }
}
