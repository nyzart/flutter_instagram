import 'package:flutter/material.dart';
import 'package:flutter_instagram/Requests/picture_interactions.dart';
import '../Classes/picture.dart';

class SinglePicture extends StatelessWidget {
  final picture;

  const SinglePicture(this.picture);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.width;
    Comment comment = new Comment();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Center(
            child: Container(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(width / 30, 0, 0, height / 60),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(90.0),
                          child: Image.network(
                            'https://cdn.shopify.com/s/files/1/0045/5104/9304/t/27/assets/AC_ECOM_SITE_2020_REFRESH_1_INDEX_M2_THUMBS-V2-1.jpg?v=8913815134086573859',
                            height: height / 10,
                            width: width / 10,
                          ),
                        ),
                        Container(
                          padding:
                              EdgeInsets.fromLTRB(width / 40, width / 60, 0, 0),
                          child: Text(
                            picture['username'] != null
                                ? picture['username']
                                : 'henry tran',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Image.network(picture['pictureLink']),
                  Row(
                    children: [
                      IconButton(
                          icon: Icon(
                            Icons.favorite_border,
                            color: Colors.white,
                            size: 30,
                          ),
                          onPressed: () {
                            PictureInteractions().addFavorite(picture['id']);
                          }),
                      IconButton(
                          icon: Icon(
                            Icons.mode_comment,
                            color: Colors.white,
                            size: 30,
                          ),
                          onPressed: () {}),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(left: width / 35),
                    child: Row(
                      children: [
                        Text(
                          picture['likes'].toString(),
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          ' Likes',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                              left: width / 35, top: height / 60),
                          child: Row(
                            children: [
                              Text(
                                comment.name,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: width / 60,
                              ),
                              Text(
                                comment.comment,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              left: width / 35, top: height / 120),
                          child: Row(
                            children: [
                              Text(
                                'jaime pah',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: width / 60,
                              ),
                              Text(
                                'ouah tro bg le boug',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
