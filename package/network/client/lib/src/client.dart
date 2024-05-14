import 'package:client/models/article_models.dart';

abstract class ApiClient {
  Future<ArticleModels> getArticle();
}
