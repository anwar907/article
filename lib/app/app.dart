import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_pages_repository/home_pages_repository.dart';

class App extends StatelessWidget {
  const App({super.key, required HomePagesRepository homePagesRepository})
      : _homePagesRepository = homePagesRepository;

  final HomePagesRepository _homePagesRepository;
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [RepositoryProvider.value(value: _homePagesRepository)],
        child: MultiBlocProvider(
            providers: const [],
            child: MaterialApp(
                title: 'Flutter Demo',
                theme: ThemeData(
                  colorScheme:
                      ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                  useMaterial3: true,
                ),
                home: const Text('data'))));
  }
}
