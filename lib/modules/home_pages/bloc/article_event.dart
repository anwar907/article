part of 'article_bloc.dart';

@immutable
abstract class ArticleEvent {}


class FetchArticles extends ArticleEvent {}

class ArticleInitial extends ArticleEvent {}