import 'package:crm_mobile_app/core/error/exception.dart';
import 'package:crm_mobile_app/core/error/failure.dart';
import 'package:crm_mobile_app/core/utils/data_state.dart';
import 'package:crm_mobile_app/core/utils/strings.dart';
import 'package:crm_mobile_app/core/utils/type_def.dart';
import 'package:crm_mobile_app/modules/marketing/data/repositories/marketing_repository.dart';
import 'package:crm_mobile_app/modules/marketing/data/services/marketing_api.dart';
import 'package:crm_mobile_app/modules/marketing/data/services/models/response/get_campaigns_response_model.dart';
import 'package:dio/dio.dart';

class MarketingRepositoryImpl implements MarketingRepository {
  final MarketingApi marketingApi;
  MarketingRepositoryImpl(this.marketingApi);

  @override
  ResultFuture<GetCampaignsResponseModel> getCampaigns() async {
    try {
      final marketingResponse = await marketingApi.getCampaigns();

      if (marketingResponse is GetCampaignsSuccessResponseModel) {
        return DataSuccess(marketingResponse);
      } else if (marketingResponse is GetCampaignsErrorResponseModel) {
        return DataFailed(ServerFailure(
            //TODO TBD for what message to show
            //leadResponse.exc ??
            Strings.defaultErrMsg,
            401));
      } else {
        return DataFailed(UnknownFailure(Strings.defaultErrMsg, 0));
      }
    } on ServerException catch (e) {
      print("Server Expection Lead Repo ${e.message}");
      return DataFailed(ServerFailure(e.message ?? Strings.defaultErrMsg, 0));
    } on ApiServerException catch (e) {
      return DataFailed(
          ServerFailure(e.message ?? Strings.defaultErrMsg, e.statusCode!));
    } on NetworkException catch (e) {
      return DataFailed(
          NetworkFailure(e.message ?? Strings.defaultErrMsg, 0));
    }
     on Exception catch (e) {
      return DataFailed(UnknownFailure(e.toString(), 0));
    } catch (e) {
      return DataFailed(UnknownFailure(e.toString(), 0));
    }
  }
}
