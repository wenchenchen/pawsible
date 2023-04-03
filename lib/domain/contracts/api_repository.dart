

import '../../utils/resources/data_state.dart';
import '../models/auth/auth.dart';
import '../models/auth/auth_request.dart';
import '../models/auth/auth_response.dart';
import '../models/dept/dept_response.dart';

abstract class ApiRepository{

  Future<DataState<LoginResponse>> login({
    required LoginRequest request,
  });

  Future<DataState<LoginResponse>> refreshToken({
    required Auth request,
  });


  Future<DataState<DeptResponse>> getAllDept({
    required String token,
  });
}