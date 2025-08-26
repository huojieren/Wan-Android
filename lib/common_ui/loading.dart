import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';

class Loading {
  Loading._();

  static Future showLoading() async {
    showToastWidget(
      Container(
        color: Colors.transparent,
        constraints: BoxConstraints.expand(),
        child: Align(
          child: Container(
            padding: EdgeInsets.all(20.r),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: Colors.black54,
            ),
            child: CircularProgressIndicator(
              strokeWidth: 2.r,
              valueColor: AlwaysStoppedAnimation(Colors.white),
            ),
          ),
        ),
      ),
      handleTouch: true,
      duration: Duration(days: 1),
    );
  }

  static void dismissAll() {
    dismissAllToast();
  }
}
