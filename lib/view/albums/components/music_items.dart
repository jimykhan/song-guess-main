import 'package:flutter/material.dart';
import 'package:song_guess/constants/color.dart';
import 'package:song_guess/constants/spotify_image_view.dart';
import 'package:song_guess/models/top_playlist_model.dart';

class MusicItem extends StatelessWidget {
  Items items;
   MusicItem({
    Key? key,required this.items
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: grey.withOpacity(0.3),
        borderRadius: BorderRadius.circular(5)
      ),
      margin: EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 40,
                  width: 40,
                  child: SpotifyImageView(image: '${items.track!.album!.images![0].url}',),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
           Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "${items.track?.album!.name}",
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Text(
                  "${items.track?.album!.artists![0].name}",
                  style: const TextStyle(color: Colors.white, fontSize: 11),
                ),
              ],
            ),
          // IconButton(
          //     onPressed: () {
          //       favProvider.setFav(data);
          //     },
          //     icon: favProvider.isFavorite(data)
          //         ? const Icon(
          //       Icons.favorite,
          //       color: green,
          //     )
          //         : const Icon(
          //       Icons.favorite_border_rounded,
          //       color: white,
          //     )),
          // IconButton(
          //     onPressed: () {},
          //     icon: const Icon(
          //       Icons.more_vert_rounded,
          //       color: white,
          //     )),
        ],
      ),
    );
  }
}