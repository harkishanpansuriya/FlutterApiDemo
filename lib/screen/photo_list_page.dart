import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_api_demo/api_helper/api_helper.dart';
import 'package:flutter_api_demo/models/album_model.dart';
import 'package:flutter_api_demo/models/photo_model.dart';
import 'package:transparent_image/transparent_image.dart';

class PhotoListPage extends StatefulWidget {
  AlbumModel? albumModel;

  PhotoListPage(this.albumModel, {Key? key}) : super(key: key);

  @override
  _PhotoListPageState createState() => _PhotoListPageState();
}

class _PhotoListPageState extends State<PhotoListPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Photo List"),
          automaticallyImplyLeading: true,
        ),
        body: FutureBuilder<List<PhotoModel>>(
          future: ApiHelper()
              .getAlbumPhotos(widget.albumModel?.id.toString() ?? ""),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // return ListView.builder(
              //   itemBuilder: (context, index) =>
              //       buildPhotoList(snapshot.data![index]),
              //   itemCount: snapshot.data!.length,
              // );
              return ListView.separated(
                  itemBuilder: (context, index) =>
                      buildPhotoList(snapshot.data![index]),
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

  buildPhotoList(PhotoModel photoModel) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  bottomLeft: Radius.circular(15)),
                              child: FadeInImage.memoryNetwork(
                                height: 100,
                                width: 100,
                                placeholder: kTransparentImage,
                                image: photoModel.url.toString(),
                              ),
                            ),
                            const SizedBox(
                              width: 2,
                            ),
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  bottomRight: Radius.circular(15),
                                  topRight: Radius.circular(15)),
                              child: FadeInImage.memoryNetwork(
                                height: 100,
                                width: 100,
                                placeholder: kTransparentImage,
                                image: photoModel.thumbnailUrl.toString(),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.007,
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Album Id :- ${photoModel.albumId ?? ""}"),
                          Text("Photo Id :- ${photoModel.id ?? ""}"),
                          Text("Title :- ${photoModel.title ?? ""}"),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Row(
          //   children: [
          //     Expanded(
          //       child: Text("Album Id :- ${photoModel.albumId ?? ""}"),
          //     ),
          //   ],
          // ),
          // SizedBox(
          //   height: 8,
          // ),
          // Row(
          //   children: [
          //     Expanded(
          //       child: Text("Photo Id :- ${photoModel.id ?? ""}"),
          //     ),
          //   ],
          // ),
          // SizedBox(
          //   height: 8,
          // ),
          // Row(
          //   children: [
          //     Expanded(
          //       child: Text("Title :- ${photoModel.title ?? ""}"),
          //     ),
          //   ],
          // ),
          // SizedBox(
          //   height: 8,
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     FadeInImage.memoryNetwork(
          //       height: 100,
          //       width: 100,
          //       placeholder: kTransparentImage,
          //       image: photoModel.url.toString(),
          //     ),
          //     FadeInImage.memoryNetwork(
          //       height: 100,
          //       width: 100,
          //       placeholder: kTransparentImage,
          //       image: photoModel.thumbnailUrl.toString(),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
