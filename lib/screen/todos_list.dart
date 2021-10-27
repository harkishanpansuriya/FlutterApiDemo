import 'package:flutter/material.dart';
import 'package:flutter_api_demo/api_helper/api_helper.dart';
import 'package:flutter_api_demo/models/todos_model.dart';
import 'package:flutter_api_demo/models/user_model.dart';

class TodosListPage extends StatefulWidget {
  UserModel? userModel;

  TodosListPage(this.userModel, {Key? key}) : super(key: key);

  @override
  _TodosListPageState createState() => _TodosListPageState();
}

class _TodosListPageState extends State<TodosListPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<List<TodosModel>>(
          future:
              ApiHelper().getTodosList(widget.userModel?.id.toString() ?? ""),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemBuilder: (context, index) =>
                    buildTodosDetail(snapshot.data![index]),
                itemCount: snapshot.data!.length,
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  buildTodosDetail(TodosModel todosModel) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                child: Text(todosModel.userId.toString() ?? "")),
            // title: Text("Title :- ${postsModel.title ?? ""}"),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(
                          text: "Todo Id :- ",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                              fontWeight: FontWeight.w500)),
                      TextSpan(
                          text: todosModel.id.toString() ?? "",
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
                          text: todosModel.title ?? "",
                          style: const TextStyle(
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.normal)),
                    ],
                  ),
                ),
              ],
            ),
            subtitle: Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                      text: "Completed :- ",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500)),
                  TextSpan(
                      text: todosModel.completed.toString() ?? "",
                      style: const TextStyle(
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.normal)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
