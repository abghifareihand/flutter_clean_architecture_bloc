// import 'package:hive/hive.dart';

// import '../models/profile_model.dart';

// abstract class ProfileLocalDatasource {
//   Future<List<ProfileModel>> getAllUser(int page);
//   Future<ProfileModel> getUser(int id);
// }

// class ProfileLocalDatasourceImpl implements ProfileLocalDatasource {
//   final HiveInterface hive;

//   ProfileLocalDatasourceImpl(this.hive);
//   @override
//   Future<List<ProfileModel>> getAllUser(int page) async {
//     Box box = hive.box('profile_box');
//     return box.get('getAllUser');
//   }

//   @override
//   Future<ProfileModel> getUser(int id) async {
//     Box box = hive.box('profile_box');
//     return box.get('getUser');
//   }
// }

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/profile_model.dart';

abstract class ProfileLocalDatasource {
  Future<List<ProfileModel>> getAllUser(int page);
  Future<ProfileModel> getUser(int id);
  Future<void> saveAllUser(int page, List<ProfileModel> profiles);
  Future<void> saveUser(int id, ProfileModel profile);
}

class ProfileLocalDatasourceImpl implements ProfileLocalDatasource {
  static const _allUserKey = 'all_user'; // Key for storing all users
  static const _userKeyPrefix = 'user_'; // Key prefix for individual users

  final SharedPreferences prefs;

  ProfileLocalDatasourceImpl({required this.prefs});

  @override
  Future<List<ProfileModel>> getAllUser(int page) async {
    final jsonString = prefs.getString('$_allUserKey$page');
    if (jsonString == null) {
      return []; // Return empty list if no data
    }
    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((json) => ProfileModel.fromJson(json)).toList();
  }

  @override
  Future<ProfileModel> getUser(int id) async {
    final jsonString = prefs.getString('$_userKeyPrefix$id');
    if (jsonString == null) {
      throw Exception('User not found'); // Handle error if user not found
    }
    final Map<String, dynamic> json = jsonDecode(jsonString);
    return ProfileModel.fromJson(json);
  }

  @override
  Future<void> saveAllUser(int page, List<ProfileModel> profiles) async {
    final List<Map<String, dynamic>> jsonList = profiles.map((profile) => profile.toJson()).toList();
    final jsonString = jsonEncode(jsonList);
    await prefs.setString('$_allUserKey$page', jsonString);
  }

  @override
  Future<void> saveUser(int id, ProfileModel profile) async {
    final jsonString = jsonEncode(profile.toJson());
    await prefs.setString('$_userKeyPrefix$id', jsonString);
  }
}
