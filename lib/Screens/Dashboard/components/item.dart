import 'dart:convert';

List<ItemBuilder> itemBuilderFromJson(String str) => List<ItemBuilder>.from(
    json.decode(str).map((x) => ItemBuilder.fromJson(x)));

String itemBuilderToJson(List<ItemBuilder> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ItemBuilder {
  String title;
  String date;
  String timeFirst;
  String timeEnd;

  ItemBuilder({
    required this.title,
    required this.date,
    required this.timeFirst,
    required this.timeEnd,
  });

  factory ItemBuilder.fromJson(Map<String, dynamic> json) => ItemBuilder(
        title: json["title"],
        date: json["date"],
        timeFirst: json["timeFirst"],
        timeEnd: json["timeEnd"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "date": date,
        "timeFirst": timeFirst,
        "timeEnd": timeEnd
      };
}
