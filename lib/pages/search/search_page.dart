import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wan_android/common_ui/smart_refresh/smart_refresh_widget.dart';
import 'package:wan_android/pages/search/search_vm.dart';
import 'package:wan_android/utils/route_utils.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key, this.keyword});

  final String? keyword;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late TextEditingController textController;
  SearchViewModel viewModel = SearchViewModel();
  RefreshController refreshController = RefreshController();

  @override
  void initState() {
    super.initState();
    textController = TextEditingController(text: widget.keyword);
    viewModel.search(keyword: widget.keyword);
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
                  textController.clear();
                  viewModel.clear();
                  FocusScope.of(context).unfocus();
                },
                onSubmit: (value) {
                  viewModel.search(keyword: value);
                  SystemChannels.textInput.invokeMethod('TextInput.hide');
                },
              ),
              Expanded(
                child: Consumer<SearchViewModel>(
                  builder: (context, vm, child) {
                    return SmartRefreshWidget(
                      controller: refreshController,
                      onRefresh: () async {
                        refreshOrLoad(false);
                      },
                      onLoading: () async {
                        refreshOrLoad(true);
                      },
                      child: ListView.builder(
                        itemCount: vm.searchList?.length ?? 0,
                        itemBuilder: (context, index) {
                          return _listItem(vm.searchList?[index].title, () {});
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void refreshOrLoad(bool loadMore) {
    viewModel.search(keyword: widget.keyword, loadMore: loadMore).then((value) {
      if (loadMore) {
        refreshController.loadComplete();
      } else {
        refreshController.refreshCompleted();
      }
    });
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
                controller: textController,
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
