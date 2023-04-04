import 'package:tv/model/Newrelease.dart';

import 'Results.dart';

class Sidesection {
  Sidesection({
      this.page, 
      this.results, 
      this.totalPages, 
      this.totalResults,
    this.newrelease,

  });

  Sidesection.fromJson(dynamic json) {
    page = json['page'];

    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results?.add(Results.fromJson(v));
      });
    }
    if (json['newrelease'] != null) {
      newrelease = [];
      json['newrelease'].forEach((v) {
        newrelease?.add(Newrelease.fromJson(v));
      });
    }

    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }
  num? page;
  List<Results>? results;
  num? totalPages;
  num? totalResults;
List<Newrelease>? newrelease;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['page'] = page;
    if (results != null) {
      map['results'] = results?.map((v) => v.toJson()).toList();
    }
    if (newrelease != null) {
      map['newrelease'] = newrelease?.map((v) => v.toJson()).toList();
    }

    map['total_pages'] = totalPages;
    map['total_results'] = totalResults;
    return map;
  }

}