import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wan_android/pages/knowledge/knowledge_vm.dart';

class KnowledgePage extends StatefulWidget {
  const KnowledgePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _KnowledgePageState();
  }
}

class _KnowledgePageState extends State<KnowledgePage> {
  KnowledgeViewModel viewModel = KnowledgeViewModel();

  // late RefreshController _refreshController;

  @override
  void initState() {
    // _refreshController = RefreshController();
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
                  return Container(
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
                                viewModel.list?[index]?.name ?? "",
                                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                              ),
                              SizedBox(height: 5.h),
                              Text(
                                viewModel.generalSubTitle(viewModel.list?[index]?.children),
                                style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
                              ),
                            ],
                          ),
                        ),
                        Image.asset("assets/images/img_arrow_right.png", width: 15.w, height: 20.h),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  // Widget knowledgeListview() {
  //   return Consumer<KnowledgeViewModel>(
  //     builder: (context, value, child) {
  //       return ListView.builder(
  //         shrinkWrap: true,
  //         physics: const NeverScrollableScrollPhysics(),
  //         itemCount: value.list?.length ?? 0,
  //         itemBuilder: (context, index) {
  //           return knowledgeItem(value.list?[index]);
  //         },
  //       );
  //     },
  //   );
  // }

  // Widget knowledgeItem(KnowledgeModel? item) {
  //   return GestureDetector(
  //     onTap: () {
  //       RouteUtils.push(
  //         context,
  //         KnowledgeDetailsTabPage(params: viewModel.generalParams(item?.children)),
  //       );
  //     },
  //     child: Container(
  //       margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
  //       padding: EdgeInsets.all(8.r),
  //       decoration: BoxDecoration(
  //         border: Border.all(color: Colors.black12, width: 0.5.r),
  //         borderRadius: BorderRadius.all(Radius.circular(5.r)),
  //       ),
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           Expanded(
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text(item?.name ?? "", style: titleTextStyle15),
  //                 SizedBox(height: 10.h),
  //                 Text(viewModel.generalChildNames(item?.children)),
  //               ],
  //             ),
  //           ),
  //           Image.asset("assets/images/img_arrow_right.png", height: 24.r, width: 24.r),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
