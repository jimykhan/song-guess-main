import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:song_guess/models/top_items_model.dart';
import 'package:spotify_sdk/models/crossfade_state.dart';
import 'package:spotify_sdk/platform_channels.dart';
import 'package:spotify_sdk/spotify_sdk.dart';
import 'package:spotify_sdk/spotify_sdk_web.dart';

class SpotifyService {
  static const MethodChannel _channel =
      MethodChannel(MethodChannels.spotifySdk);

  String host = "https://api.spotify.com";
  Dio? dio;
  String? currentUserAccessToken;
  ProviderReference? _ref;
  SpotifyService({ProviderReference? ref}) {
    _ref = ref;
    dio = Dio();
  }

  static Future<Uint8List?> getImageFromString(
      {required String imageUri,
      ImageDimension dimension = ImageDimension.medium}) async {
    try {
      return _channel.invokeMethod(MethodNames.getImage, {
        ParamNames.imageUri: imageUri,
        ParamNames.imageDimension: dimension.value
      });
    } on Exception catch (e) {
      // _logException(MethodNames.getImage, e);
      rethrow;
    }
  }

  Future<String?> getAccessToken() async {
    String scope = "";
    try {
      scope = (Platform.isIOS || Platform.isAndroid)
          ? 'app-remote-control, '
              'user-modify-playback-state, '
              'playlist-read-private,user-top-read,user-library-read,'
              'playlist-modify-public,user-read-currently-playing'
          : 'streaming user-read-email user-read-private app-remote-control '
              'user-modify-playback-state playlist-read-private user-top-read '
              'user-library-read playlist-modify-public user-read-currently-playing';
    } catch (ex) {
      scope = 'streaming user-read-email user-read-private app-remote-control '
          'user-modify-playback-state playlist-read-private user-top-read '
          'user-library-read playlist-modify-public user-read-currently-playing';
    }
    try {
      var authenticationToken = await SpotifySdk.getAccessToken(
          clientId: dotenv.env['CLIENT_ID'].toString(),
          redirectUrl: dotenv.env['REDIRECT_URL'].toString(),
          scope: scope);
      currentUserAccessToken = authenticationToken;
      return authenticationToken;
    } on PlatformException catch (e) {
      print(Future.error('$e.code: $e.message'));
      return null;
    } on MissingPluginException {
      print(Future.error('not implemented'));
      return null;
    } catch (ex) {
      print("$ex");
      return null;
    }
  }

  Future<bool> disconnect() async {
    try {
      var result = await SpotifySdk.disconnect();
      return result;
    } on PlatformException catch (e) {
      return false;
    } on MissingPluginException {
      return false;
    }
  }

  Future<bool> connectToSpotifyRemote({String? accessToken}) async {
    try {
      var result = await SpotifySdk.connectToSpotifyRemote(
          clientId: dotenv.env['CLIENT_ID'].toString(),
          redirectUrl: dotenv.env['REDIRECT_URL'].toString(),
        accessToken: accessToken,
        playerName: "Web Playback SDK Template",
      );
      return result;
    } on PlatformException catch (e) {
      return false;
    } on MissingPluginException {
      return false;
    }
  }

  Future getPlayerState() async {
    try {
      return await SpotifySdk.getPlayerState();
    } on PlatformException catch (e) {
    } on MissingPluginException {}
  }

  Future<CrossfadeState?> getCrossfadeState() async {
    CrossfadeState? crossfadeState;
    try {
      var crossfadeState = await SpotifySdk.getCrossFadeState();
      return crossfadeState;
    } on PlatformException catch (e) {
      return crossfadeState;
    } on MissingPluginException {
      return crossfadeState;
    }
  }

  Future<void> queue() async {
    try {
      await SpotifySdk.queue(
          spotifyUri: 'spotify:track:58kNJana4w5BIjlZE2wq5m');
    } on PlatformException catch (e) {
    } on MissingPluginException {}
  }

  Future<void> toggleRepeat() async {
    try {
      await SpotifySdk.toggleRepeat();
    } on PlatformException catch (e) {
    } on MissingPluginException {}
  }

  Future<void> setRepeatMode(RepeatMode repeatMode) async {
    try {
      await SpotifySdk.setRepeatMode(
        repeatMode: repeatMode,
      );
    } on PlatformException catch (e) {
    } on MissingPluginException {}
  }

  Future<void> setShuffle(bool shuffle) async {
    try {
      await SpotifySdk.setShuffle(
        shuffle: shuffle,
      );
    } on PlatformException catch (e) {
    } on MissingPluginException {}
  }

  Future<void> toggleShuffle() async {
    try {
      await SpotifySdk.toggleShuffle();
    } on PlatformException catch (e) {
    } on MissingPluginException {}
  }

  Future<bool> play(String albumLink) async {
    try {
      var music = await SpotifySdk.play(spotifyUri: albumLink);
      print("$music");
      return true;
    } catch(ex){
      print("got error in catch......");
      return false;
    }
  }

  Player1() {
    Player(PlayerOptions()).connect();
  }

  Future<void> pause() async {
    try {
      await SpotifySdk.pause();
    } on PlatformException catch (e) {
    } on MissingPluginException {}
  }

  Future<void> stopAndPlay() async {
    try {
      // await SpotifySdk.;
    } on PlatformException catch (e) {
    } on MissingPluginException {}
  }

  Future<void> resume() async {
    try {
      await SpotifySdk.resume();
    } on PlatformException catch (e) {
    } on MissingPluginException {}
  }

  Future<void> skipNext() async {
    try {
      await SpotifySdk.skipNext();
    } on PlatformException catch (e) {
    } on MissingPluginException {}
  }

  Future<void> skipPrevious() async {
    try {
      await SpotifySdk.skipPrevious();
    } on PlatformException catch (e) {
    } on MissingPluginException {}
  }

  Future<void> seekTo() async {
    try {
      await SpotifySdk.seekTo(positionedMilliseconds: 20000);
    } on PlatformException catch (e) {
    } on MissingPluginException {}
  }

  Future<void> seekToRelative() async {
    try {
      await SpotifySdk.seekToRelativePosition(relativeMilliseconds: 20000);
    } on PlatformException catch (e) {
    } on MissingPluginException {}
  }

  Future<void> addToLibrary() async {
    try {
      await SpotifySdk.addToLibrary(
          spotifyUri: 'spotify:track:58kNJana4w5BIjlZE2wq5m');
    } on PlatformException catch (e) {
    } on MissingPluginException {}
  }

  Future<void> checkIfAppIsActive(BuildContext context) async {
    try {
      var isActive = await SpotifySdk.isSpotifyAppActive;
      final snackBar = SnackBar(
          content: Text(isActive
              ? 'Spotify app connection is active (currently playing)'
              : 'Spotify app connection is not active (currently not playing)'));

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } on PlatformException catch (e) {
    } on MissingPluginException {}
  }

  getUserAlbums() async {
    TopItemsModel? topItemsModel;
    try {
      Response? res =
          await dio?.get("$host/v1/me/albums?limit=20&market=es&offset=0",
              options: Options(
                headers: {
                  'Authorization': 'Bearer $currentUserAccessToken',
                  'Content-Type': 'application/json'
                },
              ));
      if (res?.statusCode == 200) {
        topItemsModel = TopItemsModel.fromJson(res!.data);
        print("${res.data}");
        return topItemsModel;
      } else {
        return topItemsModel;
      }
    } catch (ex) {
      print("$ex");
      return null;
    }
  }

  Future<TopItemsModel?> getUserTracks() async {
    TopItemsModel? topItemsModel;
    try {
      Response? res =
          await dio?.get("$host/v1/me/tracks?limit=20&market=es&offset=0",
              options: Options(
                headers: {
                  'Authorization': 'Bearer $currentUserAccessToken',
                  'Content-Type': 'application/json'
                },
              ));
      if (res?.statusCode == 200) {
        topItemsModel = TopItemsModel.fromJson(res!.data);
        print("${res.data}");
      }
      return topItemsModel;
    } catch (ex) {
      print("$ex");
      return topItemsModel;
    }
  }

  Future<TopItemsModel?> getUserTopItem() async {
    TopItemsModel? topItemsModel;
    try {
      print("$currentUserAccessToken");
      Response? res = await dio?.get(
          "$host/v1/me/top/tracks?limit=20&offset=5&time_range=long_term",
          options: Options(
            headers: {
              'Authorization': 'Bearer $currentUserAccessToken',
              'Content-Type': 'application/json'
            },
          ));
      print("This gettopitem respose code ${res?.statusCode}");
      if (res?.statusCode == 200) {
        topItemsModel = TopItemsModel.fromJson(res!.data);
        print("${res.data}");
      }
      return topItemsModel;
    } catch (ex) {
      print("$ex");
      return topItemsModel;
    }
  }
}
