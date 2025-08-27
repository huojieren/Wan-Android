import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wan_android/common_ui/common_style.dart';
import 'package:wan_android/common_ui/smart_refresh/smart_refresh_widget.dart';
import 'package:wan_android/common_ui/web/webview_page.dart';
import 'package:wan_android/common_ui/web/webview_widget.dart';
import 'package:wan_android/pages/knowledge/detail/knowledge_detail_vm.dart';
import 'package:wan_android/repository/data/knowledge_detail_list_data.dart';
import 'package:wan_android/utils/route_utils.dart';

class KnowledgeTabChildPage extends StatefulWidget {
  const KnowledgeTabChildPage({super.key, this.cid});

  final String? cid;

  @override
  State<KnowledgeTabChildPage> createState() => _KnowledgeTabChildPageState();
}

class _KnowledgeTabChildPageState extends State<KnowledgeTabChildPage> {
  KnowledgeDetailViewModel viewModel = KnowledgeDetailViewModel();
  RefreshController refreshController = RefreshController();

  @override
  void initState() {
    super.initState();
    refreshOrLoad(false);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return viewModel;
      },
      child: Scaffold(
        body: Consumer<KnowledgeDetailViewModel>(
          builder: (context, viewModel, child) {
            return SmartRefreshWidget(
              controller: refreshController,
              onRefresh: () async {
                refreshOrLoad(false);
              },
              onLoading: () async {
                refreshOrLoad(true);
              },
              child: ListView.builder(
                itemCount: viewModel.detailList.length,
                itemBuilder: (context, index) {
                  var item = viewModel.detailList[index];
                  return _item(
                    viewModel.detailList[index],
                    onTap: () {
                      RouteUtils.push(
                        context,
                        WebViewPage(
                          webViewType: WebViewType.URL,
                          loadResource: item.link ?? "",
                          showTitle: true,
                          title: item.title,
                        ),
                      );
                    },
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

  void refreshOrLoad(bool loadMore) {
    viewModel.getDetailList(widget.cid, loadMore).then((value) {
      if (loadMore) {
        refreshController.loadComplete();
      } else {
        refreshController.refreshCompleted();
      }
    });
  }

  Widget _item(KnowledgeDetailItemData? item, {GestureTapCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 15.w),
        padding: EdgeInsets.all(10.r),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black12, width: 0.5.r),
        ),
        child: Column(
          children: [
            Row(
              children: [
                normalText(item?.superChapterName),
                Expanded(child: SizedBox()),
                Text("${item?.niceShareDate}"),
              ],
            ),
            Text("${item?.title}", style: titleTextStyle15),
            Row(
              children: [
                normalText(item?.chapterName),
                Expanded(child: SizedBox()),
                Text("${item?.shareUser}"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
