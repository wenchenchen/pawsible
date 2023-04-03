import 'package:pawsible/domain/contracts/user_repository.dart';
import 'package:pawsible/domain/models/auth/auth_response.dart';
//import 'package:dio/dio.dart' hide Headers;
import 'package:dio/dio.dart' hide Headers;

import 'package:retrofit/retrofit.dart';
import '../../../domain/models/auth/auth.dart';
import '../../../domain/models/auth/auth_request.dart';
import '../../../domain/models/dept/dept_response.dart';
import '../../../utils/constants/strings.dart';
import '../../../utils/locator.dart';

//flutter pub run build_runner build
part 'authapi_service.g.dart';

@RestApi(baseUrl: baseUrl, parser: Parser.JsonSerializable)
abstract class AuthApiService {

  factory AuthApiService(Dio dio, {String baseUrl}) = _AuthApiService;

  @POST('/auth/login')

  Future<HttpResponse<LoginResponse>> login(@Body() LoginRequest loginRequest );

  @POST('/auth/refreshtoken')
  Future<HttpResponse<LoginResponse>> refreshToken(@Body() Auth auth );


  @GET("/dept/getAll")
  @Headers(<String, dynamic>{
    'Content-Type': 'application/json',
    'Accept': 'application/json'
  })
  Future<HttpResponse<DeptResponse>> getAllDept(@Header("Authorization") String token);

}