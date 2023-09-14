import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_bloc_with_apis/features/posts/models/post_data_ui_model.dart';
// import 'package:flutter_bloc_with_apis/features/posts/repos/posts_repo.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:govt_billing/blocS/user/user_events.dart';

import '../../data/repo/user_repo.dart';
import '../../models/user_model.dart';
import 'user_states.dart';

class UserDataBloc extends Bloc<UserDataEvent, UserDataState> {
  UserDataBloc() : super(UserDataInitial()) {
    on<UserDataInitialFetchEvent>((event, emit) async {
      emit(UserDataFetchingLoadingState());
      try {
        UserModel _user = await UserRepo().createUser(event.user);
        // await UserRepo().createFavourites(event.user.uid);
        await UserRepo().createInvoiceDoc(event.user.uid);
        print(_user.uid);
        emit(UserDataFetchingSuccessfulState(user: _user));
      } catch (error, stackTrace) {
        emit(UserDataFetchingErrorState());
      }
    });
    // on<UserDataUpdateNameEvent>(
    //   (event, emit) async {
    //     emit(UserDataFetchingLoadingState());
    //     try {
    //       UserModel _user =
    //           await UserRepo().updateUserName(event.user.uid, event.name);
    //       emit(UserDataFetchingSuccessfulState(user: _user));
    //     } catch (e) {
    //       emit(UserDataFetchingErrorState());
    //     }
    //   },
    // );
    // on<UserUpdatePhotoEvent>(
    //   (event, emit) async {
    //     emit(UserDataFetchingLoadingState());
    //     try {
    //       UserModel _user =
    //           await UserRepo().updateUserPhoto(event.user.uid, event.user);
    //       emit(UserDataFetchingSuccessfulState(user: _user));
    //     } catch (e) {
    //       emit(UserDataFetchingErrorState());
    //     }
    //   },
    // );
    // on<UserResetPhotoEvent>(
    //   (event, emit) async {
    //     emit(UserDataFetchingLoadingState());
    //     try {
    //       UserModel _user =
    //           await UserRepo().resetUserPhoto(event.user.uid, event.user);
    //       emit(UserDataFetchingSuccessfulState(user: _user));
    //     } catch (e) {
    //       emit(UserDataFetchingErrorState());
    //     }
    //   },
    // );
  }
}

// class UserUpdateBloc extends Bloc<UserDataEvent, UserDataActionState> {
//   UserUpdateBloc() : super(UserDataActionInitial()) {
//     on<UserDataUpdateNameEvent>(
//       (event, emit) async {
//         try {
//           UserModel _user = await UserRepo().updateUser(event.user.uid, event.name);
//           emit(UserDataFetchingSuccessfulState(user: _user));
//         } catch (e) {
//           emit(UserDataUpdateNameErrorState());
//
//         }
//       },
//     );
//   }
// }

// class UserActivityBloc extends Bloc<UserActivityEvent, UserActivityState> {
//   UserActivityBloc() : super(UserActivityInitial()) {
//     on<AnimeFavouriteClickedEvent>(
//       (event, emit) async {
//         try {
//           if (!event.fav) {
//             await UserRepo().addToFavourites(event.anime, event.user.uid);
//             emit(AnimeFavouriteClickedState(fav: !event.fav));
//           } else if (event.fav) {
//             await UserRepo()
//                 .removeFromFavourites(event.anime.malId, event.user.uid);
//             emit(AnimeFavouriteClickedState(fav: !event.fav));
//           }
//         } catch (error, stackTrace) {
//           emit(UserActivityErrorState());
//         }
//       },
//     );
//     on<FavouriteDeleteClickedEvent>(
//       (event, emit) async {
//         try {
//           await UserRepo()
//               .removeFromFavourites(event.anime.malId, event.user.uid);
//           emit(FavouriteDeleteClickedState());
//         } catch (error, stackTrace) {
//           emit(UserActivityErrorState());
//         }
//       },
//     );
//     on<WatchSelectEvent>(
//       (event, emit) async {
//         try {
//           if (event.type == 'Unwatched') {
//             await UserRepo()
//                 .removeFromWatchlist(event.anime.malId, event.user.uid);
//             emit(WatchSelectState(type: event.type));
//           } else {
//             await UserRepo()
//                 .addToWatchlist(event.anime, event.user.uid, event.type);
//             emit(WatchSelectState(type: event.type));
//           }
//         } catch (error, stackTrace) {
//           emit(UserActivityErrorState());
//         }
//       },
//     );
//   }
// }
