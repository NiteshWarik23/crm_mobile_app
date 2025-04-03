class CreateDealTagRequestModel {
  String? tag;
  String? dt;
  String? dn;

  CreateDealTagRequestModel({this.tag, this.dt, this.dn});

  CreateDealTagRequestModel.fromJson(Map<String, dynamic> json) {
    tag = json['tag'];
    dt = json['dt'];
    dn = json['dn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tag'] = tag;
    data['dt'] = dt;
    data['dn'] = dn;
    return data;
  }
}
