import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/domain/user/user.dart';

abstract class UserState {}

class UserStateEmpty extends UserState {}

class UserStateLoading extends UserState {}

class UserStateError extends UserState {
  final Object error;

  UserStateError({required this.error}) {
    print('UserStateError: $error');
  }
}

class UserStateSuccess extends UserState {
  final User user;

  UserStateSuccess({required this.user});
}

class UserCubit extends Cubit<UserState> {
  final String username;
  final IUserRepository userRepository;

  UserCubit({
    required this.username,
    required this.userRepository,
  }) : super(UserStateEmpty()) {
    init();
  }

  Future init() async {
    this.emit(UserStateLoading());

    await this
        .userRepository
        .getOneByUsername(username)
        .then((user) => this.emit(UserStateSuccess(user: user)))
        .catchError((error) => this.emit(UserStateError(error: error)));
  }
}
