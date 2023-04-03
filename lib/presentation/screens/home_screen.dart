
import 'package:pawsible/domain/models/auth/auth.dart';
import 'package:pawsible/presentation/widgets/user_info.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../widgets/dept_list_widget.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('應用程式'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.logout,
              //color: Colors.blueGrey,
            ),
            onPressed: () {
              Provider.of<AuthProvider>(context,listen: false).logout();

              // do something
            },
          )
        ],)

      ,
      body:SingleChildScrollView(

        child: Container(
          width: size.width*0.98,
          height: size.height*0.95,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(child: UserInfoWidget(), flex: 2,),
              Flexible(child: DeptListWidget(),flex:4 ,)



            ],
          ),
        ),
      ),
    );
  }
}
