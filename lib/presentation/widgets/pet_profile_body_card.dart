import 'dart:math';

import 'package:flutter/material.dart';

import '../../domain/models/pet/pet_profile.dart';
import '../../utils/constants/numbers.dart';

class BodyConditionCard extends StatefulWidget {
  const BodyConditionCard({Key? key}) : super(key: key);

  @override
  State<BodyConditionCard> createState() => _BodyConditionCardState();
}

class _BodyConditionCardState extends State<BodyConditionCard> {
  final GlobalKey<FormState> formKey = GlobalKey();

  TextEditingController controllerWeight = TextEditingController();
  TextEditingController controllerDER = TextEditingController();
  TextEditingController controllerRER = TextEditingController();
  double weight = 0; //體重
  String preWeight = '';
  Species species = Species.dog; //物種
  Species _selectedOptionSpecies = Species.dog; //物種

  //影響因子 預設是狗 1.6
  int? _selctedFactorId = 1;
  double factor = 1.6;

  double rer = 0;
  double der = 0;

  void _calEnergyReq() {

    weight=double.tryParse(controllerWeight.text)??0;
    switch (species) {
      case Species.dog:
        rer = 70.0 * pow(weight, MW_COEEFICIENT_DOG);
        break;
      case Species.cat:
        rer = 70.0 * pow(weight, MW_COEEFICIENT_CAT);
        break;
    }

    der = rer * factor;
    controllerRER.text = rer.round().toString();
    controllerDER.text = der.round().toString();
    print('der${der}');
    print('weight${weight}');
    print('factor${factor}');
    print('preWeight${preWeight}');
  }

  //改變物種選擇
  void _onOptionSpeciesChanged(Species value) {
    setState(() {
      _selectedOptionSpecies = value;
      species = value;
      _selctedFactorId = 1;
      factor = 1.6;
      _calEnergyReq();
    });
  }

  @override
  Widget build(BuildContext context) {


    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 8.0,
      child: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            ToggleButtons(
              borderRadius: BorderRadius.circular(15.0),
              onPressed: (index) {
                _onOptionSpeciesChanged(index == 0 ? Species.dog : Species.cat);
              },
              isSelected: [
                _selectedOptionSpecies == Species.dog,
                _selectedOptionSpecies == Species.cat,
              ],
              children: const [
                Row(
                  children: [
                    ImageIcon(AssetImage("assets/icons/dog.png")),
                    Text('犬'),
                  ],
                ),
                Row(
                  children: [
                    ImageIcon(AssetImage("assets/icons/cat.png")),
                    Text('貓'),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: controllerWeight,
              //initialValue: weight==null ? '' : weight.toString(),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: '請輸入體重(Kg)',
                  labelStyle: const TextStyle(color: Colors.green),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0))),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '請輸入體重';
                } else if (num.tryParse(value) == null) {
                  return '請輸入數字';
                } else if (num.tryParse(value)! <= 0) {
                  return '請輸入正數';
                }
                return null;
              },

              onChanged: (value) {

                  setState(() {
                    _calEnergyReq();
                  });



                //calEnergyReq();
              },
            ),
            const SizedBox(height: 20),
            InputDecorator(
              decoration: InputDecoration(
                  labelText: '請選擇生理與活動狀態',
                  labelStyle: const TextStyle(
                    color: Colors.green,
                  ),
                  errorStyle: const TextStyle(color: Colors.redAccent),
                  hintText: '狗狗生理狀態',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0))),
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  isDense: true,
                  value: _selctedFactorId,
                  items: ((_selectedOptionSpecies == Species.dog)
                          ? dogActFactors
                          : catActFactors)
                      .map<DropdownMenuItem<int>>((ActivityFactor factor) {
                    return DropdownMenuItem<int>(
                        enabled: (factor.value == null) ? false : true,
                        value: factor.Id,
                        child: (factor.value == null)
                            ? Row(
                                children: [
                                  const Icon(
                                    Icons.pets,
                                    color: Colors.grey,
                                  ),
                                  Text(factor.title,
                                      style:
                                          const TextStyle(color: Colors.grey)),
                                ],
                              )
                            : Text(
                                ' ${factor.title} ${factor.value}',
                              ));
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selctedFactorId = value!;
                      factor = ((_selectedOptionSpecies == Species.dog)
                              ? dogActFactors
                              : catActFactors)
                          .firstWhere((q) => q.Id == value)
                          .value!;
                      //calEnergyReq();
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            InputDecorator(
                decoration: InputDecoration(
                    labelText: '每日靜止熱量需求(Kcal/Day)',
                    labelStyle: const TextStyle(
                      color: Colors.grey,
                    ),
                    errorStyle: const TextStyle(color: Colors.redAccent),
                    hintText: '狗狗生理狀態',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0))),
                child: Text(rer.round().toString())),
            // TextFormField(
            //   readOnly: true,
            //   controller: controllerRER,
            //   keyboardType: TextInputType.number,
            //   decoration: InputDecoration(
            //       labelText: '靜止能量需求(Kcal/Day)',
            //       border: OutlineInputBorder(
            //           borderRadius:BorderRadius.circular(30.0)
            //       )
            //   )
            //
            //
            // ),
            const SizedBox(height: 20),
            TextFormField(
              controller: controllerDER,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: '每日熱量需求(Kcal/Day)',
                  labelStyle: new TextStyle(color: Colors.green),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0))),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '請輸入每日能量需求';
                } else if (num.tryParse(value) == null) {
                  return '請輸入數字';
                } else if (num.tryParse(value)! <= 0) {
                  return '請輸入正數';
                }
                return null;
              },
              onSaved: (value) {
                if (value != null) weight = double.parse(value);
              },
            )
          ],
        ),
      ),
    );
  }
}
