class UpdateLeadStatusRequestModel {
  String? doctype;
  String? name;
  String? fieldname;
  String? value;

  UpdateLeadStatusRequestModel(
      {this.doctype, this.name, this.fieldname, this.value});

  UpdateLeadStatusRequestModel.fromJson(Map<String, dynamic> json) {
    doctype = json['doctype'];
    name = json['name'];
    fieldname = json['fieldname'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['doctype'] = doctype;
    data['name'] = name;
    data['fieldname'] = fieldname;
    data['value'] = value;
    return data;
  }
}
