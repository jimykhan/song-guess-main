
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:song_guess/constants/color.dart';
import 'package:song_guess/main.dart';



SnackBarMessage({String? message,bool error = true}){
  BotToast.showCustomNotification(
      toastBuilder: (void Function() cancelFunc) {
        return Container(
          // alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: error? red : green,
                borderRadius: BorderRadius.circular(10)
            ),
            margin: EdgeInsets.only(
              left: 10,
              right: 10,
              bottom: 50,
            ),
            child: Text(message??'',
              style: TextStyle(fontSize: 12,
                  color: Colors.white),
            ));
      },
      align: Alignment.bottomCenter
  );
}