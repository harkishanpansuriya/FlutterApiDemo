import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_api_demo/api_helper/api_helper.dart';
import 'package:flutter_api_demo/models/posts_model.dart';
import 'package:flutter_api_demo/models/user_model.dart';
import 'package:flutter_api_demo/screen/comment_list.dart';

class PostListPage extends StatefulWidget {
  UserModel? userModel;

  PostListPage(this.userModel, {Key? key}) : super(key: key);

  @override
  _PostListPageState createState() => _PostListPageState();
}

class _PostListPageState extends State<PostListPage> {
  List<PostsModel> postList = [];

  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<List<PostsModel>>(
          future:
              ApiHelper().getPostList(widget.userModel?.id.toString() ?? ""),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // return ListView.builder(
              //   itemBuilder: (context, index) =>
              //       buildPostDetail(snapshot.data![index]),
              //   itemCount: snapshot.data!.length,
              // )
              return ListView.separated(
                  itemBuilder: (context, index) =>
                      buildPostDetail(snapshot.data![index]),
                  separatorBuilder: (context, index) {
                    return const Divider(
                      color: Colors.grey,
                      thickness: 1,
                    );
                  },
                  itemCount: snapshot.data!.length);
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Post Data Dialog"),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          controller: titleController,
                          decoration: const InputDecoration(
                            labelText: 'Title',
                          ),
                        ),
                        TextFormField(
                          controller: bodyController,
                          decoration: const InputDecoration(
                            labelText: 'Body',
                          ),
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              Map<String, dynamic> postData = {};
                              postData["title"] = titleController.text;
                              postData["body"] = bodyController.text;
                              postData["userId"] = widget.userModel?.id ?? "";
                              PostsModel postModel =
                                  await ApiHelper().addPostData(postData);
                              debugPrint("Post:- ${postModel.toJson()}");
                              Navigator.pop(context, postModel);
                              setState(() {});
                            },
                            child: Text("Add post data")),
                      ],
                    ),
                  );
                });
          },
          child: Icon(Icons.add),
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () async {
        //     _showDialog(context);
        //   },
        //   child: Icon(Icons.add),
        // ),
      ),
    );
  }

  buildPostDetail(PostsModel postsModel) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                child: Text(postsModel.userId.toString() ?? "")),
            // title: Text("Title :- ${postsModel.title ?? ""}"),
            title: GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CommentsListPage(postsModel)));
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(
                            text: "Post Id :- ",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                                fontWeight: FontWeight.w500)),
                        TextSpan(
                            text: postsModel.id.toString() ?? "",
                            style: const TextStyle(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.normal)),
                      ],
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(
                            text: "Title :- ",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                                fontWeight: FontWeight.w500)),
                        TextSpan(
                            text: postsModel.title ?? "",
                            style: const TextStyle(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.normal)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            subtitle: GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CommentsListPage(postsModel)));
              },
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(
                            text: "Body :- ",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                              fontWeight: FontWeight.w500,
                            )),
                        TextSpan(
                            text: postsModel.body ?? "",
                            style: const TextStyle(
                              color: Colors.black87,
                              fontStyle: FontStyle.italic,
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            trailing: IconButton(
              onPressed: () {
                ApiHelper().deletePosts(postsModel.id.toString() ?? "");
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
