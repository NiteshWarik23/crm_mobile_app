import 'package:crm_mobile_app/core/usecase/usecase.dart';
import 'package:crm_mobile_app/core/utils/type_def.dart';
import 'package:crm_mobile_app/modules/crm/deal/data/repositories/deal_repository.dart';
import 'package:crm_mobile_app/modules/crm/deal/data/services/models/response/search_deal_response_model.dart';
import 'package:equatable/equatable.dart';

class SearchDealUsecase
    implements
        UsecaseWithParams<SearchDealResponse, SearchDealDataRequestParams> {
  final DealRepository dealRepository;
  SearchDealUsecase(this.dealRepository);

  @override
  ResultFuture<SearchDealResponse> call(params) async {
    return await dealRepository.searchDeals(params.enteredSearchText);
  }
}

class SearchDealDataRequestParams extends Equatable {
  final String enteredSearchText;

  const SearchDealDataRequestParams(
      {required this.enteredSearchText});

  @override
  List<Object> get props => [enteredSearchText];
}
