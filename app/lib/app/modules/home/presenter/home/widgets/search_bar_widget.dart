import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../home_module.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 16,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onTap: () async {
          FocusScope.of(context).requestFocus(FocusNode());
          await Modular.to.pushNamed(searchRoute);
        },
        cursorColor: theme.colorScheme.onPrimary.withOpacity(.5),
        decoration: InputDecoration(
          hintText: 'Search',
          hintStyle: TextStyle(
            color: theme.colorScheme.onPrimary.withOpacity(.5),
          ),
          border: InputBorder.none,
          prefixIcon: Icon(
            Icons.search,
            color: theme.colorScheme.onPrimary.withOpacity(.5),
          ),
        ),
      ),
    );
  }
}
