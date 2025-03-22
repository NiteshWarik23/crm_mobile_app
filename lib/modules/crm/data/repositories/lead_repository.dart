import 'package:crm_mobile_app/core/utils/results.dart';
import 'package:crm_mobile_app/core/utils/type_def.dart';
import 'package:crm_mobile_app/modules/crm/data/services/models/request/convert_lead_to_deal_request_model.dart';
import 'package:crm_mobile_app/modules/crm/data/services/models/request/create_lead_request_model.dart';
import 'package:crm_mobile_app/modules/crm/data/services/models/request/delete_lead_request_model.dart';
import 'package:crm_mobile_app/modules/crm/data/services/models/request/lead_request_model.dart';
import 'package:crm_mobile_app/modules/crm/data/services/models/request/update_lead_status_request_model.dart';
import 'package:crm_mobile_app/modules/crm/data/services/models/response/convert_lead_to_deal_response_model.dart';
import 'package:crm_mobile_app/modules/crm/data/services/models/response/create_lead_response_model.dart';
import 'package:crm_mobile_app/modules/crm/data/services/models/response/delete_lead_response_model.dart';
import 'package:crm_mobile_app/modules/crm/data/services/models/response/lead_response.dart';
import 'package:crm_mobile_app/modules/crm/data/services/models/response/search_lead_response_model.dart';
import 'package:crm_mobile_app/modules/crm/data/services/models/response/update_lead_status_response_model.dart';

abstract class LeadRepository {
  ResultFuture<LeadResponse> getLeads(
      OffsetLimitRequestModel offsetLimitRequestModel);

  ResultFuture<ConvertLeadToDealResponse> convertLeadToDeal(
      ConvertLeadToDealRequestModel convertLeadToDealRequestModel);
  ResultFuture<UpdateLeadStatusResponse> updateLeadStatus(
      UpdateLeadStatusRequestModel updateLeadStatusRequestModel);
  ResultFuture<SearchLeadResponse> searchLeads(String enteredSearchText);
  ResultFuture<DeleteLeadResponse> deleteLead(
      DeleteLeadRequestModel deleteLeadRequestModel);
  ResultFuture<CreateLeadResponseModel> createLead(
      CreateLeadRequestModel createLeadRequestModel);
}
