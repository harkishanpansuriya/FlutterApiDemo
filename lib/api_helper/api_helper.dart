import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_api_demo/models/album_model.dart';
import 'package:flutter_api_demo/models/comments_model.dart';
import 'package:flutter_api_demo/models/photo_model.dart';
import 'package:flutter_api_demo/models/posts_model.dart';
import 'package:flutter_api_demo/models/todos_model.dart';
import 'package:flutter_api_demo/models/user_model.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class ApiHelper {
  final String baseUrl = "https://jsonplaceholder.typicode.com";

  Future<List<UserModel>> getAllUserList() async {
    String finalUrl = baseUrl + "/users";

    Uri url = Uri.parse(finalUrl);

    Response response = await http.get(url);
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<UserModel> userModel = [];
      data.forEach((element) {
        userModel.add(UserModel.fromJson(element));
      });

      return userModel;
    }
    return Future.error('STATUS CODE :- ${response.statusCode}');
  }

  Future<List<PostsModel>> getPostList(String id) async {
    String finalUrl = baseUrl + "/posts?userId=$id";

    Uri url = Uri.parse(finalUrl);

    Response response = await http.get(url);
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<PostsModel> postsModel = [];
      data.forEach((element) {
        postsModel.add(PostsModel.fromJson(element));
      });

      return postsModel;
    }
    return Future.error('STATUS CODE :- ${response.statusCode}');
  }

  Future<List<AlbumModel>> getAlbumList(String id) async {
    String finalUrl = baseUrl + "/albums?userId=$id";

    Uri url = Uri.parse(finalUrl);

    Response response = await http.get(url);
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<AlbumModel> albumModel = [];
      data.forEach((element) {
        albumModel.add(AlbumModel.fromJson(element));
      });

      return albumModel;
    }
    return Future.error('STATUS CODE :- ${response.statusCode}');
  }

  Future<List<TodosModel>> getTodosList(String id) async {
    String finalUrl = baseUrl + "/todos?userId=$id";

    Uri url = Uri.parse(finalUrl);

    Response response = await http.get(url);
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<TodosModel> todosModel = [];
      data.forEach((element) {
        todosModel.add(TodosModel.fromJson(element));
      });

      return todosModel;
    }
    return Future.error('STATUS CODE :- ${response.statusCode}');
  }

  Future<List<CommentsModel>> getPostCommets(String id) async {
    String finalUrl = baseUrl + "/comments?postId=$id";

    Uri url = Uri.parse(finalUrl);

    Response response = await http.get(url);
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<CommentsModel> commentsModel = [];
      data.forEach((element) {
        commentsModel.add(CommentsModel.fromJson(element));
      });

      return commentsModel;
    }
    return Future.error('STATUS CODE :- ${response.statusCode}');
  }

  Future<List<PhotoModel>> getAlbumPhotos(String id) async {
    String finalUrl = baseUrl + "/photos?albumId=$id";

    Uri url = Uri.parse(finalUrl);

    Response response = await http.get(url);
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<PhotoModel> photoModel = [];
      data.forEach((element) {
        photoModel.add(PhotoModel.fromJson(element));
      });

      return photoModel;
    }
    return Future.error('STATUS CODE :- ${response.statusCode}');
  }

  Future<PostsModel> addPostData(Map<String, dynamic> data) async {
    String finalUrl = baseUrl + "/posts";
    Uri url = Uri.parse(finalUrl);
    Response response = await http.post(url, body: jsonEncode(data), headers: {
      'Content-type': 'application/json; charset=UTF-8',
    });
    if (response.statusCode == 201) {
      Map data = jsonDecode(response.body);

      debugPrint("DATA:-- $data");
      PostsModel postsModel = PostsModel.fromJson(data);

      return postsModel;
    }
    return Future.error("STATUS CODE:- ${response.statusCode}");
  }

  Future<AlbumModel> deleteAlbums(String id) async {
    String finalUrl = baseUrl + "/albums/$id";
    Uri url = Uri.parse(finalUrl);
    Response response = await http.delete(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      debugPrint("ALBUM DELETE DATA:-- ${response.statusCode}");
      AlbumModel albumMoedl = AlbumModel.fromJson(jsonDecode(response.body));

      return albumMoedl;
    }
    return Future.error("STATUS CODE:- ${response.statusCode}");
  }

  Future<PostsModel> deletePosts(String id) async {
    String finalUrl = baseUrl + "/posts/$id";
    Uri url = Uri.parse(finalUrl);
    Response response = await http.delete(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      debugPrint("POSTS DELETE DATA:-- ${response.statusCode}");
      PostsModel postsModel = PostsModel.fromJson(jsonDecode(response.body));

      return postsModel;
    }
    return Future.error("STATUS CODE:- ${response.statusCode}");
  }
}
