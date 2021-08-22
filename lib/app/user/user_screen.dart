import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/app/user/components/user_info_component.dart';
import 'package:instagram_clone/app/user/cubits/user_cubit.dart';
import 'package:instagram_clone/infra/config/instagram_api_config.dart';
import 'package:instagram_clone/infra/repositories/user_repository.dart';

final username = 'spacex';

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  late final UserCubit _userCubit;

  @override
  void initState() {
    final userRepository = UserRepository(instagramApi: instagramApi);

    _userCubit = UserCubit(
      username: username,
      userRepository: userRepository,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              username,
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            SizedBox(width: 6),
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Icon(Icons.verified, color: Colors.blue, size: 14),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () {},
          ),
          SizedBox(width: 10),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {},
          ),
          SizedBox(width: 10),
        ],
      ),
      body: DefaultTabController(
        length: 2,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: BlocBuilder<UserCubit, UserState>(
                bloc: _userCubit,
                builder: (context, state) {
                  if (state is UserStateEmpty) return Container();

                  if (state is UserStateLoading) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(64),
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.black,
                        ),
                      ),
                    );
                  }

                  if (state is UserStateError) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(64),
                        child: Column(
                          children: [
                            Icon(
                              Icons.error_outline,
                              color: Colors.grey[600],
                            ),
                            SizedBox(height: 4),
                            Text(
                              'It was not possible to load user',
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  final user = (state as UserStateSuccess).user;

                  return UserInfo(user: user);
                },
              ),
            ),
            SliverAppBar(
              backgroundColor: Colors.white,
              pinned: true,
              titleSpacing: 0,
              title: TabBar(
                indicatorColor: Colors.black,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                tabs: [
                  Tab(icon: Icon(Icons.grid_on)),
                  Tab(icon: Icon(Icons.person_pin_outlined)),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: BlocBuilder<UserCubit, UserState>(
                  bloc: _userCubit,
                  builder: (context, state) {
                    if (state is UserStateEmpty) return Container();

                    if (state is UserStateLoading) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(64),
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.black,
                          ),
                        ),
                      );
                    }

                    if (state is UserStateError) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(64),
                          child: Column(
                            children: [
                              Icon(
                                Icons.error_outline,
                                color: Colors.grey[600],
                              ),
                              SizedBox(height: 4),
                              Text(
                                'It was not possible to load user\'s posts',
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    final posts = (state as UserStateSuccess).user.posts;

                    final height = (posts.length / 3).ceil() *
                        ((MediaQuery.of(context).size.width - 8) / 3 + 4);

                    return SizedBox(
                      height: height,
                      child: TabBarView(
                        children: [
                          GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 4,
                              crossAxisSpacing: 4,
                              childAspectRatio: 1
                            ),
                            itemCount: posts.length,
                            itemBuilder: (context, index) => Image.network(
                              posts[index].thumbnailUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                          GridView.count(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            crossAxisCount: 3,
                            mainAxisSpacing: 4,
                            crossAxisSpacing: 4,
                            children: List.generate(
                              10,
                              (index) => AspectRatio(
                                aspectRatio: 1,
                                child: Image.network(
                                  'https://picsum.photos/400/300',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
