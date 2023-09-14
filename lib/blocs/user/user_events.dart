// import 'package:anime_track/models/favourites_model.dart';
// import 'package:anime_track/models/user_model.dart';
// import 'package:anime_track/models/watchlist_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../../models/user_model.dart';

// import '../../models/anime_model.dart';

@immutable
abstract class UserDataEvent {}

class UserDataInitialFetchEvent extends UserDataEvent {
  final User user;

  UserDataInitialFetchEvent(this.user);
}

class UserDataUpdateNameEvent extends UserDataEvent {
  final String name;
  final User user;

  UserDataUpdateNameEvent(this.name, this.user);
}

class UserUpdatePhotoEvent extends UserDataEvent {
  // final String photoUrl;
  final UserModel user;
  final String uid;

  UserUpdatePhotoEvent(this.uid, this.user);
}

class UserResetPhotoEvent extends UserDataEvent {
  // final String photoUrl;
  final User user;
  // final String uid;

  UserResetPhotoEvent(this.user);
}

// @immutable
// abstract class UserActivityEvent {}

// class AnimeFavouriteClickedEvent extends UserActivityEvent {
//   final User user;
//   final Anime anime;
//   final bool fav;
//   AnimeFavouriteClickedEvent(
//       {required this.user, required this.anime, required this.fav});
// }

// class FavouriteDeleteClickedEvent extends UserActivityEvent {
//   final User user;
//   final FavouriteTile anime;
//   FavouriteDeleteClickedEvent({required this.user, required this.anime});
// }

// class WatchSelectEvent extends UserActivityEvent {
//   final User user;
//   final WatchlistTile anime;
//   final String type;
//   WatchSelectEvent(
//       {required this.user, required this.anime, required this.type});
// }
