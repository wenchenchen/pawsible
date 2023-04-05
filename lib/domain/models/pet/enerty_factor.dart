import 'dart:convert';

EnergyFactors energyFactorsFromJson(String str) => EnergyFactors.fromJson(json.decode(str));

String energyFactorsToJson(EnergyFactors data) => json.encode(data.toJson());

class EnergyFactors {
  EnergyFactors({
    required this.bodytype,
  });

  final List<Bodytype> bodytype;

  factory EnergyFactors.fromJson(Map<String, dynamic> json) => EnergyFactors(
    bodytype: List<Bodytype>.from(json["bodytype"].map((x) => Bodytype.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "bodytype": List<dynamic>.from(bodytype.map((x) => x.toJson())),
  };
}

class Bodytype {
  Bodytype({
    required this.species,
    required this.type,
    required this.factors,
  });

  final String species;
  final String type;
  final List<Factor> factors;

  factory Bodytype.fromJson(Map<String, dynamic> json) => Bodytype(
    species: json["species"],
    type: json["type"],
    factors: List<Factor>.from(json["factors"].map((x) => Factor.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "species": species,
    "type": type,
    "factors": List<dynamic>.from(factors.map((x) => x.toJson())),
  };
}

class Factor {
  Factor({
    required this.title,
    required this.value,
  });

  final String title;
  final double value;

  factory Factor.fromJson(Map<String, dynamic> json) => Factor(
    title: json["title"],
    value: json["value"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "value": value,
  };
}