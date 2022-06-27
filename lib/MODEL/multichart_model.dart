class MultiChart {
  List<Collection>? collection;
  List<VisitData>? visitData;
  List<ServicegroupData>? servicegroupData;
  List<DepartmentData>? departmentData;

  MultiChart(
      {this.collection,
      this.visitData,
      this.servicegroupData,
      this.departmentData});

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
    if (json['servicegroup_data'] != null) {
      servicegroupData = <ServicegroupData>[];
      json['servicegroup_data'].forEach((v) {
        servicegroupData!.add(new ServicegroupData.fromJson(v));
      });
    }
    if (json['department_data'] != null) {
      departmentData = <DepartmentData>[];
      json['department_data'].forEach((v) {
        departmentData!.add(new DepartmentData.fromJson(v));
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
    if (this.servicegroupData != null) {
      data['servicegroup_data'] =
          this.servicegroupData!.map((v) => v.toJson()).toList();
    }
    if (this.departmentData != null) {
      data['department_data'] =
          this.departmentData!.map((v) => v.toJson()).toList();
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
  List<Data3>? data;

  VisitData({this.id, this.data});

  VisitData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['data'] != null) {
      data = <Data3>[];
      json['data'].forEach((v) {
        data!.add(new Data3.fromJson(v));
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

class Data3 {
  String? domain;
  double? measure;
  double? visit_count;
  String? colorCode;

  Data3({this.domain, this.measure, this.visit_count, this.colorCode});

  Data3.fromJson(Map<String, dynamic> json) {
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

class ServicegroupData {
  String? id;
  List<Data1>? data;

  ServicegroupData({this.id, this.data});

  ServicegroupData.fromJson(Map<String, dynamic> json) {
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
  double? serCount;
  String? colorCode;

  Data1({this.domain, this.measure, this.serCount, this.colorCode});

  Data1.fromJson(Map<String, dynamic> json) {
    domain = json['domain'];
    measure = json['measure'].toDouble();
    serCount = json['ser_count'].toDouble();
    colorCode = json['color_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['domain'] = this.domain;
    data['measure'] = this.measure;
    data['ser_count'] = this.serCount;
    data['color_code'] = this.colorCode;
    return data;
  }
}

class DepartmentData {
  String? id;
  List<Data4>? data;

  DepartmentData({this.id, this.data});

  DepartmentData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['data'] != null) {
      data = <Data4>[];
      json['data'].forEach((v) {
        data!.add(new Data4.fromJson(v));
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

class Data4 {
  String? domain;
  double? measure;
  double? billCount;
  String? colorCode;

  Data4({this.domain, this.measure, this.billCount, this.colorCode});

  Data4.fromJson(Map<String, dynamic> json) {
    domain = json['domain'];
    measure = json['measure'].toDouble();
    billCount = json['bill_count'].toDouble();
    colorCode = json['color_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['domain'] = this.domain;
    data['measure'] = this.measure;
    data['bill_count'] = this.billCount;
    data['color_code'] = this.colorCode;
    return data;
  }
}
