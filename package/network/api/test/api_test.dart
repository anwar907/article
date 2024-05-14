import 'dart:convert';

import 'package:api/src/api_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements http.Client {}

Future<void> main() async {
  late ApiRepository apiRepository;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    apiRepository = ApiRepository(client: mockHttpClient);

    // Register the Uri type as a fallback value for Mocktail
    registerFallbackValue(Uri.parse(''));
  });

  group('api', () {
    test('exception', () async {
      final mockResponse = {
        "status": "ok",
        "totalResults": 1,
        "articles": [
          {
            "source": {"id": null, "name": "Example.com"},
            "author": "John Doe",
            "title":
                "'Google's 3D video conferencing platform, Project Starline, is coming in 2025 with help from HP | TechCrunch'",
            "description": "Example Description",
            "url": "http://example.com",
            "urlToImage": "http://example.com/image.jpg",
            "publishedAt": "2023-01-01T00:00:00Z",
            "content": "Example Content"
          }
        ]
      };

      when(() => mockHttpClient.get(any())).thenAnswer(
          (_) async => http.Response(json.encode(mockResponse), 200));

      final result = await apiRepository.getArticle();

      expect(result.articles?.length, 100);
      expect(result.articles?.first.author, 'Kyle Wiggers');
    });

    test('http call error', () async {
      when(() => mockHttpClient.get(any()))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      await expectLater(
        () async => await apiRepository.getArticle(),
        throwsA(isA<Exception>()),
      );
    });
  });
}
