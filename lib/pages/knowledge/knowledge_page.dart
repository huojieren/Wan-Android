import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wan_android/pages/knowledge/detail/knowledge_detail_tab_page.dart';
import 'package:wan_android/pages/knowledge/knowledge_vm.dart';
import 'package:wan_android/repository/data/knowledge_list_data.dart';
import 'package:wan_android/utils/route_utils.dart';

class KnowledgePage extends StatefulWidget {
  const KnowledgePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _KnowledgePageState();
  }
}

class _KnowledgePageState extends State<KnowledgePage> {
  KnowledgeViewModel viewModel = KnowledgeViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.getKnowledgeList();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return viewModel;
      },
      child: Scaffold(
        body: SafeArea(
          child: Consumer<KnowledgeViewModel>(
            builder: (context, viewModel, child) {
              return ListView.builder(
                itemCount: viewModel.list?.length ?? 0,
                itemBuilder: (context, index) {
                  return _itemView(viewModel.list?[index]);
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _itemView(KnowledgeListData? item) {
    return GestureDetector(
      onTap: () {
        RouteUtils.push(context, KnowledgeDetailsTabPage(tabList: item?.children));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black12),
          borderRadius: BorderRadius.circular(5.r),
        ),
        margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item?.name ?? "",
                    style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    viewModel.generalSubTitle(item?.children),
                    style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            Image.asset("assets/images/img_arrow_right.png", width: 15.w, height: 20.h),
          ],
        ),
      ),
    );
  }
}
