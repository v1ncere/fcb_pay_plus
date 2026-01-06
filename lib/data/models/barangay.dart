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