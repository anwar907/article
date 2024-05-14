import 'package:api/api.dart';
import 'package:article/app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_pages_repository/home_pages_repository.dart';
import 'package:http/http.dart' as http;

import 'utils/debugger.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = GlobalObserver();

  final apiRespository = ApiRepository(client: http.Client());

  final homePagesRespository = HomePagesRepository(apiClient: apiRespository);

  final app = App(homePagesRepository: homePagesRespository);

  runApp(app);
}
