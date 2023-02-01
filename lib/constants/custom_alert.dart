import 'package:flutter/material.dart';
import 'package:song_guess/main.dart';

CustomAlertDialog({Widget? child}) {
  showDialog(
    context: applicationContext!.currentContext!,

    builder: (BuildContext context) {
      // return object of type Dialog
      return Scaffold(

        // color: Colors.transparent,
        backgroundColor: Colors.transparent,
        body: Container(
          height: MediaQuery.of(context).size.height,
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Color(0xffE6EFFA),
                border: Border.all(
                  width: 1,
                  color: Color(0xff116DDA).withOpacity(0.7),
                )

            ),
            padding: EdgeInsets.all(
                10
            ),
            // height: ApplicationSizing.convert(100),

            child: child??Container(),
          ),
        ),
      );
    },
  );
}