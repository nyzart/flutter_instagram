import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_instagram/Views/single_picture.dart';
import 'package:flutter_instagram/Classes/user.dart';
import 'package:flutter_instagram/Requests/picture_interactions.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfile extends StatelessWidget {
  final user;

  UserProfile({this.user});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.width;

    onPictureTap(final picture) async {
      await Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (context) => SinglePicture(picture),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
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
                    user['name'],
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
                    user['publicationsNumber'].toString(),
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
                    user['likedPicturesNumber'].toString(),
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
                    user['likedPostedPicturesNumber'].toString(),
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
                    user['biography'],
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
                future: PictureInteractions().getUserPictures(user['id']),
                builder: (context,
                    AsyncSnapshot<List<Map<String, dynamic>?>> snapshot) {
                  if (snapshot.hasData) {
                    return GridView.count(
                      physics: BouncingScrollPhysics(),
                      crossAxisCount: 3,
                      crossAxisSpacing: 1,
                      mainAxisSpacing: 1,
                      children: List.generate(snapshot.data!.length, (index) {
                        return GestureDetector(
                          onTap: () => onPictureTap(snapshot.data![index]!),
                          child: Container(
                            child: FadeInImage.memoryNetwork(
                                fit: BoxFit.fitWidth,
                                placeholder: kTransparentImage,
                                image: snapshot.data![index]!['pictureLink']),
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
      ),
    );
  }
}
