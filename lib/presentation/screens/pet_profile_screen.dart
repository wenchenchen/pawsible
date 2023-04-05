import 'package:flutter/material.dart';
import 'package:pawsible/domain/models/pet/pet_profile.dart';

import '../widgets/pet_profile_body_card.dart';
import '../widgets/pet_profile_energy_source_card.dart';

class PetProfileScreen extends StatefulWidget {
  const PetProfileScreen({Key? key}) : super(key: key);

  @override
  State<PetProfileScreen> createState() => _PetProfileScreenState();
}

class _PetProfileScreenState extends State<PetProfileScreen> {
  final GlobalKey<FormState> formKey = GlobalKey();








  Future<void> _submit() async {
    if (!formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    formKey.currentState!.save();
    setState(() {
      //_isLoading = true;
    });
  }



  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;



    return Scaffold(
        appBar: AppBar(
          title: const Text('請輸入寵物資料'),
        ),
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Container(
                padding: const EdgeInsets.all(10),
                width: deviceSize.width * 1,
                height: deviceSize.height,
                alignment: Alignment.topCenter,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      BodyConditionCard(),
                      SizedBox(height:10),
                      EnergySourceSettingCard(),
                      SizedBox(height:10),
                      ElevatedButton(
                          onPressed: () {
                            _submit();
                          },
                          child: const Text('下一步')),
                    ])),
          ),
        ));
  }
}
