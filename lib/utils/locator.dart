
import 'dart:io';

import 'package:dio/io.dart';
import 'package:pawsible/data/repositories/api_repository_impl.dart';
import 'package:awesome_dio_interceptor/awesome_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/datasources/remote/authapi_service.dart';
import '../data/repositories/user_repository_impl.dart';
import '../domain/contracts/api_repository.dart';
import '../domain/contracts/user_repository.dart';

final locator = GetIt.instance;

Future<void> initializeDependencies() async {
  final dio = Dio();

  //使用內部自我核發憑證時需要關閉
  if (dio.httpClientAdapter is DefaultHttpClientAdapter) {
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
  }


  dio.interceptors.add(AwesomeDioInterceptor());
  locator.registerSingleton<Dio>(dio);

  locator.registerSingleton<UserRepository>(
    UserRepositoryImpl(),
  );

  locator.registerSingleton<AuthApiService>(
    AuthApiService(locator<Dio>()),
  );



  locator.registerSingleton<ApiRepository>(
    ApiRepositoryImpl(locator<AuthApiService>()),
  );




}
