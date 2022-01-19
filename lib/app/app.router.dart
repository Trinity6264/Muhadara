// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import '../model/post_content_model.dart';
import '../views/audio_player_view.dart';
import '../views/home/view_all/view_all_view.dart';
import '../views/home_view.dart';
import '../views/login_view.dart';
import '../views/register_view.dart';
import '../views/startup_view.dart';

class Routes {
  static const String startUpView = '/';
  static const String audioPlayerView = '/audio-player-view';
  static const String loginView = '/login-view';
  static const String registerView = '/register-view';
  static const String homeView = '/home-view';
  static const String viewAllView = '/view-all-view';
  static const all = <String>{
    startUpView,
    audioPlayerView,
    loginView,
    registerView,
    homeView,
    viewAllView,
  };
}

class StackedRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.startUpView, page: StartUpView),
    RouteDef(Routes.audioPlayerView, page: AudioPlayerView),
    RouteDef(Routes.loginView, page: LoginView),
    RouteDef(Routes.registerView, page: RegisterView),
    RouteDef(Routes.homeView, page: HomeView),
    RouteDef(Routes.viewAllView, page: ViewAllView),
  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    StartUpView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const StartUpView(),
        settings: data,
      );
    },
    AudioPlayerView: (data) {
      var args = data.getArgs<AudioPlayerViewArguments>(
        orElse: () => AudioPlayerViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => AudioPlayerView(
          key: args.key,
          audioUrl: args.audioUrl,
          imageurl: args.imageurl,
          lectureTitle: args.lectureTitle,
          lecturerName: args.lecturerName,
          postedAt: args.postedAt,
          index: args.index,
        ),
        settings: data,
      );
    },
    LoginView: (data) {
      var args = data.getArgs<LoginViewArguments>(
        orElse: () => LoginViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => LoginView(key: args.key),
        settings: data,
      );
    },
    RegisterView: (data) {
      var args = data.getArgs<RegisterViewArguments>(
        orElse: () => RegisterViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => RegisterView(key: args.key),
        settings: data,
      );
    },
    HomeView: (data) {
      var args = data.getArgs<HomeViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => HomeView(
          key: args.key,
          userName: args.userName,
        ),
        settings: data,
      );
    },
    ViewAllView: (data) {
      var args = data.getArgs<ViewAllViewArguments>(
        orElse: () => ViewAllViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => ViewAllView(
          key: args.key,
          content: args.content,
        ),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// AudioPlayerView arguments holder class
class AudioPlayerViewArguments {
  final Key? key;
  final String? audioUrl;
  final String? imageurl;
  final String? lectureTitle;
  final String? lecturerName;
  final DateTime? postedAt;
  final int? index;
  AudioPlayerViewArguments(
      {this.key,
      this.audioUrl,
      this.imageurl,
      this.lectureTitle,
      this.lecturerName,
      this.postedAt,
      this.index});
}

/// LoginView arguments holder class
class LoginViewArguments {
  final Key? key;
  LoginViewArguments({this.key});
}

/// RegisterView arguments holder class
class RegisterViewArguments {
  final Key? key;
  RegisterViewArguments({this.key});
}

/// HomeView arguments holder class
class HomeViewArguments {
  final Key? key;
  final String? userName;
  HomeViewArguments({this.key, required this.userName});
}

/// ViewAllView arguments holder class
class ViewAllViewArguments {
  final Key? key;
  final List<PostContentModel>? content;
  ViewAllViewArguments({this.key, this.content});
}
