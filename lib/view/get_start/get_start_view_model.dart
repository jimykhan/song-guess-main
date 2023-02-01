import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:song_guess/main.dart';
import 'package:song_guess/providers.dart';
import 'package:song_guess/service/spotify_service.dart';
import 'package:song_guess/view/albums/albums_view.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class GetStartVM extends ChangeNotifier{

  ProviderReference? _ref;
  SpotifyService? spotifyService;
  bool connecting = false;
  GetStartVM({ProviderReference? ref}){
    _ref = ref;
    spotifyService = ref?.read(spotifyServiceProvider);
  }

  spotifyOauth()async{
    String? result = await spotifyService?.getAccessToken();
    if(false){
      if(result!=null) Navigator.of(applicationContext!.currentContext!).pushNamed(AlbumsView.route);
    }else{
      if(result!=null) connectToSpotify(accessToken: result);
    }

  }

  setConnecting(check){
    connecting = check;
    notifyListeners();
  }

  connectToSpotify({String? accessToken}) async {
    setConnecting(true);
    var result  = await spotifyService?.connectToSpotifyRemote(accessToken: accessToken);
    setConnecting(false);
    if(result as bool){
      Navigator.of(applicationContext!.currentContext!).pushNamed(AlbumsView.route);
      // Navigator.push(applicationContext!.currentContext!, MaterialPageRoute(builder: (context) => const AlbumsView()));
    }
  }

}