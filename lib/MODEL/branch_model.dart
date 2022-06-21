class BranchData {
  String? brnachId;
  String? branchCode;
  String? branchName;

  BranchData({this.brnachId, this.branchCode, this.branchName});

  BranchData.fromJson(Map<String, dynamic> json) {
    brnachId = json['brnach_id'];
    branchCode = json['branch_code'];
    branchName = json['BranchName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['brnach_id'] = this.brnachId;
    data['branch_code'] = this.branchCode;
    data['BranchName'] = this.branchName;
    return data;
  }
}