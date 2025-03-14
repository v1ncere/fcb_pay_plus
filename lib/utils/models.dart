class Province {
  final String code;
  final String name;
  final String regionCode;
  final String islandGroupCode;

  Province(this.code, this.name, this.regionCode, this.islandGroupCode);

  Province.fromJson(Map<String, dynamic> json)
    : code = json['code'] as String,
      name = json['name'] as String,
      regionCode = json['regionCode'] as String,
      islandGroupCode = json['islandGroupCode'] as String;
  
  Map<String, dynamic> toJson() => {
    'code': code,
    'name': name,
    'regionCode': regionCode,
    'islandGroupCode': islandGroupCode
  };
}

class Municipality {
  final String code;
  final String name;
  final String oldName;
  final bool isCapital;
  final dynamic districtCode;
  final String provinceCode;
  final String regionCode;
  final String islandGroupCode;

  Municipality(this.code, this.name, this.oldName, this.isCapital, this.districtCode, this.provinceCode, this.regionCode, this.islandGroupCode);

  Municipality.fromJson(Map<String, dynamic> json)
    : code = json['code'] as String,
      name = json['name'] as String,
      oldName = json['oldName'] as String,
      isCapital = json['isCapital'] as bool,
      districtCode = json['districtCode'] as dynamic,
      provinceCode = json['provinceCode'] as String,
      regionCode = json['regionCode'] as String,
      islandGroupCode = json['islandGroupCode'] as String;
  
  Map<String, dynamic> toJson() => {
    'code': code,
    'name': name,
    'oldName': oldName,
    'isCapital': isCapital,
    'districtCode': districtCode,
    'provinceCode': provinceCode,
    'regionCode': regionCode,
    'islandGroupCode': islandGroupCode
  };
}

class SubMunicipality {
  final String code;
  final String name;
  final String oldName;
  final String districtCode;
  final String provinceCode;
  final String regionCode;
  final String islandGroupCode;

  SubMunicipality(this.code, this.name, this.oldName, this.districtCode, this.provinceCode, this.regionCode, this.islandGroupCode);

  SubMunicipality.fromJson(Map<String, dynamic> json)
    : code = json['code'] as String,
      name = json['name'] as String,
      oldName = json['oldName'] as String,
      districtCode = json['districtCode'] as String,
      provinceCode = json['provinceCode'] as String,
      regionCode = json['regionCode'] as String,
      islandGroupCode = json['islandGroupCode'] as String;
  
  Map<String, dynamic> toJson() => {
    'code': code,
    'name': name,
    'oldName': oldName,
    'districtCode': districtCode,
    'provinceCode': provinceCode,
    'regionCode': regionCode,
    'islandGroupCode': islandGroupCode
  };
}

class City {
  final String code;
  final String name;
  final String oldName;
  final bool isCapital;
  final String districtCode;
  final String provinceCode;
  final String regionCode;
  final String islandGroupCode;

  City(this.code, this.name, this.oldName, this.isCapital, this.districtCode, this.provinceCode, this.regionCode, this.islandGroupCode);

  City.fromJson(Map<String, dynamic> json)
    : code = json['code'] as String,
      name = json['name'] as String,
      oldName = json['oldName'] as String,
      isCapital = json['isCapital'] as bool,
      districtCode = json['districtCode'] as String,
      provinceCode = json['provinceCode'] as String,
      regionCode = json['regionCode'] as String,
      islandGroupCode = json['islandGroupCode'] as String;
  
  Map<String, dynamic> toJson() => {
    'code': code,
    'name': name,
    'oldName': oldName,
    'isCapital': isCapital,
    'districtCode': districtCode,
    'provinceCode': provinceCode,
    'regionCode': regionCode,
    'islandGroupCode': islandGroupCode
  };
}

class CityMunicipality {
  final String code;
  final String name;
  final String oldName;
  final bool isCapital;
  final bool isCity;
  final bool isMunicipality;
  final dynamic districtCode;
  final dynamic provinceCode;
  final String regionCode;
  final String islandGroupCode;

  CityMunicipality(this.code, this.name, this.oldName, this.isCapital, this.districtCode, this.provinceCode, this.regionCode, this.islandGroupCode, this.isCity, this.isMunicipality);

  CityMunicipality.fromJson(Map<String, dynamic> json)
    : code = json['code'] as String,
      name = json['name'] as String,
      oldName = json['oldName'] as String,
      isCapital = json['isCapital'] as bool,
      isCity = json['isCity'] as bool,
      isMunicipality = json['isMunicipality'] as bool,
      districtCode = json['districtCode'] as dynamic,
      provinceCode = json['provinceCode'] as dynamic,
      regionCode = json['regionCode'] as String,
      islandGroupCode = json['islandGroupCode'] as String;
  
  Map<String, dynamic> toJson() => {
    'code': code,
    'name': name,
    'oldName': oldName,
    'isCapital': isCapital,
    'isCity': isCity,
    'isMunicipality': isMunicipality,
    'districtCode': districtCode,
    'provinceCode': provinceCode,
    'regionCode': regionCode,
    'islandGroupCode': islandGroupCode
  };
}

class Barangay {
  final String code;
  final String name;
  final String oldName;
  final dynamic districtCode;
  final dynamic municipalityCode;
  final dynamic subMunicipalityCode;
  final dynamic cityCode;
  final dynamic provinceCode;
  final String regionCode;
  final String islandGroupCode;

  Barangay(this.code, this.name, this.oldName, this.districtCode, this.municipalityCode, this.subMunicipalityCode, this.cityCode, this.provinceCode, this.regionCode, this.islandGroupCode);

  Barangay.fromJson(Map<String, dynamic> json)
    : code = json['code'] as String,
      name = json['name'] as String,
      oldName = json['oldName'] as String,
      subMunicipalityCode = json['subMunicipalityCode'] as dynamic,
      cityCode = json['cityCode'] as dynamic,
      municipalityCode = json['municipalityCode'] as dynamic,
      districtCode = json['districtCode'] as dynamic,
      provinceCode = json['provinceCode'] as dynamic,
      regionCode = json['regionCode'] as String,
      islandGroupCode = json['islandGroupCode'] as String;
  
  Map<String, dynamic> toJson() => {
    'code': code,
    'name': name,
    'oldName': oldName,
    'subMunicipalityCode': subMunicipalityCode,
    'cityCode': cityCode,
    'municipalityCode': municipalityCode,
    'districtCode': districtCode,
    'provinceCode': provinceCode,
    'regionCode': regionCode,
    'islandGroupCode': islandGroupCode
  };
}