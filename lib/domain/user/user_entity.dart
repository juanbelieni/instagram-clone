import 'package:instagram_clone/domain/media/media.dart';

class User {
  final String username;
  final String name;
  final String avatarUrl;
  final String? biography;
  final String? category;

  final int postsCount;
  final int followersCount;
  final int followingCount;

  final List<Media> posts;

  User({
    required this.username,
    required this.name,
    required this.avatarUrl,
    this.biography,
    this.category,
    required this.postsCount,
    required this.followersCount,
    required this.followingCount,
    required this.posts,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      username: map['username'],
      name: map['name'],
      avatarUrl: map['avatar_url'],
      biography: map['biography'],
      category: map['category'],
      postsCount: map['posts_count'],
      followersCount: map['followers_count'],
      followingCount: map['following_count'],
      posts: map['posts'].map((mediaMap) => Media.fromMap(mediaMap)).toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'name': name,
      'avatar_url': avatarUrl,
      'biography': biography,
      'category': category,
      'posts_count': postsCount,
      'followers_count': followersCount,
      'following_count': followingCount,
      'posts': posts.map((media) => media.toMap()).toList(),
    };
  }
}
