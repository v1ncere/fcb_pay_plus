import 'dart:convert';

class Country {
  final String name;
  final List<String> topLevelDomain;
  final String alpha2Code;
  final String alpha3Code;
  final List<String> callingCodes;
  final String? capital;
  final List<String> altSpellings;
  final String? subregion;
  final String? region;
  final int? population;
  final List<double>? latlng;
  final String? demonym;
  final double? area;
  final List<String> timezones;
  final List<String>? borders;
  final String? nativeName;
  final String? numericCode;
  final Flags? flags;
  final List<Currency> currencies;
  final List<Language> languages;
  final Translations? translations;
  final String? flag;
  final List<RegionalBloc> regionalBlocs;
  final String? cioc;
  final bool? independent;

  Country({
    required this.name,
    required this.topLevelDomain,
    required this.alpha2Code,
    required this.alpha3Code,
    required this.callingCodes,
    this.capital,
    required this.altSpellings,
    this.subregion,
    this.region,
    this.population,
    this.latlng,
    this.demonym,
    this.area,
    required this.timezones,
    this.borders,
    this.nativeName,
    this.numericCode,
    this.flags,
    required this.currencies,
    required this.languages,
    this.translations,
    this.flag,
    required this.regionalBlocs,
    this.cioc,
    this.independent,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json['name'],
      topLevelDomain: List<String>.from(json['topLevelDomain'] ?? []),
      alpha2Code: json['alpha2Code'],
      alpha3Code: json['alpha3Code'],
      callingCodes: List<String>.from(json['callingCodes'] ?? []),
      capital: json['capital'],
      altSpellings: List<String>.from(json['altSpellings'] ?? []),
      subregion: json['subregion'],
      region: json['region'],
      population: json['population'],
      latlng: json['latlng'] != null
          ? List<double>.from(json['latlng'].map((x) => x.toDouble()))
          : null,
      demonym: json['demonym'],
      area: json['area'] != null ? (json['area'] as num).toDouble() : null,
      timezones: List<String>.from(json['timezones'] ?? []),
      borders: json['borders'] != null
          ? List<String>.from(json['borders'])
          : null,
      nativeName: json['nativeName'],
      numericCode: json['numericCode'],
      flags: json['flags'] != null ? Flags.fromJson(json['flags']) : null,
      currencies: (json['currencies'] as List<dynamic>?)
              ?.map((e) => Currency.fromJson(e))
              .toList() ??
          [],
      languages: (json['languages'] as List<dynamic>?)
              ?.map((e) => Language.fromJson(e))
              .toList() ??
          [],
      translations: json['translations'] != null
          ? Translations.fromJson(json['translations'])
          : null,
      flag: json['flag'],
      regionalBlocs: (json['regionalBlocs'] as List<dynamic>?)
              ?.map((e) => RegionalBloc.fromJson(e))
              .toList() ??
          [],
      cioc: json['cioc'],
      independent: json['independent'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'topLevelDomain': topLevelDomain,
      'alpha2Code': alpha2Code,
      'alpha3Code': alpha3Code,
      'callingCodes': callingCodes,
      'capital': capital,
      'altSpellings': altSpellings,
      'subregion': subregion,
      'region': region,
      'population': population,
      'latlng': latlng,
      'demonym': demonym,
      'area': area,
      'timezones': timezones,
      'borders': borders,
      'nativeName': nativeName,
      'numericCode': numericCode,
      'flags': flags?.toJson(),
      'currencies': currencies.map((e) => e.toJson()).toList(),
      'languages': languages.map((e) => e.toJson()).toList(),
      'translations': translations?.toJson(),
      'flag': flag,
      'regionalBlocs': regionalBlocs.map((e) => e.toJson()).toList(),
      'cioc': cioc,
      'independent': independent,
    };
  }
}

class Flags {
  final String? svg;
  final String? png;

  Flags({this.svg, this.png});

  factory Flags.fromJson(Map<String, dynamic> json) {
    return Flags(svg: json['svg'], png: json['png']);
  }

  Map<String, dynamic> toJson() => {
    'svg': svg,
    'png': png,
  };
}

class Currency {
  final String? code;
  final String? name;
  final String? symbol;

  Currency({this.code, this.name, this.symbol});

  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(
      code: json['code'],
      name: json['name'],
      symbol: json['symbol'],
    );
  }

  Map<String, dynamic> toJson() => {
    'code': code,
    'name': name,
    'symbol': symbol,
  };
}

class Language {
  final String? iso639_1;
  final String? iso639_2;
  final String? name;
  final String? nativeName;

  Language({this.iso639_1, this.iso639_2, this.name, this.nativeName});

  factory Language.fromJson(Map<String, dynamic> json) {
    return Language(
      iso639_1: json['iso639_1'],
      iso639_2: json['iso639_2'],
      name: json['name'],
      nativeName: json['nativeName'],
    );
  }

  Map<String, dynamic> toJson() => {
    'iso639_1': iso639_1,
    'iso639_2': iso639_2,
    'name': name,
    'nativeName': nativeName,
  };
}

class Translations {
  final Map<String, String> values;

  Translations({required this.values});

  factory Translations.fromJson(Map<String, dynamic> json) {
    return Translations(
      values: json.map((key, value) => MapEntry(key, value.toString())),
    );
  }

  Map<String, dynamic> toJson() => values;
}

class RegionalBloc {
  final String? acronym;
  final String? name;

  RegionalBloc({this.acronym, this.name});

  factory RegionalBloc.fromJson(Map<String, dynamic> json) {
    return RegionalBloc(
      acronym: json['acronym'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() => {
    'acronym': acronym,
    'name': name,
  };
}

/// Helper to parse a list of countries
List<Country> countryListFromJson(String str) => List<Country>.from(json.decode(str).map((x) => Country.fromJson(x)));

String countryListToJson(List<Country> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
