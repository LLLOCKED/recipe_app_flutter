import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:recipe_app/constants.dart';
import 'package:recipe_app/models/vision_model.dart';
import 'package:dio/dio.dart';

Dio dio = Dio();
Future<Vision> visionImage({required File file}) async {
  var formData = FormData.fromMap({
    'file': await MultipartFile.fromFile(file.path,
        contentType: MediaType('image', 'jpg')),
  });

  final response = await Dio()
      .post('${ApiConstants.baseUrl}${ApiConstants.visionEndpoint}/image',
          data: formData,
          options: Options(headers: {
            "Content-type": "multipart/form-data",
          }));

  if (response.statusCode == 200) {
    // Перевірка на успішну відповідь з серверу (код 200)
    Vision result = Vision.fromJson(
        response.data); // Використовуйте відповідь без розшифрування
    print(result.uniqueNames.toString());
    return result; // Парсинг відповіді у об'єкт Vision
  } else {
    throw Exception('Помилка запиту на візуальне розпізнавання');
  }
}
