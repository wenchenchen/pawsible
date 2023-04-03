
import 'dart:core';
import 'dart:math';

//活動程度
Map<ActivityFactorName, num> activityFactor={
  ActivityFactorName.low:1.2,
  ActivityFactorName.medium:1.6,
  ActivityFactorName.high:1.8
};

enum ActivityFactorName{
  low,
  medium,
  high
}

//物種
enum Species{
  dog,
  cat,
  human
}

//特殊狀態
enum SpecialCondition{
  healthAdault,     //健康成犬
  puppy,           //小狗
  overWeight,  //過重
  pregnant,         //懷孕
  workDog           //工作犬
}

//寵物的基本訊息
class PetProfile{
  final num weight;     //體重
  final num neutered ; //是否絕育
  final Species species; //犬或貓
  final num activityFactor;    //是否有特殊狀態
  num get restEnergyRequirement => 70*pow(weight,0.75);   //靜止所需能量
  num get defaultDER => activityFactor*restEnergyRequirement;  //預設每日所需能量
  late num dailyEnergyRequirement;   //使用者可輸入的預設資訊

  PetProfile(this.weight,this.neutered,this.species,this.activityFactor){
    dailyEnergyRequirement=defaultDER;
  }

}