import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';

abstract class UserLocalDatasource {
  Future<List<UserModel>> getUserList();
  Future<void> saveUserList(List<UserModel> users);
}

class UserLocalDatasourceImpl implements UserLocalDatasource {
  static const _allUserKey = 'all_user'; // Key for storing all users

  final SharedPreferences prefs;

  UserLocalDatasourceImpl({required this.prefs});

  @override
  Future<List<UserModel>> getUserList() async {
    final jsonString = prefs.getString(_allUserKey);
    if (jsonString == null) {
      return []; // Return empty list if no data
    }
    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((json) => UserModel.fromJson(json)).toList();
  }

  @override
  Future<void> saveUserList(List<UserModel> users) async {
    final List<Map<String, dynamic>> jsonList = users.map((profile) => profile.toJson()).toList();
    final jsonString = jsonEncode(jsonList);
    await prefs.setString(_allUserKey, jsonString);
  }
}
