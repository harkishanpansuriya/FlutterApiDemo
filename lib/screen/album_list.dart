import 'package:flutter/material.dart';
import 'package:flutter_api_demo/api_helper/api_helper.dart';
import 'package:flutter_api_demo/models/album_model.dart';
import 'package:flutter_api_demo/models/user_model.dart';
import 'package:flutter_api_demo/screen/photo_list_page.dart';

class AlbumListPage extends StatefulWidget {
  UserModel? userModel;

  AlbumListPage(this.userModel, {Key? key}) : super(key: key);

  @override
  _AlbumListPageState createState() => _AlbumListPageState();
}

class _AlbumListPageState extends State<AlbumListPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<List<AlbumModel>>(
          future:
              ApiHelper().getAlbumList(widget.userModel?.id.toString() ?? ""),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemBuilder: (context, index) =>
                    buildAlbumDetail(snapshot.data![index]),
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

  buildAlbumDetail(AlbumModel albumModel) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => PhotoListPage(albumModel)));
        },
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  child: Text(albumModel.userId.toString() ?? "")),
              // title: Text("Title :- ${postsModel.title ?? ""}"),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(
                            text: "Album Id :- ",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                                fontWeight: FontWeight.w500)),
                        TextSpan(
                            text: albumModel.id.toString() ?? "",
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
                            text: albumModel.title ?? "",
                            style: const TextStyle(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.normal)),
                      ],
                    ),
                  ),
                ],
              ),
              trailing: IconButton(
                onPressed: () {
                  setState(() {
                    ApiHelper().deleteAlbums(albumModel.id.toString() ?? "");
                  });
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
