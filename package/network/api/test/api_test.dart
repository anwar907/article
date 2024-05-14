import 'package:api/src/api_repository.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> main() async {
  final respository = ApiRepository();
  test('tes response ', () async {
    final data = await respository.getArticle();
    print('isi dari data $data');
  });
}
