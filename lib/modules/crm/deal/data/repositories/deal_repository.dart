import 'package:crm_mobile_app/core/utils/type_def.dart';
import 'package:crm_mobile_app/modules/crm/deal/data/services/models/request/create_deal_note_request_model.dart';
import 'package:crm_mobile_app/modules/crm/deal/data/services/models/request/create_deal_request_model.dart';
import 'package:crm_mobile_app/modules/crm/deal/data/services/models/request/create_deal_tag_request_model.dart';
import 'package:crm_mobile_app/modules/crm/deal/data/services/models/request/deal_request_model.dart';
import 'package:crm_mobile_app/modules/crm/deal/data/services/models/request/delete_deal_request_model.dart';
import 'package:crm_mobile_app/modules/crm/deal/data/services/models/request/get_deal_notes_request_model.dart';
import 'package:crm_mobile_app/modules/crm/deal/data/services/models/request/update_deal_status_request_model.dart';
import 'package:crm_mobile_app/modules/crm/deal/data/services/models/response/create_deal_note_response_model.dart';
import 'package:crm_mobile_app/modules/crm/deal/data/services/models/response/create_deal_response_model.dart';
import 'package:crm_mobile_app/modules/crm/deal/data/services/models/response/create_deal_tag_response_model.dart';
import 'package:crm_mobile_app/modules/crm/deal/data/services/models/response/deal_response.dart';
import 'package:crm_mobile_app/modules/crm/deal/data/services/models/response/delete_deal_response_model.dart';
import 'package:crm_mobile_app/modules/crm/deal/data/services/models/response/get_deal_notes_response_model.dart';
import 'package:crm_mobile_app/modules/crm/deal/data/services/models/response/search_deal_response_model.dart';
import 'package:crm_mobile_app/modules/crm/deal/data/services/models/response/update_deal_status_response_model.dart';


abstract class DealRepository {
  ResultFuture<DealResponse> getDeals(
      OffsetLimitRequestModel offsetLimitRequestModel, String dealFilterType);
  ResultFuture<UpdateDealStatusResponse> updateDealStatus(
      UpdateDealStatusRequestModel updateDealStatusRequestModel);
  ResultFuture<SearchDealResponse> searchDeals(String enteredSearchText);
  ResultFuture<DeleteDealResponse> deleteDeal(
      DeleteDealRequestModel deleteDealRequestModel);
  ResultFuture<CreateDealResponseModel> createDeal(
      CreateDealRequestModel createDealRequestModel);
    ResultFuture<CreateDealTagResponseModel> createDealTag(
      CreateDealTagRequestModel createDealTagRequestModel);
   ResultFuture<CreateDealNoteResponseModel> createDealNote(
      CreateDealNoteRequestModel createDealNoteRequestModel);
  ResultFuture<GetDealNotesResponseModel> getDealNotes(
      GetDealNotesRequestModel getDealNotesRequestModel,
      OffsetLimitRequestModel offsetLimitRequestModel);
}

