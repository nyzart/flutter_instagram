class Comment {
  String _name = 'henrytran';
  String _comment = "Salut les mecs comment ca va ?";
  String _userID = "truc";

  String get name => _name;
  String get comment => _comment;
  String get userID => _userID;

  set name(String name) {
    _name = name;
  }

  set comment(String comment) {
    _comment = comment;
  }

  set userID(String userID) {
    _userID = userID;
  }
}

class Picture {
  List<Comment> _comments = [];
  int _likes = 0;
  String _picture =
      "https://cdn.shopify.com/s/files/1/0045/5104/9304/t/27/assets/AC_ECOM_SITE_2020_REFRESH_1_INDEX_M2_THUMBS-V2-1.jpg?v=8913815134086573859";
  String _userID = "blablabla";

  List<Comment> get comments => _comments;
  int get likes => _likes;
  String get picture => _picture;
  String get userID => _userID;

  set comments(List<Comment> comments) {
    _comments = comments;
  }

  set likes(int likes) {
    _likes = likes;
  }

  set picture(String picture) {
    _picture = picture;
  }

  set userID(String userID) {
    _userID = userID;
  }

  void addComment(Comment comment) {
    _comments.add(comment);
  }
}
