class CreateTagRequestModel {
  String? tag;
  String? dt;
  String? dn;

  CreateTagRequestModel({this.tag, this.dt, this.dn});

  CreateTagRequestModel.fromJson(Map<String, dynamic> json) {
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
