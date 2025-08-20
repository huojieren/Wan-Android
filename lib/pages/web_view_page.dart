import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WebViewPage extends StatefulWidget {
  String title;

  WebViewPage({super.key, required this.title});

  @override
  State<StatefulWidget> createState() {
    return _WebViewPageState();
  }
}

class _WebViewPageState extends State<WebViewPage> {
  String? title;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timestamp) {
      var map = ModalRoute.of(context)?.settings.arguments;
      if (map is Map) {
        title = map["key"];
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title ?? "")),
      body: SafeArea(
        child: Container(
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              width: 200.w,
              height: 50.w,
              child: Text(widget.title ?? ""),
            ),
          ),
        ),
      ),
    );
  }
}
