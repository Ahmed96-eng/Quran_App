import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:quran_app/services/ApiRoutes.dart';

// Future<List<QuranModel>> fetchQuran() async {
//   final response = await http.get(ApiRoute.quranApi);
//   print("cccccccccccccccccccccccccccccccccccccc" + response.body);

//   return compute(parseQuran, response.body);
// }

// List<QuranModel> parseQuran(String responseBody) {
//   final parsed = jsonDecode(responseBody)['data'].cast<Map<String, dynamic>>();
//   print('dddddddddddddddd' + parsed);

//   return parsed.map<QuranModel>((json) => QuranModel.fromJson(json)).toList();
// }

Future<QuranModel> fetchQuranModel() async {
  final response = await http.get(ApiRoute.quranApi);
  if (response.statusCode == 200) {
    Map<String, dynamic> map =
        json.decode(response.body).cast<String, dynamic>();
    print(response.body);
    return QuranModel.fromJson(map);
  } else {
    print(response.body);
    throw Exception('Failed to load SingleProductModel');
  }
}

class QuranModel {
  QuranModel({
    this.code,
    this.status,
    this.data,
  });

  int code;
  String status;
  Data data;

  factory QuranModel.fromRawJson(String str) =>
      QuranModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory QuranModel.fromJson(Map<String, dynamic> json) => QuranModel(
        code: json["code"] == null ? "" : json["code"],
        status: json["status"] == null ? "" : json["status"],
        data: json["data"] == null ? "" : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code == null ? "" : code,
        "status": status == null ? "" : status,
        "data": data == null ? "" : data.toJson(),
      };
}

class Data {
  Data({
    this.surahs,
    this.edition,
  });

  List<Surah> surahs;
  Edition edition;

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        surahs: json["surahs"] == null
            ? null
            : List<Surah>.from(json["surahs"].map((x) => Surah.fromJson(x))),
        edition:
            json["edition"] == null ? null : Edition.fromJson(json["edition"]),
      );

  Map<String, dynamic> toJson() => {
        "surahs": surahs == null
            ? null
            : List<dynamic>.from(surahs.map((x) => x.toJson())),
        "edition": edition == null ? null : edition.toJson(),
      };
}

class Edition {
  Edition({
    this.identifier,
    this.language,
    this.name,
    this.englishName,
    this.format,
    this.type,
  });

  String identifier;
  String language;
  String name;
  String englishName;
  String format;
  String type;

  factory Edition.fromRawJson(String str) => Edition.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Edition.fromJson(Map<String, dynamic> json) => Edition(
        identifier: json["identifier"] == null ? null : json["identifier"],
        language: json["language"] == null ? null : json["language"],
        name: json["name"] == null ? null : json["name"],
        englishName: json["englishName"] == null ? null : json["englishName"],
        format: json["format"] == null ? null : json["format"],
        type: json["type"] == null ? null : json["type"],
      );

  Map<String, dynamic> toJson() => {
        "identifier": identifier == null ? null : identifier,
        "language": language == null ? null : language,
        "name": name == null ? null : name,
        "englishName": englishName == null ? null : englishName,
        "format": format == null ? null : format,
        "type": type == null ? null : type,
      };
}

class Surah {
  Surah({
    this.number,
    this.name,
    this.englishName,
    this.englishNameTranslation,
    this.revelationType,
    this.ayahs,
  });

  int number;
  String name;
  String englishName;
  String englishNameTranslation;
  RevelationType revelationType;
  List<Ayah> ayahs;

  factory Surah.fromRawJson(String str) => Surah.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Surah.fromJson(Map<String, dynamic> json) => Surah(
        number: json["number"] == null ? null : json["number"],
        name: json["name"] == null ? null : json["name"],
        englishName: json["englishName"] == null ? null : json["englishName"],
        englishNameTranslation: json["englishNameTranslation"] == null
            ? null
            : json["englishNameTranslation"],
        revelationType: json["revelationType"] == null
            ? null
            : revelationTypeValues.map[json["revelationType"]],
        ayahs: json["ayahs"] == null
            ? null
            : List<Ayah>.from(json["ayahs"].map((x) => Ayah.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "number": number == null ? null : number,
        "name": name == null ? null : name,
        "englishName": englishName == null ? null : englishName,
        "englishNameTranslation":
            englishNameTranslation == null ? null : englishNameTranslation,
        "revelationType": revelationType == null
            ? null
            : revelationTypeValues.reverse[revelationType],
        "ayahs": ayahs == null
            ? null
            : List<dynamic>.from(ayahs.map((x) => x.toJson())),
      };
}

class Ayah {
  Ayah({
    this.number,
    this.audio,
    this.audioSecondary,
    this.text,
    this.numberInSurah,
    this.juz,
    this.manzil,
    this.page,
    this.ruku,
    this.hizbQuarter,
    this.sajda,
  });

  int number;
  String audio;
  List<String> audioSecondary;
  String text;
  int numberInSurah;
  int juz;
  int manzil;
  int page;
  int ruku;
  int hizbQuarter;
  dynamic sajda;

  factory Ayah.fromRawJson(String str) => Ayah.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Ayah.fromJson(Map<String, dynamic> json) => Ayah(
        number: json["number"] == null ? null : json["number"],
        audio: json["audio"] == null ? null : json["audio"],
        audioSecondary: json["audioSecondary"] == null
            ? null
            : List<String>.from(json["audioSecondary"].map((x) => x)),
        text: json["text"] == null ? null : json["text"],
        numberInSurah:
            json["numberInSurah"] == null ? null : json["numberInSurah"],
        juz: json["juz"] == null ? null : json["juz"],
        manzil: json["manzil"] == null ? null : json["manzil"],
        page: json["page"] == null ? null : json["page"],
        ruku: json["ruku"] == null ? null : json["ruku"],
        hizbQuarter: json["hizbQuarter"] == null ? null : json["hizbQuarter"],
        sajda: json["sajda"],
      );

  Map<String, dynamic> toJson() => {
        "number": number == null ? null : number,
        "audio": audio == null ? null : audio,
        "audioSecondary": audioSecondary == null
            ? null
            : List<dynamic>.from(audioSecondary.map((x) => x)),
        "text": text == null ? null : text,
        "numberInSurah": numberInSurah == null ? null : numberInSurah,
        "juz": juz == null ? null : juz,
        "manzil": manzil == null ? null : manzil,
        "page": page == null ? null : page,
        "ruku": ruku == null ? null : ruku,
        "hizbQuarter": hizbQuarter == null ? null : hizbQuarter,
        "sajda": sajda,
      };
}

class SajdaClass {
  SajdaClass({
    this.id,
    this.recommended,
    this.obligatory,
  });

  int id;
  bool recommended;
  bool obligatory;

  factory SajdaClass.fromRawJson(String str) =>
      SajdaClass.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SajdaClass.fromJson(Map<String, dynamic> json) => SajdaClass(
        id: json["id"] == null ? null : json["id"],
        recommended: json["recommended"] == null ? null : json["recommended"],
        obligatory: json["obligatory"] == null ? null : json["obligatory"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "recommended": recommended == null ? null : recommended,
        "obligatory": obligatory == null ? null : obligatory,
      };
}

enum RevelationType { MECCAN, MEDINAN }

final revelationTypeValues = EnumValues(
    {"Meccan": RevelationType.MECCAN, "Medinan": RevelationType.MEDINAN});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
