

import 'package:crm_mobile_app/core/utils/type_def.dart';
import 'package:crm_mobile_app/modules/leads/data/services/models/request/lead_request_model.dart';
import 'package:crm_mobile_app/modules/leads/data/services/models/response/lead_response.dart';

abstract class LeadRepository{
  ResultFuture<LeadResponse> getLead(LeadDataRequestModel leadDataRequestModel);
}