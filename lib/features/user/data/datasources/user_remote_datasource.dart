import 'dart:convert';
import 'dart:developer';
import '../models/user_model.dart';
import '../../../../core/error/exception.dart';
import 'package:http/http.dart' as http;

abstract class UserRemoteDatasource {
  Future<List<UserModel>> getUserList();
  Future<UserModel> getUserDetail(String id);
  Future<UserModel> addUser(String name, String email, String address);
  Future<UserModel> editUser(String id, String name, String email, String address);
  Future<UserModel> deleteUser(String id);
}

class UserRemoteDatasourceImpl implements UserRemoteDatasource {
  static const mockapiKey = '66c30af6d057009ee9bed4b6';
  final http.Client client;

  UserRemoteDatasourceImpl({required this.client});

  @override
  Future<List<UserModel>> getUserList() async {
    final response = await client.get(Uri.parse('https://$mockapiKey.mockapi.io/api/users'));
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((e) => UserModel.fromJson(e)).toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<UserModel> getUserDetail(String id) async {
    final response = await client.get(Uri.parse('https://$mockapiKey.mockapi.io/api/users/$id'));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      return UserModel.fromJson(data);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<UserModel> addUser(String name, String email, String address) async {
    final response = await client.post(
      Uri.parse('https://$mockapiKey.mockapi.io/api/users'),
      body: jsonEncode({
        'name': name,
        'email': email,
        'address': address,
      }),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    log('ADD User Response: ${response.body}');
    if (response.statusCode == 201) {
      Map<String, dynamic> data = jsonDecode(response.body);
      return UserModel.fromJson(data);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<UserModel> editUser(String id, String name, String email, String address) async {
    final response = await client.put(
      Uri.parse('https://$mockapiKey.mockapi.io/api/users/$id'),
      body: jsonEncode({
        'name': name,
        'email': email,
        'address': address,
      }),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    log('EDIT User Response: ${response.body}');
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      return UserModel.fromJson(data);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<UserModel> deleteUser(String id) async {
    final response = await client.delete(
      Uri.parse('https://$mockapiKey.mockapi.io/api/users/$id'),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    log('DELETE User Response: ${response.body}');
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      return UserModel.fromJson(data);
    } else {
      throw ServerException();
    }
  }
}
