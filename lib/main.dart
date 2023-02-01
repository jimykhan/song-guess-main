import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:song_guess/view/albums/albums_view.dart';
import 'package:song_guess/view/get_start/get_start_view.dart';

import 'widgets/sized_icon_button.dart';
GlobalKey<NavigatorState>? applicationContext = GlobalKey();
Future<void> main() async {
  await dotenv.load(fileName: '.env');
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: applicationContext,
      builder: EasyLoading.init(),
      debugShowCheckedModeBanner: false,
      title: 'Spotify',
      initialRoute: GetStartedPage.route,
      routes: {
        GetStartedPage.route :(context) => GetStartedPage(),
        AlbumsView.route :(context) => AlbumsView(),
      },
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      // home: const GetStartedPage(),
    );
  }
}

