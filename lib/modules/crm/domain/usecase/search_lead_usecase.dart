import 'package:crm_mobile_app/core/usecase/usecase.dart';
import 'package:crm_mobile_app/core/utils/type_def.dart';
import 'package:crm_mobile_app/modules/crm/data/repositories/lead_repository.dart';
import 'package:crm_mobile_app/modules/crm/data/services/models/response/search_lead_response_model.dart';
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
  final String enteredSearchText;

  const SearchLeadDataRequestParams(
      {required this.enteredSearchText});

  @override
  List<Object> get props => [enteredSearchText];
}
