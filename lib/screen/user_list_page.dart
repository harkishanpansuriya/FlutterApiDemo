import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_api_demo/api_helper/api_helper.dart';
import 'package:flutter_api_demo/models/user_model.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter_api_demo/screen/user_detail.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({Key? key}) : super(key: key);

  @override
  _UserListPageState createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  List<UserModel> usersList = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Users List'),
          automaticallyImplyLeading: false,
        ),
        body: FutureBuilder<List<UserModel>>(
          future: ApiHelper().getAllUserList(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemBuilder: (context, index) =>
                    buildUserDetail(snapshot.data![index]),
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

  buildUserDetail(UserModel userModel) {
    return SingleChildScrollView(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => UserDetailPage(userModel)));
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: ExpansionTileCard(
            baseColor: Colors.cyan[50],
            expandedColor: Colors.red[50],
            leading: CircleAvatar(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                child: Text(userModel.id.toString() ?? "")),
            title: Text(userModel.name ?? ""),
            subtitle: Text.rich(
              TextSpan(
                text: 'E-Mail :- ', // default text style
                children: [
                  TextSpan(
                      text: userModel.email ?? "",
                      style: const TextStyle(
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w600)),
                ],
              ),
            ),
            children: [
              const Divider(
                thickness: 1.0,
                height: 1.0,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text.rich(
                        TextSpan(
                          text: 'E-Mail :- ', // default text style
                          children: [
                            TextSpan(
                                text: userModel.email ?? "",
                                style: const TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text.rich(
                        TextSpan(
                          text: 'Username :- ', // default text style
                          children: [
                            TextSpan(
                                text: userModel.username ?? "",
                                style: const TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text.rich(
                        TextSpan(
                          text: 'Phone No. :- ', // default text style
                          children: [
                            TextSpan(
                                text: userModel.phone ?? "",
                                style: const TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text.rich(
                        TextSpan(
                          text: 'Website :- ', // default text style
                          children: [
                            TextSpan(
                                text: userModel.website ?? "",
                                style: const TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text.rich(
                                TextSpan(
                                  text: 'Address :- ',
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text.rich(
                                TextSpan(
                                  text: 'Street :- ', // default text style
                                  children: [
                                    TextSpan(
                                        text: userModel.address?.street ?? "",
                                        style: const TextStyle(
                                            fontStyle: FontStyle.italic,
                                            fontWeight: FontWeight.w600)),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text.rich(
                                TextSpan(
                                  text: 'Suite :- ', // default text style
                                  children: [
                                    TextSpan(
                                        text: userModel.address?.suite ?? "",
                                        style: const TextStyle(
                                            fontStyle: FontStyle.italic,
                                            fontWeight: FontWeight.w600)),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text.rich(
                                TextSpan(
                                  text: 'City :- ', // default text style
                                  children: [
                                    TextSpan(
                                        text: userModel.address?.city ?? "",
                                        style: const TextStyle(
                                            fontStyle: FontStyle.italic,
                                            fontWeight: FontWeight.w600)),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text.rich(
                                TextSpan(
                                  text: 'Zip Code :- ', // default text style
                                  children: [
                                    TextSpan(
                                        text: userModel.address?.zipcode ?? "",
                                        style: const TextStyle(
                                            fontStyle: FontStyle.italic,
                                            fontWeight: FontWeight.w600)),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text.rich(
                                TextSpan(
                                  text: 'Company :- ', // default text style
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 5,
                                ),
                                Text.rich(
                                  TextSpan(
                                    text: 'Name :- ', // default text style
                                    children: [
                                      TextSpan(
                                          text: userModel.company?.name ?? "",
                                          style: const TextStyle(
                                              fontStyle: FontStyle.italic,
                                              fontWeight: FontWeight.w600)),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text.rich(
                                  TextSpan(
                                    text:
                                        'catchPhrase :- ', // default text style
                                    children: [
                                      TextSpan(
                                          text:
                                              userModel.company?.catchPhrase ??
                                                  "",
                                          style: const TextStyle(
                                              fontStyle: FontStyle.italic,
                                              fontWeight: FontWeight.w600)),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text.rich(
                                  TextSpan(
                                    text: 'bs :- ', // default text style
                                    children: [
                                      TextSpan(
                                          text: userModel.company?.bs ?? "",
                                          style: const TextStyle(
                                              fontStyle: FontStyle.italic,
                                              fontWeight: FontWeight.w600)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
