import 'package:pawsible/domain/contracts/api_repository.dart';

import 'package:flutter/material.dart';


import '../../domain/contracts/user_repository.dart';
import '../../domain/models/dept/dept.dart';
import '../../domain/models/dept/dept_response.dart';
import '../../utils/locator.dart';
import '../../utils/resources/data_state.dart';

class DeptListWidget extends StatelessWidget {
  const DeptListWidget({Key? key}) : super(key: key);


  Future<List<Dept>?> fetchDepts() async {

    UserRepository _userRepository =locator<UserRepository>();

    String? token=await _userRepository.getToken();
    print('ok3');
    print('token:= ${token}');

    ApiRepository _apiRepository =locator<ApiRepository>();



    final DataState<DeptResponse> response = await _apiRepository.getAllDept(token:'Bearer '+(token??''));
    print(response.toString());
    print('Bearer '+(token??''));
    if (response is DataSuccess) {
      if (response.data?.status==1){
        print('hi1');
        print('data:= ${response.data?.data}');
        return response.data?.data;

      }else{
        print('hi2');
        throw UnimplementedError();
      }

    }else if (response is DataFailed) {
      print('hi3');
      print(response.data);
      throw UnimplementedError();
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: FutureBuilder(
        future: fetchDepts(),
        builder: (context, snapshot){
          if (snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data![index].name),
                );
              },
            );
          }else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          // By default, show a loading spinner.
          return const CircularProgressIndicator();

        }
      ),


    );
  }
}
