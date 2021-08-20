import 'package:flutter/material.dart';
import 'package:flutter_instagram/Requests/picture_interactions.dart';
import 'package:flutter_instagram/Requests/user_interactions.dart';
import 'package:flutter_instagram/Views/single_picture.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_instagram/Components/header.dart';

class Favorites extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.width;

    onPictureTap(final picture) async {
      await Navigator.push(context,
          new MaterialPageRoute(builder: (context) => SinglePicture(picture)));
    }

    return Scaffold(
      body: Column(children: [
        Header("Favorites"),
        Expanded(
          child: Container(
            child: FutureBuilder(
              future: userInteract().getFavoritePictures(),
              builder: (context,
                  AsyncSnapshot<List<Map<String, dynamic>?>> snapshot) {
                if (snapshot.hasData) {
                  return GridView.count(
                    physics: BouncingScrollPhysics(),
                    crossAxisCount: 3,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 1,
                    children: List.generate(
                      snapshot.data!.length,
                      (index) {
                        return GestureDetector(
                          onTap: () => onPictureTap(snapshot.data![index]!),
                          child: Container(
                            child: FadeInImage.memoryNetwork(
                                fit: BoxFit.fitWidth,
                                placeholder: kTransparentImage,
                                image: snapshot.data![index]!['pictureLink']),
                          ),
                        );
                      },
                    ),
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
      ]),
    );
  }
}
