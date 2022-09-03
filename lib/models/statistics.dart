import 'dart:convert';
Statistics statisticsFromJson(String str) => Statistics.fromJson(json.decode(str));
String statisticsToJson(Statistics data) => json.encode(data.toJson());
class Statistics {
  Statistics({
      this.id, 
      this.downloads, 
      this.views, 
      this.likes,});

  Statistics.fromJson(dynamic json) {
    id = json['id'];
    downloads = json['downloads'] != null ? Downloads.fromJson(json['downloads']) : null;
    views = json['views'] != null ? Views.fromJson(json['views']) : null;
    likes = json['likes'] != null ? Likes.fromJson(json['likes']) : null;
  }
  String? id;
  Downloads? downloads;
  Views? views;
  Likes? likes;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    if (downloads != null) {
      map['downloads'] = downloads?.toJson();
    }
    if (views != null) {
      map['views'] = views?.toJson();
    }
    if (likes != null) {
      map['likes'] = likes?.toJson();
    }
    return map;
  }

}

Likes likesFromJson(String str) => Likes.fromJson(json.decode(str));
String likesToJson(Likes data) => json.encode(data.toJson());
class Likes {
  Likes({
      this.total, 
      this.historical,});

  Likes.fromJson(dynamic json) {
    total = json['total'];
    historical = json['historical'] != null ? Historical.fromJson(json['historical']) : null;
  }
  int? total;
  Historical? historical;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total'] = total;
    if (historical != null) {
      map['historical'] = historical?.toJson();
    }
    return map;
  }

}

Historical historicalFromJson(String str) => Historical.fromJson(json.decode(str));
String historicalToJson(Historical data) => json.encode(data.toJson());
class Historical {
  Historical({
      this.change, 
      this.resolution, 
      this.quantity, 
      this.values,});

  Historical.fromJson(dynamic json) {
    change = json['change'];
    resolution = json['resolution'];
    quantity = json['quantity'];
    if (json['values'] != null) {
      values = [];
      json['values'].forEach((v) {
        values?.add(Values.fromJson(v));
      });
    }
  }
  int? change;
  String? resolution;
  int? quantity;
  List<Values>? values;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['change'] = change;
    map['resolution'] = resolution;
    map['quantity'] = quantity;
    if (values != null) {
      map['values'] = values?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

Values valuesFromJson(String str) => Values.fromJson(json.decode(str));
String valuesToJson(Values data) => json.encode(data.toJson());
class Values {
  Values({
      this.date, 
      this.value,});

  Values.fromJson(dynamic json) {
    date = json['date'];
    value = json['value'];
  }
  String? date;
  int? value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['date'] = date;
    map['value'] = value;
    return map;
  }

}

Views viewsFromJson(String str) => Views.fromJson(json.decode(str));
String viewsToJson(Views data) => json.encode(data.toJson());
class Views {
  Views({
      this.total, 
      this.historical,});

  Views.fromJson(dynamic json) {
    total = json['total'];
    historical = json['historical'] != null ? Historical.fromJson(json['historical']) : null;
  }
  int? total;
  Historical? historical;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total'] = total;
    if (historical != null) {
      map['historical'] = historical?.toJson();
    }
    return map;
  }

}

Downloads downloadsFromJson(String str) => Downloads.fromJson(json.decode(str));
String downloadsToJson(Downloads data) => json.encode(data.toJson());
class Downloads {
  Downloads({
      this.total, 
      this.historical,});

  Downloads.fromJson(dynamic json) {
    total = json['total'];
    historical = json['historical'] != null ? Historical.fromJson(json['historical']) : null;
  }
  int? total;
  Historical? historical;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total'] = total;
    if (historical != null) {
      map['historical'] = historical?.toJson();
    }
    return map;
  }

}
