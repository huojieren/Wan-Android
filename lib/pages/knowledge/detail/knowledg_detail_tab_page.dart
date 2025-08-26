import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wan_android/pages/knowledge/detail/knowledge_tab_child_page.dart';
import 'package:wan_android/repository/data/knowledge_list_data.dart';

import 'knowledge_detail_vm.dart';

class KnowledgeDetailsTabPage extends StatefulWidget {
  const KnowledgeDetailsTabPage({super.key, this.tabList});

  final List<KnowledgeChildren>? tabList;

  @override
  State<KnowledgeDetailsTabPage> createState() {
    return _KnowledgeDetailsTabPageState();
  }
}

class _KnowledgeDetailsTabPageState extends State<KnowledgeDetailsTabPage>
    with SingleTickerProviderStateMixin {
  KnowledgeDetailViewModel viewModel = KnowledgeDetailViewModel();
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: widget.tabList?.length ?? 0, vsync: this);
    viewModel.initTabs(widget.tabList);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return viewModel;
      },
      child: Scaffold(
        appBar: AppBar(
          title: TabBar(
            tabs: viewModel.tabList,
            controller: tabController,
            labelColor: Colors.blue,
            indicatorColor: Colors.blue,
            isScrollable: true,
          ),
        ),
        body: SafeArea(
          child: TabBarView(controller: tabController, children: getChildrenPage()),
        ),
      ),
    );
  }

  List<Widget> getChildrenPage() {
    return widget.tabList?.map((e) {
          return KnowledgeTabChildPage(cid: "${e.id ?? ""}");
        }).toList() ??
        [];
  }
}
