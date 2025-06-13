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