class Registration {
  String? cid;
  String? fp;
  String? sof;
  String? error;

  Registration({this.cid, this.fp, this.sof, this.error});

  Registration.fromJson(Map<String, dynamic> json) {
    cid = json['cid'];
    fp = json['fp'];
    sof = json['sof'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cid'] = this.cid;
    data['fp'] = this.fp;
    data['sof'] = this.sof;
    data['error'] = this.error;
    return data;
  }
}