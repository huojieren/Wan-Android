import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wan_android/pages/search/search_vm.dart';
import 'package:wan_android/utils/route_utils.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key, this.keyword});

  final String? keyword;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late TextEditingController controller;
  SearchViewModel viewModel = SearchViewModel();

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.keyword);
    viewModel.search(widget.keyword);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return viewModel;
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              _searchBar(
                onBack: () {
                  RouteUtils.pop(context);
                },
                onCancel: () {
                  controller.clear();
                  viewModel.clear();
                  FocusScope.of(context).unfocus();
                },
                onSubmit: (value) {
                  viewModel.search(value);
                  SystemChannels.textInput.invokeMethod('TextInput.hide');
                },
              ),
              Consumer<SearchViewModel>(
                builder: (context, value, child) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: value.searchList?.length ?? 0,
                      itemBuilder: (context, index) {
                        return _listItem(viewModel.searchList?[index].title, () {});
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _searchBar({
    GestureTapCallback? onBack,
    GestureTapCallback? onCancel,
    ValueChanged<String>? onSubmit,
  }) {
    return Container(
      color: Colors.teal,
      height: 50.h,
      width: double.infinity,
      child: Row(
        children: [
          SizedBox(width: 5.w),
          GestureDetector(
            onTap: onBack,
            child: Image.asset("assets/images/icon_back.png", width: 35.r, height: 35.r),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(6.r),
              child: TextField(
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.search,
                controller: controller,
                onSubmitted: onSubmit,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.only(left: 10.w),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.all(Radius.circular(15.r)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.all(Radius.circular(15.r)),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 5.w),
          GestureDetector(
            onTap: onCancel,
            child: Text(
              "取消",
              style: TextStyle(fontSize: 13.sp, color: Colors.white),
            ),
          ),
          SizedBox(width: 15.w),
        ],
      ),
    );
  }

  Widget _listItem(String? title, GestureTapCallback? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.black12, width: 1.r),
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
        child: Html(
          data: title ?? "",
          style: {'html': Style(fontSize: FontSize(15.sp))},
        ),
      ),
    );
  }
}
