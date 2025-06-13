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