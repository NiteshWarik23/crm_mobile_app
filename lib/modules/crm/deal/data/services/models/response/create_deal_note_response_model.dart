
sealed class CreateDealNoteResponseModel {}

class CreateDealNoteSuccessResponseModel extends CreateDealNoteResponseModel {
  Message? message;

  CreateDealNoteSuccessResponseModel({this.message});

  CreateDealNoteSuccessResponseModel.fromJson(Map<String, dynamic> json) {
    message =
        json['message'] != null ? Message.fromJson(json['message']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (message != null) {
      data['message'] = message!.toJson();
    }
    return data;
  }
}

class Message {
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
  String? doctype;

  Message(
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
      this.referenceDocname,
      this.doctype});

  Message.fromJson(Map<String, dynamic> json) {
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
    doctype = json['doctype'];
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
    data['doctype'] = doctype;
    return data;
  }
}



class CreateDealNoteErrorResponseModel extends CreateDealNoteResponseModel {
  String? exception;
  String? excType;
  String? exc;
  String? sServerMessages;

  CreateDealNoteErrorResponseModel(
      {this.exception, this.excType, this.exc, this.sServerMessages});

  CreateDealNoteErrorResponseModel.fromJson(Map<String, dynamic> json) {
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
