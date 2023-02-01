import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:song_guess/models/top_items_model.dart';
import 'package:song_guess/models/top_playlist_model.dart';
import 'package:song_guess/providers.dart';
import 'package:song_guess/service/spotify_service.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

class AlbumsVM extends ChangeNotifier{
  TopItemsModel? topItemsModel;
  TopPlayList? topPlayList;
  ProviderReference? _ref;
  SpotifyService? spotifyService;
  Timer? _timer;
  bool loadingAlbum = true;
  bool connecting = false;
  int countDown = 20;
  AlbumsVM({ProviderReference? ref}){
    _ref = ref;
    spotifyService = ref?.read(spotifyServiceProvider);
  }


  // spotifyOauth()async{
  //   String? result = await spotifyService?.getAccessToken();
  //   if(result!=null)connectToSpotify();
  // }

  setLoadingAlbum(check){
    loadingAlbum = check;
    if(check){
      EasyLoading.show(status: "Loading",dismissOnTap: false);
    }else{
      EasyLoading.dismiss();
    }
    notifyListeners();
  }

  setConnecting(check){
    connecting = check;
    notifyListeners();
  }



  getAlbums() async {
    // setLoadingAlbum(true);
    await spotifyService?.getUserAlbums();
    setLoadingAlbum(false);
  }
  getTopItems() async {
    EasyLoading.show(status: "Loading",dismissOnTap: false);
    // setLoadingAlbum(true);
    var result = await spotifyService?.getUserTopItem();
    if(result != null){
      topItemsModel = result;
      startRandomSong();
    }
    setLoadingAlbum(false);
  }

  getTopPlayList() async {
    EasyLoading.show(status: "Loading",dismissOnTap: false);
    // setLoadingAlbum(true);
    var result = await spotifyService?.getTopPlayList();
    if(result != null){
      topPlayList = result;
      startRandomSong();
    }
    setLoadingAlbum(false);
  }

  startRandomSong() async {
    Random random = new Random();
    int randomIndex = random.nextInt(topPlayList?.tracks?.items?.length??0);
    String albumLink = topPlayList!.tracks!.items![randomIndex].track!.album!.uri!;
    await play(albumLink);
    startTimer();
  }

  startTimer(){
    bool isActive = _timer?.isActive?? false;
    if(isActive){
      _timer?.cancel();
    }
    countDown = 20;
    notifyListeners();
    _timer = Timer?.periodic(
    Duration(seconds: 1),
    (Timer timer) {
      if (countDown == 0) {
        _timer?.cancel();
        notifyListeners();
      } else {
        countDown = countDown -1;
      }
    });
  }

  stopStartRandomSong(){

  }

  play(String albumsLink)async{
    bool result = await spotifyService?.play(albumsLink)??false;
    if(!result) startRandomSong();
  }

  skipPrevious()async{
    // startRandomSong();
    var result = await spotifyService?.skipPrevious();
    startTimer();
  }
  resume()async{
    var result = await spotifyService?.resume();
  }
  pause()async{
    var result = await spotifyService?.pause();
  }
  skipNext()async{
    var result = await spotifyService?.skipNext();
    startTimer();
    // startRandomSong();
  }
  setRepeatMode()async{
    var result = await spotifyService?.setRepeatMode(RepeatMode.track);
  }
  setShuffle(bool shuffle)async{
    var result = await spotifyService?.setShuffle(shuffle);
  }


}