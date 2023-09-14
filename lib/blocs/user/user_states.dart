import 'package:flutter/foundation.dart';

import '../../data/models/user_model.dart';

@immutable
abstract class UserDataState {}
// abstract class PostsActionState extends TopAnimeState {}

class UserDataInitial extends UserDataState {}

class UserDataFetchingLoadingState extends UserDataState {}

class UserDataFetchingErrorState extends UserDataState {}

class UserDataFetchingSuccessfulState extends UserDataState {
  final UserModel user;
  UserDataFetchingSuccessfulState({
    required this.user,
  });
}

abstract class UserDataActionState extends UserDataState {}

// class UserDataFetchingLoadingState extends UserDataState {}
class UserDataActionInitial extends UserDataActionState {}

class UserDataUpdateNameErrorState extends UserDataActionState {}

class UserDataUpdateNameSuccessfulState extends UserDataActionState {
  // final UserModel user;
  UserDataUpdateNameSuccessfulState();
}

class UserPhotoUpdateErrorState extends UserDataActionState {}

class UserPhotoUpdateSuccessfulState extends UserDataActionState {
  // final UserModel user;
  UserPhotoUpdateSuccessfulState();
}

class UserPhotoResetErrorState extends UserDataActionState {}

class UserPhotoResetSuccessfulState extends UserDataActionState {
  // final UserModel user;
  UserPhotoResetSuccessfulState();
}

@immutable
abstract class UserActivityState {}

abstract class UserActionState extends UserActivityState {}

class UserActivityInitial extends UserActivityState {}

class AnimeFavouriteClickedState extends UserActivityState {
  final bool fav;
  AnimeFavouriteClickedState({
    required this.fav,
  });
}

class FavouriteDeleteClickedState extends UserActivityState {
  // final bool fav;
  FavouriteDeleteClickedState();
}

class WatchSelectState extends UserActivityState {
  final String type;
  WatchSelectState({
    required this.type,
  });
}

class UserActivityErrorState extends UserActivityState {}
