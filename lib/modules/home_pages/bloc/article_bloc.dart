import 'package:client/client.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_pages_repository/home_pages_repository.dart';

part 'article_event.dart';
part 'article_state.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  ArticleBloc({required HomePagesRepository homePagesRepository})
      : _homePagesRepository = homePagesRepository,
        super(const ArticleState()) {
    on<FetchArticles>(fetchArticles);
  }

  final HomePagesRepository _homePagesRepository;

  Future<void> fetchArticles(
      FetchArticles event, Emitter<ArticleState> emit) async {
    try {
      emit(state.copyWith(status: GlobalStateStatus.loading));
      final articles = await _homePagesRepository.getArticle();

      emit(ArticleState(
          articleModels: articles, status: GlobalStateStatus.success));
    } catch (e) {
      emit(state.copyWith(
          status: GlobalStateStatus.error, message: e.toString()));
    }
  }
}
