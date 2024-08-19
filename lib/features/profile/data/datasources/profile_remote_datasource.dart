import 'dart:convert';

import '../models/profile_model.dart';
import 'package:http/http.dart' as http;

abstract class ProfileRemoteDatasource {
  Future<List<ProfileModel>> getAllUser(int page);
  Future<ProfileModel> getUser(int id);
}

class ProfileRemoteDatasourceImpl implements ProfileRemoteDatasource {
  final http.Client client;

  ProfileRemoteDatasourceImpl({required this.client});
  @override
  Future<List<ProfileModel>> getAllUser(int page) async {
    // https://reqres.in/api/users?page=2
    final response = await client.get(Uri.parse('https://reqres.in/api/users?page=$page'));

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data'];
      return data.map((e) => ProfileModel.fromJson(e)).toList();
    } else {
      throw UnimplementedError();
    }
  }

  @override
  Future<ProfileModel> getUser(int id) async {
    // https://reqres.in/api/users/3
    final response = await client.get(Uri.parse('https://reqres.in/api/users/$id'));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body)['data'];
      return ProfileModel.fromJson(data);
    } else {
      throw UnimplementedError();
    }
  }
}
