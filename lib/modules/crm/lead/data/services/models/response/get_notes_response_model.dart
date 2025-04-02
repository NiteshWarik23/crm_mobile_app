sealed class GetNotesResponseModel {}

class GetNotesSuccessResponseModel extends GetNotesResponseModel {
  List<NotesListData>? data;

  GetNotesSuccessResponseModel({this.data});

  GetNotesSuccessResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <NotesListData>[];
      json['data'].forEach((v) {
        data!.add(NotesListData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NotesListData {
  String? name;
  String? owner;
  String? creation;
  String? modified;
  String? modifiedBy;
  int? docstatus;
  int? idx;
  String? title;
  String? content;
  String? referenceDoctype;
  String? referenceDocname;

  NotesListData(
      {this.name,
      this.owner,
      this.creation,
      this.modified,
      this.modifiedBy,
      this.docstatus,
      this.idx,
      this.title,
      this.content,
      this.referenceDoctype,
      this.referenceDocname});

  NotesListData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    owner = json['owner'];
    creation = json['creation'];
    modified = json['modified'];
    modifiedBy = json['modified_by'];
    docstatus = json['docstatus'];
    idx = json['idx'];
    title = json['title'];
    content = json['content'];
    referenceDoctype = json['reference_doctype'];
    referenceDocname = json['reference_docname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['owner'] = owner;
    data['creation'] = creation;
    data['modified'] = modified;
    data['modified_by'] = modifiedBy;
    data['docstatus'] = docstatus;
    data['idx'] = idx;
    data['title'] = title;
    data['content'] = content;
    data['reference_doctype'] = referenceDoctype;
    data['reference_docname'] = referenceDocname;
    return data;
  }
}

class GetNotesErrorResponseModel extends GetNotesResponseModel {
  String? exception;
  String? excType;
  String? exc;
  String? sServerMessages;

  GetNotesErrorResponseModel(
      {this.exception, this.excType, this.exc, this.sServerMessages});

  GetNotesErrorResponseModel.fromJson(Map<String, dynamic> json) {
    exception = json['exception'];
    excType = json['exc_type'];
    exc = json['exc'];
    sServerMessages = json['_server_messages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['exception'] = exception;
    data['exc_type'] = excType;
    data['exc'] = exc;
    data['_server_messages'] = sServerMessages;
    return data;
  }
}
