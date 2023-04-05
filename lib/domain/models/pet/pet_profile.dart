
import 'dart:core';
import 'dart:math';

import 'package:flutter/material.dart';

//物種
enum Species{
  dog,
  cat,
  human
}


//生理狀態
enum BodyConditionType{
  dogAdult,
  dogOld,
  dogOverWeight,
  dogWork,
  dogPuppy,
  dogPregnant
}



//活動程度
class ActivityFactor{
  final int Id;
  final Species species;
  final BodyConditionType bodyConditionType;
  final String title;
  final double? value;
  final String? description;
  const ActivityFactor( this.Id,this.species,this.bodyConditionType,this.title,this.value,this.description);
}

List<ActivityFactor> dogActFactors=[

  const ActivityFactor(0,Species.dog,BodyConditionType.dogAdult,"一般成年犬", null, null),
  const ActivityFactor(1,Species.dog,BodyConditionType.dogAdult,"成犬(已絕育)", 1.6, null),
  const ActivityFactor(2,Species.dog,BodyConditionType.dogAdult,"成犬(未絕育)", 1.8, null),

  const ActivityFactor(4,Species.dog,BodyConditionType.dogAdult,"中老年犬", null, null),
  const ActivityFactor(5,Species.dog,BodyConditionType.dogAdult,"活動量中等", 1.4, null),
  const ActivityFactor(6,Species.dog,BodyConditionType.dogAdult,"活動量低", 1.2, null),

  const ActivityFactor(7,Species.dog,BodyConditionType.dogOverWeight,"減肥犬", null, null),
  const ActivityFactor(8,Species.dog,BodyConditionType.dogOverWeight,"輕等強度減肥", 1.4, null),
  const ActivityFactor(9,Species.dog,BodyConditionType.dogOverWeight,"中等強度減肥", 1.2, null),
  const ActivityFactor(10,Species.dog,BodyConditionType.dogOverWeight,"劇烈強度減肥", 1, null),
];

List<ActivityFactor> catActFactors=[

  const ActivityFactor(0,Species.dog,BodyConditionType.dogAdult,"一般成年貓", null, null),
  const ActivityFactor(1,Species.dog,BodyConditionType.dogAdult,"成貓(已絕育)", 1.6, null),
  const ActivityFactor(2,Species.dog,BodyConditionType.dogAdult,"成貓(未絕育)", 1.8, null),

  const ActivityFactor(4,Species.dog,BodyConditionType.dogAdult,"中老年貓", null, null),
  const ActivityFactor(5,Species.dog,BodyConditionType.dogAdult,"活動量中等", 1.4, null),
  const ActivityFactor(6,Species.dog,BodyConditionType.dogAdult,"活動量低", 1.2, null),

  const ActivityFactor(7,Species.dog,BodyConditionType.dogOverWeight,"減肥貓", null, null),
  const ActivityFactor(8,Species.dog,BodyConditionType.dogOverWeight,"輕等強度減肥", 1.4, null),
  const ActivityFactor(9,Species.dog,BodyConditionType.dogOverWeight,"中等強度減肥", 1.2, null),
  const ActivityFactor(10,Species.dog,BodyConditionType.dogOverWeight,"劇烈強度減肥", 1, null),

];





//寵物的基本訊息
class PetProfile {
  Species species;
  double weight;                       //體重
  bool neutered ;                    //是否絕育
                 //犬或貓
  final ActivityFactor activityFactor;    //活動狀態

  num get restEnergyRequirement => 70*pow(weight,0.75);   //靜止所需能量
  num get defaultDER => activityFactor.value??0*restEnergyRequirement;  //預設每日所需能量
  late num dailyEnergyRequirement;   //使用者可輸入的預設資訊

  PetProfile(this.weight,this.neutered,this.activityFactor,this.species,){
    dailyEnergyRequirement=defaultDER;
  }

  PetProfile.dog(double weight,bool neutered,ActivityFactor activityFactor): this(weight,neutered,activityFactor,Species.dog);

  PetProfile.cat(double weight,bool neutered,ActivityFactor activityFactor): this(weight,neutered,activityFactor,Species.cat);



}