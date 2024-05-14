import 'package:client/client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_pages_repository/home_pages_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockHomePagesRespository extends Mock implements ApiClient {}

class FakeArticle extends Fake implements ArticleModels {}

void main() {
  final apiClient = MockHomePagesRespository();

  final respository = HomePagesRepository(apiClient: apiClient);

  group('artikel', () {
    test('exception', () async {
      when(() => apiClient.getArticle()).thenThrow(Exception('erorr'));

      expect(() => respository.getArticle(),
          throwsA(isA<HomePagesRepositoryException>()));
    });

    test('return data', () async {
      when(() => apiClient.getArticle())
          .thenAnswer((_) async => ArticleModels());

      expect(await respository.getArticle(), isA<ArticleModels>());
    });
  });
}
