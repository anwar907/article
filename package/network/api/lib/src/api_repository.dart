import 'package:client/client.dart';
import 'package:http/http.dart' as http;

class ApiRepository implements ApiClient {
  final http.Client client;

  ApiRepository({required this.client});

  @override
  Future<ArticleModels> getArticle() async {
    try {
      final response = await http.get(Uri.parse(
          '${Constant.baseUrl}/everything?domains=${Constant.domain}&apiKey=${Constant.apiKey}'));

      if (response.statusCode == 200) {
        return articleModelsFromJson(response.body);
      } else {
        throw Exception('Failed to load article');
      }
    } catch (e) {
      throw Exception('Error fetching article: $e');
    }
  }
}
