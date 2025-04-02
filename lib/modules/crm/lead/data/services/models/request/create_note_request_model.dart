class CreateNoteRequestModel {
  Doc? doc;

  CreateNoteRequestModel({this.doc});

  CreateNoteRequestModel.fromJson(Map<String, dynamic> json) {
    doc = json['doc'] != null ? Doc.fromJson(json['doc']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (doc != null) {
      data['doc'] = doc!.toJson();
    }
    return data;
  }
}

class Doc {
  String? doctype;
  String? title;
  String? content;
  String? referenceDoctype;
  String? referenceDocname;

  Doc(
      {this.doctype,
      this.title,
      this.content,
      this.referenceDoctype,
      this.referenceDocname});

  Doc.fromJson(Map<String, dynamic> json) {
    doctype = json['doctype'];
    title = json['title'];
    content = json['content'];
    referenceDoctype = json['reference_doctype'];
    referenceDocname = json['reference_docname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['doctype'] = doctype;
    data['title'] = title;
    data['content'] = content;
    data['reference_doctype'] = referenceDoctype;
    data['reference_docname'] = referenceDocname;
    return data;
  }
}
