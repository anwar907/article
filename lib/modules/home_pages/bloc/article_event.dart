part of 'article_bloc.dart';

@immutable
abstract class ArticleEvent {}

class FetchArticles extends ArticleEvent {}

class ParsingArticle extends ArticleEvent {
  ParsingArticle({required this.article});
  final Article article;
}
