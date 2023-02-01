import 'package:hooks_riverpod/all.dart';
import 'package:song_guess/service/spotify_service.dart';
import 'package:song_guess/view/albums/albums_view_model.dart';
import 'package:song_guess/view/get_start/get_start_view_model.dart';

final getStartVMProvider = ChangeNotifierProvider<GetStartVM>((ref)=>GetStartVM(ref: ref));
final albumsVMProvider = ChangeNotifierProvider<AlbumsVM>((ref)=>AlbumsVM(ref: ref));
final spotifyServiceProvider = Provider<SpotifyService>((ref)=>SpotifyService(ref: ref));