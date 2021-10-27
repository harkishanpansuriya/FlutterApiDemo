import 'package:flutter/material.dart';
import 'package:flutter_api_demo/models/user_model.dart';
import 'package:flutter_api_demo/screen/album_list.dart';
import 'package:flutter_api_demo/screen/posts_list.dart';
import 'package:flutter_api_demo/screen/todos_list.dart';

class UserDetailPage extends StatefulWidget {
  UserModel? userModel;

  UserDetailPage(this.userModel, {Key? key}) : super(key: key);

  @override
  _UserDetailPageState createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(child: Text("Posts")),
                Tab(child: Text("Album")),
                Tab(child: Text("Todos")),
              ],
            ),
            title: const Text('User Detail Page'),
          ),
          body: TabBarView(
            children: [
              PostListPage(widget.userModel),
              AlbumListPage(widget.userModel),
              TodosListPage(widget.userModel),
            ],
          ),
        ),
      ),
    );
  }
}
