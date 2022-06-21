import 'package:flutter/material.dart';

class HomeTabBarWidget extends StatelessWidget {
  final TabController tabController;

  const HomeTabBarWidget({Key? key, required this.tabController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      color: theme.colorScheme.primary,
      child: TabBar(
        controller: tabController,
        indicatorColor: theme.colorScheme.surface,
        unselectedLabelColor: theme.colorScheme.onPrimary.withOpacity(.4),
        tabs: const [
          Tab(
            text: 'Curated',
          ),
          Tab(
            text: 'Trends',
          ),
          Tab(
            text: 'Animals',
          )
        ],
      ),
    );
  }
}
