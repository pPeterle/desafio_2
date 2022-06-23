import 'package:app/app/modules/home/presenter/home/tab/animals_photos/animals_photos_widget.dart';
import 'package:app/app/modules/home/presenter/home/tab/photos_curated/curated_photos_widget.dart';
import 'package:app/app/modules/home/presenter/home/tab/photos_trends/trends_photos_widget.dart';
import 'package:app/app/modules/home/presenter/home/widgets/home_app_bar.dart';
import 'package:app/app/modules/home/presenter/home/widgets/home_tab_bar_widget.dart';
import 'package:app/app/modules/home/presenter/home/widgets/search_bar_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key? key, this.title = "Home"}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State with SingleTickerProviderStateMixin {
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
              children: const [
                CuratedPhotosWidget(),
                TrendsPhotosWidget(),
                AnimalsPhotosWidget(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
