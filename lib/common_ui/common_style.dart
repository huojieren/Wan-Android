import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget commonInput({
  String? labelText,
  TextEditingController? controller,
  ValueChanged<String>? onChanged,
  bool isObscureText = false,
}) {
  return TextField(
    controller: controller,
    onChanged: onChanged,
    style: TextStyle(color: Colors.white),
    obscureText: isObscureText,
    cursorColor: Colors.white,
    decoration: InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white, width: 0.5.r),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white, width: 1.5.r),
      ),
      label: Text(labelText ?? ""),
      labelStyle: const TextStyle(color: Colors.white),
    ),
  );
}

Widget whiteBorderButton({required String title, GestureTapCallback? onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: 45.h,
      margin: EdgeInsets.symmetric(horizontal: 20.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(22.5.r)),
        border: Border.all(color: Colors.white, width: 1.r),
      ),
      child: Text(
        title,
        style: TextStyle(fontSize: 15.sp, color: Colors.white),
      ),
    ),
  );
}
