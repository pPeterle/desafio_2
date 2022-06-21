import 'package:app/app/modules/home/presenter/home/tab/photos_curated/photos_curated_widget.dart';
import 'package:app/app/modules/home/presenter/home/widgets/home_app_bar.dart';
import 'package:app/app/modules/home/presenter/home/widgets/home_tab_bar_widget.dart';
import 'package:app/app/modules/home/presenter/home/widgets/search_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'home_store.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key? key, this.title = "Home"}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State with SingleTickerProviderStateMixin {
  final HomeStore store = Modular.get();
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    store.fetchData();
    store.selectError.addListener(() {
      if (store.error != null) {
        final colorScheme = Theme.of(context).colorScheme;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Algum erro',
              style: TextStyle(color: colorScheme.onSecondary),
            ),
            action: SnackBarAction(
              label: 'Retry',
              textColor: colorScheme.onSecondary,
              onPressed: () {
                store.fetchData();
              },
            ),
            backgroundColor: colorScheme.secondary,
            duration: const Duration(seconds: 10),
          ),
        );
      }
    });
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
