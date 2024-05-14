import 'package:client/client.dart';

class RespositoryException implements Exception {
  RespositoryException(this.error, this.stackTrace);
  final Exception error;

  final StackTrace stackTrace;
}

class HomePagesRepositoryException extends RespositoryException {
  HomePagesRepositoryException(super.error, super.stackTrace);
}

class HomePagesRepository implements Exception {
  HomePagesRepository({required ApiClient apiClient}) : _apiClient = apiClient;

  final ApiClient _apiClient;

  Future<ArticleModels> getArticle() async {
    try {
      return await _apiClient.getArticle();
    } on Exception catch (error, stackTree) {
      throw HomePagesRepositoryException(error, stackTree);
    }
  }
}
