import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'home_store.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key? key, this.title = "Home"}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State {
  final HomeStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter'),
      ),
      body: ScopedBuilder<HomeStore, Exception, int>.transition(
        store: store,
        transition: (_, child) {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 100),
            child: child,
          );
        },
        onLoading: (_) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
        onState: (_, counter) {
          return Center(
            child: Text('$counter'),
          );
        },
        onError: (context, error) => const Center(
          child: Text(
            'Too many clicks',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          store.increment();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
