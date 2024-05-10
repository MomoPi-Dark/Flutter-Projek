// To parse this JSON data, do
//
//     final profileBuilder = profileBuilderFromJson(jsonString);

import 'dart:convert';

ProfileBuilder profileBuilderFromJson(String str) =>
    ProfileBuilder.fromJson(json.decode(str));

String profileBuilderToJson(ProfileBuilder data) => json.encode(data.toJson());

class ProfileBuilder {
  String name;
  String nim;
  String kelas;
  String fakultas;

  ProfileBuilder({
    required this.name,
    required this.nim,
    required this.kelas,
    required this.fakultas,
  });

  factory ProfileBuilder.fromJson(Map<String, dynamic> json) => ProfileBuilder(
        name: json["name"],
        nim: json["nim"],
        kelas: json["kelas"],
        fakultas: json["fakultas"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "nim": nim,
        "kelas": kelas,
        "fakultas": fakultas,
      };
}
