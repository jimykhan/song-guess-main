import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:song_guess/constants/color.dart';
import 'package:song_guess/providers.dart';
import 'package:song_guess/view/albums/albums_view.dart';
import 'package:song_guess/view/get_start/get_start_view_model.dart';

class GetStartedPage extends HookWidget {
  static const String route = "/";
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    GetStartVM getStartVM = useProvider(getStartVMProvider);
    useEffect(
          () {
        // getStartVM.;
        Future.microtask(() async {

        });
        return () {};
      },
      const [],
    );
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/getStarted.png'),
              fit: BoxFit.cover
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('A digital music, podcast, and video service that gives you access to millions of songs and other content from creators all over the world.',
              style: TextStyle(color: ColorConstants.starterWhite, fontSize: 17, fontWeight: FontWeight.w600, ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32,),
            MaterialButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(31)),
              height: 58,
              color: ColorConstants.primaryColor,
              // onPressed: (){},
              onPressed: getStartVM.spotifyOauth,
              child: const Text('Get Started', style: TextStyle(color: Colors.white, fontSize: 18),) ,
            ),
            const SizedBox(height: 32,)
          ],
        ),
      ),
    );
  }
}