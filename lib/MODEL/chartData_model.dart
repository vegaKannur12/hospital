class ChartData {
  List<CollectionData>? collectionData;
  List<CountData>? countData;
  List<VisitData>? visitData;
  List<DepartmentData>? departmentData;
  List<ServicegroupData>? servicegroupData;

  ChartData(
      {this.collectionData,
      this.countData,
      this.visitData,
      this.departmentData,
      this.servicegroupData});

  ChartData.fromJson(Map<String, dynamic> json) {
    if (json['collection_data'] != null) {
      collectionData = <CollectionData>[];
      json['collection_data'].forEach((v) {
        collectionData!.add(new CollectionData.fromJson(v));
      });
    }
    if (json['count_data'] != null) {
      countData = <CountData>[];
      json['count_data'].forEach((v) {
        countData!.add(new CountData.fromJson(v));
      });
    }
    if (json['visit_data'] != null) {
      visitData = <VisitData>[];
      json['visit_data'].forEach((v) {
        visitData!.add(new VisitData.fromJson(v));
      });
    }
    if (json['department_data'] != null) {
      departmentData = <DepartmentData>[];
      json['department_data'].forEach((v) {
        departmentData!.add(new DepartmentData.fromJson(v));
      });
    }
    if (json['servicegroup_data'] != null) {
      servicegroupData = <ServicegroupData>[];
      json['servicegroup_data'].forEach((v) {
        servicegroupData!.add(new ServicegroupData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.collectionData != null) {
      data['collection_data'] =
          this.collectionData!.map((v) => v.toJson()).toList();
    }
    if (this.countData != null) {
      data['count_data'] = this.countData!.map((v) => v.toJson()).toList();
    }
    if (this.visitData != null) {
      data['visit_data'] = this.visitData!.map((v) => v.toJson()).toList();
    }
    if (this.departmentData != null) {
      data['department_data'] =
          this.departmentData!.map((v) => v.toJson()).toList();
    }
    if (this.servicegroupData != null) {
      data['servicegroup_data'] =
          this.servicegroupData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CollectionData {
  String? title;
  String? amt;

  CollectionData({this.title, this.amt});

  CollectionData.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    amt = json['amt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['amt'] = this.amt;
    return data;
  }
}

class CountData {
  String? title;
  String? cn;

  CountData({this.title, this.cn});

  CountData.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    cn = json['cn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['cn'] = this.cn;
    return data;
  }
}

class VisitData {
  String? title;
  String? patientCount;
  String? netPaid;

  VisitData({this.title, this.patientCount, this.netPaid});

  VisitData.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    patientCount = json['PatientCount'];
    netPaid = json['NetPaid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['PatientCount'] = this.patientCount;
    data['NetPaid'] = this.netPaid;
    return data;
  }
}

class DepartmentData {
  String? title;
  String? patientCount;
  String? billCount;

  DepartmentData({this.title, this.patientCount, this.billCount});

  DepartmentData.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    patientCount = json['patient_count'];
    billCount = json['bill_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['patient_count'] = this.patientCount;
    data['bill_count'] = this.billCount;
    return data;
  }
}

class ServicegroupData {
  String? grpName;
  String? serviceCount;
  String? serviceAmt;

  ServicegroupData({this.grpName, this.serviceCount, this.serviceAmt});

  ServicegroupData.fromJson(Map<String, dynamic> json) {
    grpName = json['grp_name'];
    serviceCount = json['service_count'];
    serviceAmt = json['service_amt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['grp_name'] = this.grpName;
    data['service_count'] = this.serviceCount;
    data['service_amt'] = this.serviceAmt;
    return data;
  }
}