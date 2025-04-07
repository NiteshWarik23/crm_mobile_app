import 'package:crm_mobile_app/core/usecase/usecase.dart';
import 'package:crm_mobile_app/core/utils/type_def.dart';
import 'package:crm_mobile_app/modules/crm/lead/data/repositories/lead_repository.dart';
import 'package:crm_mobile_app/modules/crm/lead/data/services/models/request/lead_request_model.dart';
import 'package:crm_mobile_app/modules/crm/lead/data/services/models/response/search_lead_response_model.dart';
import 'package:equatable/equatable.dart';

class SearchLeadUsecase
    implements
        UsecaseWithParams<SearchLeadResponse, SearchLeadDataRequestParams> {
  final LeadRepository leadRepository;
  SearchLeadUsecase(this.leadRepository);

  @override
  ResultFuture<SearchLeadResponse> call(params) async {
    return await leadRepository.searchLeads(params.enteredSearchText);
  }
}

class SearchLeadDataRequestParams extends Equatable {
  final OffsetLimitRequestModel offsetLimitRequestModel;
  final String enteredSearchText;

  const SearchLeadDataRequestParams({required this.offsetLimitRequestModel,required this.enteredSearchText});

  @override
  List<Object> get props => [offsetLimitRequestModel,enteredSearchText];
}
