import 'package:flutter/material.dart';

class EnergySourceSettingCard extends StatefulWidget {
  const EnergySourceSettingCard({Key? key}) : super(key: key);

  @override
  State<EnergySourceSettingCard> createState() => _EnergySourceSettingCardState();
}

class _EnergySourceSettingCardState extends State<EnergySourceSettingCard> {
  //能量分布
  RangeValues energySource = RangeValues(33, 66); //能量來源

  TextEditingController controllerProtein = TextEditingController(); //蛋白質
  TextEditingController controllerCarb = TextEditingController(); //碳水
  TextEditingController controllerFat = TextEditingController(); //脂肪


  @override
  Widget build(BuildContext context) {

    controllerProtein.text = energySource.start.round().toString();
    controllerFat.text = (100 - energySource.end.round()).toString();
    controllerCarb.text =
        (energySource.end.round() - energySource.start.round()).toString();

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),

      elevation: 8.0,
      child: Container(
        margin: EdgeInsets.all(10),
        child: Column(

          children: [
            const Text('能量來源比例'),
            const SizedBox(
              height: 10,
            ),

            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                //activeTrackColor: Colors.purpleAccent, // set the color of the active part of the slider bar
                //inactiveTrackColor: Colors.red, // set the color of the inactive part of the slider bar
                //thumbColor: Colors.green,

                thumbShape: const RoundSliderThumbShape(
                  enabledThumbRadius:
                  10.0, // set the size of the thumb dot
                ),
              ),
              child: RangeSlider(
                  values: energySource,
                  min: 0.0,
                  max: 100.0,
                  divisions: 100,
                  labels: RangeLabels(
                    '蛋白質${energySource.start.round()}%',
                    '脂肪${100 - energySource.end.round()}%',
                  ),
                  onChanged: (values) {
                    setState(() {
                      values.start.round();
                      values.end.round();
                      energySource = values;
                      //print(energySource);
                    });
                  }),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 100,
                  child: TextFormField(
                    controller: controllerProtein,
                    //initialValue: energySource.start.toString(),
                    decoration:
                    const InputDecoration(labelText: '蛋白質'),
                    keyboardType: TextInputType.none,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '蛋白質比例錯誤';
                      }
                      return null;
                    },
                    onSaved: (value) {},
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: TextFormField(
                    controller: controllerCarb,
                    //initialValue: (100-energySource.end).toString(),
                    decoration:
                    const InputDecoration(labelText: '碳水化合物'),
                    keyboardType: TextInputType.none,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '碳水化合物比例錯誤';
                      }
                      return null;
                    },
                    onSaved: (value) {},
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: TextFormField(
                    controller: controllerFat,
                    //initialValue: energySource.end.toString(),
                    decoration:
                    const InputDecoration(labelText: '脂肪'),
                    keyboardType: TextInputType.none,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '脂肪比例錯誤';
                      }
                      return null;
                    },
                    onSaved: (value) {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
