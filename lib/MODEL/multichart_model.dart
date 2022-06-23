class MultiChart {
  List<Collection>? collection;

  MultiChart({this.collection});

  MultiChart.fromJson(Map<String, dynamic> json) {
    if (json['collection'] != null) {
      collection = <Collection>[];
      json['collection'].forEach((v) {
        collection!.add(new Collection.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.collection != null) {
      data['collection'] = this.collection!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Collection {
  String? id;
  List<Data>? data;

  Collection({this.id, this.data});

  Collection.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? domain;
  double? measure;
  String? colorCode;

  Data({this.domain, this.measure, this.colorCode});

  Data.fromJson(Map<String, dynamic> json) {
    domain = json['domain'];
    measure = json['measure'];
    colorCode = json['color_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['domain'] = this.domain;
    data['measure'] = this.measure;
    data['color_code'] = this.colorCode;
    return data;
  }
}
