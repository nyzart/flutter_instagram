import 'package:flutter/material.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter_instagram/Components/userProfilSearch.dart';
import 'package:flutter_instagram/Requests/user_interactions.dart';

class Post {
  final String title;
  final String body;
  final user;

  Post(this.title, this.body, this.user);
}

class UserSearchBar extends StatelessWidget {
  @override
  final SearchBarController<Post> _searchBarController = SearchBarController();

  Future<List<Post>> _getALlPosts(String text) async {
    List<Map<String, dynamic>?> users =
        await userInteract().getUserBySearch(text);
    List<Post> posts = [];

    for (final user in users) {
      posts.add(Post(user?['username'], user?['biography'], user));
    }
    return posts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SearchBar<Post>(
          textStyle: TextStyle(color: Colors.white),
          icon: Icon(
            Icons.search,
            color: Colors.white,
          ),
          searchBarPadding: EdgeInsets.symmetric(horizontal: 10),
          headerPadding: EdgeInsets.symmetric(horizontal: 10),
          listPadding: EdgeInsets.symmetric(horizontal: 10),
          onSearch: _getALlPosts,
          searchBarController: _searchBarController,
          cancellationWidget:
              Text("Cancel", style: TextStyle(color: Colors.white)),
          emptyWidget: Text("empty", style: TextStyle(color: Colors.white)),
          header: Row(
            children: <Widget>[],
          ),
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          crossAxisCount: 1,
          minimumChars: 2,
          onItemFound: (Post post, int index) {
            return UserProfilSearch(post: post);
          },
        ),
      ),
    );
  }
}
