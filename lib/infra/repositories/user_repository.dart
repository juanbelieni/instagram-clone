import 'package:dio/dio.dart';
import 'package:instagram_clone/domain/media/media.dart';
import 'package:instagram_clone/domain/user/user.dart';

class UserRepository implements IUserRepository {
  final Dio instagramApi;

  UserRepository({required this.instagramApi});

  @override
  Future<User> getOneByUsername(String username) async {
    final response = await instagramApi.get('/$username?__a=1');
    final user = response.data['graphql']['user'] as Map<String, dynamic>;

    return User(
      username: user['username'],
      name: user['full_name'],
      avatarUrl: user['profile_pic_url_hd'],
      biography: user['biography'],
      category: user['category_name'],
      postsCount: user['edge_owner_to_timeline_media']['count'],
      followersCount: user['edge_followed_by']['count'],
      followingCount: user['edge_follow']['count'],
      posts: (user['edge_owner_to_timeline_media']['edges'] as List).map(
        (edge) => Media(
          id: edge['node']['id'],
          thumbnailUrl: edge['node']['display_url'],
        ),
      ).toList(),
    );
  }
}
