class GetDealNotesRequestModel {
  String? referenceDocname;

  GetDealNotesRequestModel({this.referenceDocname});

  GetDealNotesRequestModel.fromJson(Map<String, dynamic> json) {
    referenceDocname = json['reference_docname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reference_docname'] = this.referenceDocname;
    return data;
  }
}
