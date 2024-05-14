import 'package:client/client.dart';
import 'package:http/http.dart' as http;

class ApiRepository implements ApiClient {
  @override
  Future<ArticleModels> getArticle() async {
    try {
      final response = await http.get(Uri.parse(
          '${Constant.baseUrl}/everything?domains=${Constant.domain}&apiKey=${Constant.apiKey}'));

      if (response.statusCode == 200) {
        return articleModelsFromJson(response.body);
      }
      return ArticleModels();
    } catch (e) {
      throw Exception(e);
    }
  }
}
