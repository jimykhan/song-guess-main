import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:song_guess/constants/color.dart';
import 'package:song_guess/providers.dart';
import 'package:song_guess/view/albums/albums_view_model.dart';
import 'package:song_guess/view/albums/components/music_items.dart';
import 'package:song_guess/widgets/sized_icon_button.dart';
import 'package:spotify_sdk/models/image_uri.dart';
import 'package:spotify_sdk/models/player_state.dart';
import 'package:spotify_sdk/spotify_sdk.dart';
class AlbumsView extends HookWidget {
  static const String route = "/AlbumsView";
  const AlbumsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AlbumsVM albumsVM = useProvider(albumsVMProvider);
    useEffect(
          () {
        albumsVM.getTopItems();
        Future.microtask(() async {

        });
        return () {};
      },
      const [],
    );
    return Scaffold(
        backgroundColor: black,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: black,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon:
              const Icon(Icons.keyboard_arrow_left_rounded, color: white)),
          actions: [
            TextButton(
                onPressed: albumsVM.startRandomSong,
                child: const Text("Guess Song",style: TextStyle(color: white),)
            ),
          ],
        ),
        extendBodyBehindAppBar: true,
        body: Stack(
          alignment: Alignment.center,
          children: [
             SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return MusicItem(items: albumsVM.topItemsModel!.items![index],);
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(height: 15,);
                  }, itemCount: albumsVM.topItemsModel?.items?.length??0,),
              ),
            Container(
              child: playWidget(),
            ),
          ],
        )
    );
  }
}

class playWidget extends HookWidget {
  const playWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AlbumsVM albumsVM = useProvider(albumsVMProvider);
    return Container(
      child: StreamBuilder<PlayerState>(
        stream: SpotifySdk.subscribePlayerState(),
        builder: (BuildContext context, AsyncSnapshot<PlayerState> snapshot) {
          var track = snapshot.data?.track;
          // currentTrackImageUri = track?.imageUri;
          PlayerState? playerState = snapshot.data;

          if (playerState == null || track == null) {
            return Center(
              child: Container(),
            );
          }
          if(playerState.playbackSpeed == 1.0){
            // albumsVM.startTimer();
          }
          return Container(
            margin: EdgeInsets.only(bottom: 100,top: 150,left: 20,right: 20),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: white.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 100
                  )
                ],
                color: black,
                borderRadius: BorderRadius.circular(10)
            ),

            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      child: spotifyImageWidget(albumsVM,playerState,track.imageUri)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      SizedIconButton(
                        width: 50,
                        icon: Icons.skip_previous,

                        onPressed: albumsVM.skipPrevious,
                      ),
                      playerState.isPaused
                          ? SizedIconButton(
                        width: 50,
                        icon: Icons.play_arrow,
                        onPressed: albumsVM.resume,
                      )
                          : SizedIconButton(
                        width: 50,
                        icon: Icons.pause,
                        onPressed: albumsVM.pause,
                      ),
                      SizedIconButton(
                        width: 50,
                        icon: Icons.skip_next,
                        onPressed: albumsVM.skipNext,
                      ),
                    ],
                  ),
                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     const Divider(),
                  //     const Text(
                  //       'Set Shuffle and Repeat',
                  //       style: TextStyle(fontSize: 16),
                  //     ),
                  //     Row(
                  //       children: [
                  //         const Text(
                  //           'Repeat Mode:',
                  //         ),
                  //         DropdownButton<RepeatMode>(
                  //           value: RepeatMode
                  //               .values[playerState.playbackOptions.repeatMode.index],
                  //           items: const [
                  //             DropdownMenuItem(
                  //               value: RepeatMode.off,
                  //               child: Text('off'),
                  //             ),
                  //             DropdownMenuItem(
                  //               value: RepeatMode.track,
                  //               child: Text('track'),
                  //             ),
                  //             DropdownMenuItem(
                  //               value: RepeatMode.context,
                  //               child: Text('context'),
                  //             ),
                  //           ],
                  //           onChanged: (repeatMode) => albumsVM.setRepeatMode,
                  //         ),
                  //       ],
                  //     ),
                  //     Row(
                  //       children: [
                  //         const Text('Set shuffle: '),
                  //         Switch.adaptive(
                  //           value: playerState.playbackOptions.isShuffling,
                  //           onChanged: (bool shuffle) => albumsVM.setShuffle,
                  //         ),
                  //       ],
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
  Widget spotifyImageWidget(AlbumsVM albumsVM,PlayerState playerState,ImageUri image) {
    return albumsVM.countDown == 0 ?
        Image.network(image.raw)
    // FutureBuilder(
    //     future: SpotifySdk.getImage(
    //       imageUri: image,
    //       dimension: ImageDimension.large,
    //     ),
    //     builder: (BuildContext context, AsyncSnapshot<Uint8List?> snapshot) {
    //       if (snapshot.hasData) {
    //         return Stack(
    //           children: [
    //             Image.memory(snapshot.data!),
    //             Text('Progress: ${playerState.playbackPosition/1000}m/${playerState.track!.duration/1000}m'),
    //           ],
    //         );
    //       } else if (snapshot.hasError) {
    //         return SizedBox(
    //           width: ImageDimension.large.value.toDouble(),
    //           height: 100,
    //           child: const Center(child: Text('Error getting image',style: TextStyle(color: Colors.white),)),
    //         );
    //       } else {
    //         return SizedBox(
    //           width: ImageDimension.large.value.toDouble(),
    //           height: 400,
    //           child: const Center(child: Text('Getting image...',style: TextStyle(color: Colors.white),)),
    //         );
    //       }
    //     })
        : Image.asset("assets/images/guess_song.png");
  }
}


