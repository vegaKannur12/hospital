class MultiChart {
  List<Collection>? collection;
  List<VisitData>? visitData;

  MultiChart({this.collection, this.visitData});

  MultiChart.fromJson(Map<String, dynamic> json) {
    if (json['collection'] != null) {
      collection = <Collection>[];
      json['collection'].forEach((v) {
        collection!.add(new Collection.fromJson(v));
      });
    }
    if (json['visit_data'] != null) {
      visitData = <VisitData>[];
      json['visit_data'].forEach((v) {
        visitData!.add(new VisitData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.collection != null) {
      data['collection'] = this.collection!.map((v) => v.toJson()).toList();
    }
    if (this.visitData != null) {
      data['visit_data'] = this.visitData!.map((v) => v.toJson()).toList();
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
    measure = json['measure'].toDouble();
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

class VisitData {
  String? id;
  List<Data1>? data;

  VisitData({this.id, this.data});

  VisitData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['data'] != null) {
      data = <Data1>[];
      json['data'].forEach((v) {
        data!.add(new Data1.fromJson(v));
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

class Data1 {
  String? domain;
  double? measure;
  double? visit_count;
  String? colorCode;

  Data1({this.domain, this.measure, this.visit_count, this.colorCode});

  Data1.fromJson(Map<String, dynamic> json) {
    domain = json['domain'];
    measure = json['measure'].toDouble();
    visit_count = json['visit_count'].toDouble();
    colorCode = json['color_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['domain'] = this.domain;
    data['measure'] = this.measure;
    data['visit_count'] = this.visit_count;
    data['color_code'] = this.colorCode;
    return data;
  }
}