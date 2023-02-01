import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:song_guess/service/spotify_service.dart';
import 'package:spotify_sdk/models/image_uri.dart';
import 'package:spotify_sdk/spotify_sdk.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class SpotifyImageView extends StatelessWidget {
  String image;
  double? width;
  double? height;

   SpotifyImageView({Key? key,required this.image,this.width,this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return kIsWeb? Image.network(image) : Container(
      child: FutureBuilder(
          future: SpotifyService.getImageFromString(
            imageUri: image,
            dimension: ImageDimension.large,
          ),
          builder: (BuildContext context, AsyncSnapshot<Uint8List?> snapshot) {
            if (snapshot.hasData) {
              return Image.memory(snapshot.data!);
            } else if (snapshot.hasError) {
              return SizedBox(
                width: width??ImageDimension.large.value.toDouble(),
                height: height??ImageDimension.large.value.toDouble(),
                child: const Center(child: Text('Error getting image')),
              );
            } else {
              return SizedBox(
                width: width??ImageDimension.large.value.toDouble(),
                height: height??ImageDimension.large.value.toDouble(),
                child: const Center(child: Text('Getting image...')),
              );
            }
          }),
    );
  }
}
