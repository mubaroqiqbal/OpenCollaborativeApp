import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:github/github.dart';
import 'package:http/http.dart' as ioClient;
import 'package:credibook_test_app/data/model/open_collective_user.dart';

class DataRepository {

  static DataRepository _dataRepository;

  var github = GitHub();

  DataRepository();

  static DataRepository getRepository() {
    if (_dataRepository != null) {
      return _dataRepository;
    } else {
      _dataRepository = DataRepository();
      return _dataRepository;
    }
  }

  Future<List<User>> getUser(int page) async {
    try {
      final response = github.users.listUsers(pages: page);

      return response.toList();
    } on RateLimitHit {
      return null;
    } on GitHubError{
      return null;
    }
  }

  Future<void> getUserHttp() async {
    String url = "https://api.github.com/users";
    debugPrint(url);

    final response = await ioClient.get(url);

    debugPrint(response.statusCode.toString());
    debugPrint(response.body);

    if (response.statusCode == 400) {
      throw Exception(response.body);
    } else if (response.statusCode == 200 || response.statusCode == 201) {
      Iterable list = json.decode(response.body);

      debugPrint(list.map((model) => User.fromJson(model)).toList().length.toString());
    } else {
      throw Exception("Other Error");
    }
  }

  Future<List<OpenCollectiveUser>> getListOpenCollectiveUser() async {
    String url = "https://opencollective.com/webpack/members/users.json";
    debugPrint(url);

    final response = await ioClient.get(url);

    debugPrint(response.statusCode.toString());
    debugPrint(response.body);

    if (response.statusCode == 400) {
      throw Exception(response.body);
    } else if (response.statusCode == 200 || response.statusCode == 201) {
      Iterable list = json.decode(response.body);

      debugPrint(list.map((model) => OpenCollectiveUser.fromJson(model)).toList().length.toString());
      return list.map((model) => OpenCollectiveUser.fromJson(model)).toList();
    } else {
      throw Exception("Other Error");
    }
  }
}
