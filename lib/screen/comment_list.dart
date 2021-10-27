import 'package:flutter/material.dart';
import 'package:flutter_api_demo/api_helper/api_helper.dart';
import 'package:flutter_api_demo/models/comments_model.dart';
import 'package:flutter_api_demo/models/posts_model.dart';

class CommentsListPage extends StatefulWidget {
  PostsModel? postsModel;

  CommentsListPage(this.postsModel, {Key? key}) : super(key: key);
  @override
  _CommentsListPageState createState() => _CommentsListPageState();
}

class _CommentsListPageState extends State<CommentsListPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Cooment List'),
          automaticallyImplyLeading: true,
        ),
        body: FutureBuilder<List<CommentsModel>>(
          future: ApiHelper()
              .getPostCommets(widget.postsModel?.id.toString() ?? ""),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // return ListView.builder(
              //   itemBuilder: (context, index) =>
              //       buildCommetsList(snapshot.data![index]),
              //   itemCount: snapshot.data!.length,
              // );
              return ListView.separated(
                  itemBuilder: (context, index) =>
                      buildCommetsList(snapshot.data![index]),
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
      ),
    );
  }

  buildCommetsList(CommentsModel commentsModel) {
    return Column(
      children: [
        ListTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(
                        text: "Name :- ",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                            fontWeight: FontWeight.w500)),
                    TextSpan(
                        text: commentsModel.name ?? "",
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
                        text: "Email :- ",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                            fontWeight: FontWeight.w500)),
                    TextSpan(
                        text: commentsModel.email ?? "",
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
                        text: "Body :- ",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                            fontWeight: FontWeight.w500)),
                    TextSpan(
                        text: commentsModel.body ?? "",
                        style: const TextStyle(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.normal)),
                  ],
                ),
              ),
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Comments id ${commentsModel.id.toString() ?? ""}"),
              Text("Post id ${commentsModel.postId.toString() ?? ""}"),
            ],
          ),
        ),
      ],
    );
  }
}
