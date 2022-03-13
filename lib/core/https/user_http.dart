import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_http_mockapi/core/models/user.dart';
import 'package:my_http_mockapi/core/resources/environtment.dart';

class UserHttp {
  Future<List<User>> listOfUsers() async {
    try {
      var resp = await http.get(Uri.parse(endpoint));
      if (resp.statusCode == 200) {
        List map = jsonDecode(resp.body);
        print(map);
        List<User> users = map.map((e) => User.fromJson(e)).toList();
        return users;
      } else {
        return [];
      }
    } catch (e) {
      print(e);
    }
    return [];
  }

  Future users() async {
    try {
      var resp = await http.get(Uri.parse(endpoint));
      if (resp.statusCode == 200) {
        List map = jsonDecode(resp.body);
        List<User> users = map.map((e) => User.fromJson(e)).toList();
        return users;
      } else {
        return [];
      }
    } catch (e) {
      print(e);
    }
  }

  Future addUsers(String name) async {
    try {
      var body = {"name": name};
      var resp = await http.post(Uri.parse(endpoint), body: body);
      if (resp.statusCode <= 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<bool> addUser(String name, {DateTime? date, String avatar = "avatar", String id = "1"}) async {
    try {
      Map<String, dynamic> userMap = User(name: name, createdAt: DateTime.now(), avatar: avatar, id: id).toJson();
      print("userMap: $userMap");

      String encode = jsonEncode(userMap);
      print("jsonEncode: $encode");
      var decode = jsonDecode(encode);
      print("jsonDecode: $decode");

      var resp = await http.post(Uri.parse(endpoint), body: decode);
      print("resp ${resp.body}");
      if (resp.statusCode <= 201) {
        return true;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  Future updateUsers(String name) async {
    try {
      var body = {"name": name};
      var resp = await http.put(Uri.parse(endpoint), body: body);
      if (resp.statusCode <= 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
    }
  }

  Future deleteUsers(String id) async {
    try {
      var resp = await http.delete(Uri.parse("${endpoint}/$id"));
      if (resp.statusCode <= 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
    }
  }
}
