part of 'article_bloc.dart';

class ArticleState extends Equatable {
  const ArticleState({
    this.articleModels,
    this.article,
    this.message,
    this.status = GlobalStateStatus.loading,
  });

  final ArticleModels? articleModels;
  final String? message;
  final GlobalStateStatus status;
  final Article? article;

  ArticleState copyWith({
    ArticleModels? articleModels,
    String? message,
    GlobalStateStatus? status,
    Article? article,
  }) {
    return ArticleState(
      articleModels: articleModels ?? this.articleModels,
      message: message ?? this.message,
      status: status ?? this.status,
      article: article ?? this.article,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [articleModels, message, status, article];
}
