import 'package:app/app/modules/home/presenter/home/tab/photos_curated/photos_curated_widget.dart';
import 'package:app/app/modules/home/presenter/home/widgets/home_app_bar.dart';
import 'package:app/app/modules/home/presenter/home/widgets/home_tab_bar_widget.dart';
import 'package:app/app/modules/home/presenter/home/widgets/search_bar_widget.dart';
import 'package:app/app/modules/home/presenter/util/show_error_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'home_store.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key? key, this.title = "Home"}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State
    with SingleTickerProviderStateMixin, ShowErrorMixin {
  final HomeStore store = Modular.get();
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: const HomeAppBarWidget(),
      backgroundColor: theme.colorScheme.primary,
      body: Column(
        children: [
          Container(
            color: theme.colorScheme.secondary,
            child: const SearchBarWidget(),
          ),
          HomeTabBarWidget(tabController: _tabController),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                const PhotosCuratedWidget(),
                Container(),
                Container(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
