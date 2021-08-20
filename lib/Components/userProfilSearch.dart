import 'package:flutter/material.dart';
import 'package:flutter_instagram/Views/userProfile.dart';

class UserProfilSearch extends StatelessWidget {
  final post;
  UserProfilSearch({this.post});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(
              "https://i.pinimg.com/originals/51/f6/fb/51f6fb256629fc755b8870c801092942.png"), // no matter how big it is, it won't overflow
        ),
        title: Text(this.post.title, style: TextStyle(color: Colors.white)),
        isThreeLine: true,
        subtitle: Text(this.post.body, style: TextStyle(color: Colors.grey)),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => UserProfile(
                user: this.post.user,
              ),
            ),
          );
        },
      ),
    );
  }
}
