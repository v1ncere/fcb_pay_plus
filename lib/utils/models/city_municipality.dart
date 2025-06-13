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