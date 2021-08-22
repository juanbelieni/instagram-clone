import 'package:dio/dio.dart';

final options = BaseOptions(
  baseUrl: 'https://instagram.com',
);

final instagramApi = Dio(options);
