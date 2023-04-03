import 'package:pawsible/domain/models/auth/auth.dart';
import 'package:pawsible/domain/models/auth/auth_request.dart';

import 'package:pawsible/domain/models/auth/auth_response.dart';

import 'package:pawsible/utils/resources/data_state.dart';

import '../../domain/contracts/api_repository.dart';
import '../../domain/models/dept/dept_response.dart';
import '../datasources/remote/authapi_service.dart';
import 'base/base_api_repository.dart';

class ApiRepositoryImpl extends BaseApiRepository implements ApiRepository{

  final AuthApiService _AuthApiService;

  ApiRepositoryImpl(this._AuthApiService);
  
  @override
  Future<DataState<LoginResponse>> login({required LoginRequest request}) {
    // TODO: implement login
    return getStateOf(request:()=>_AuthApiService.login(request));

  }

  @override
  Future<DataState<LoginResponse>> refreshToken({required Auth request}) {
    // TODO: implement refreshToken
    return getStateOf(request:()=>_AuthApiService.refreshToken(request));
  }

  Future<DataState<DeptResponse>> getAllDept({required String token}) {
    // TODO: implement refreshToken
    return getStateOf(request:()=>_AuthApiService.getAllDept(token));
  }


}