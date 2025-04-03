class DeleteDealRequestModel {
  String? items;
  String? doctype;

  DeleteDealRequestModel({this.items, this.doctype});

  DeleteDealRequestModel.fromJson(Map<String, dynamic> json) {
    items = json['items'];
    doctype = json['doctype'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['items'] = items;
    data['doctype'] = doctype;
    return data;
  }
}
