class GetRegistration {
  String? cid;
  String? fp;
  String? os;
  String? msg;
  String? sof;

  GetRegistration({this.cid, this.fp, this.os, this.msg, this.sof});

  GetRegistration.fromJson(Map<String, dynamic> json) {
    cid = json['cid'];
    fp = json['fp'];
    os = json['os'];
    msg = json['msg'];
    sof = json['sof'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cid'] = this.cid;
    data['fp'] = this.fp;
    data['os'] = this.os;
    data['msg'] = this.msg;
    data['sof'] = this.sof;
    return data;
  }
}