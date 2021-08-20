import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram/Requests/authentication_services.dart';
import 'package:flutter_instagram/Requests/user_interactions.dart';

import 'package:flutter_instagram/Views/single_picture.dart';
import 'package:flutter_instagram/Requests/picture_interactions.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.width;
    final userID = FirebaseAuth.instance.currentUser!.uid;

    onPictureTap(final picture) async {
      await Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (context) => SinglePicture(picture),
        ),
      );
    }

    return Scaffold(
      body: FutureBuilder<Map<String, dynamic>?>(
        future: userInteract().getUserConnected(),
        builder: (context, AsyncSnapshot<Map<String, dynamic>?> snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                AppBar(
                  backgroundColor: Colors.black,
                  actions: [
                    IconButton(
                        icon: Icon(Icons.logout),
                        onPressed: () {
                          context.read<AuthenticationService>().logOut();
                        })
                  ],
                ),
                SizedBox(
                  height: height / 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(90.0),
                          child: Image.network(
                            'https://cdn.shopify.com/s/files/1/0045/5104/9304/t/27/assets/AC_ECOM_SITE_2020_REFRESH_1_INDEX_M2_THUMBS-V2-1.jpg?v=8913815134086573859',
                            height: height / 5,
                            width: width / 5,
                          ),
                        ),
                        SizedBox(
                          height: height / 30,
                        ),
                        Text(
                          snapshot.data!['name'],
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          snapshot.data!['publicationsNumber'].toString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                        Text(
                          'Publications',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          snapshot.data!['likedPicturesNumber'].toString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                        Text(
                          'You liked',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          snapshot.data!['likedPostedPicturesNumber'].toString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                        Text(
                          'Users liked',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: height / 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Container(
                        padding: EdgeInsets.fromLTRB(width / 32, 0, 0, 0),
                        height: height / 5,
                        child: Text(
                          snapshot.data!['biography'],
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                    child: FutureBuilder<List<Map<String, dynamic>?>>(
                      future: PictureInteractions().getUserPictures(userID),
                      builder: (context,
                          AsyncSnapshot<List<Map<String, dynamic>?>> snapshot) {
                        if (snapshot.hasData) {
                          return GridView.count(
                            physics: BouncingScrollPhysics(),
                            crossAxisCount: 3,
                            crossAxisSpacing: 1,
                            mainAxisSpacing: 1,
                            children:
                                List.generate(snapshot.data!.length, (index) {
                              return GestureDetector(
                                onTap: () =>
                                    onPictureTap(snapshot.data![index]!),
                                child: Container(
                                  child: FadeInImage.memoryNetwork(
                                      fit: BoxFit.fitWidth,
                                      placeholder: kTransparentImage,
                                      image: snapshot
                                          .data![index]!['pictureLink']),
                                ),
                              );
                            }),
                          );
                        } else {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Center(
                                child: Text(
                                  'No pictures yet...',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
