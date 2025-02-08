

import 'package:crm_mobile_app/core/error/exception.dart';
import 'package:crm_mobile_app/core/error/failure.dart';
import 'package:crm_mobile_app/core/utils/data_state.dart';
import 'package:crm_mobile_app/core/utils/type_def.dart';
import 'package:crm_mobile_app/modules/leads/data/repositories/lead_repository.dart';
import 'package:crm_mobile_app/modules/leads/data/services/lead_api.dart';
import 'package:crm_mobile_app/modules/leads/data/services/models/request/lead_request_model.dart';
import 'package:crm_mobile_app/modules/leads/data/services/models/response/lead_response.dart';
import 'package:dio/dio.dart';

// class LeadRepositoryImpl implements LeadRepository{
//   final LeadApi leadApi;
//   LeadRepositoryImpl(this.leadApi);
//
//   @override
//   ResultFuture<LeadResponse> getLead(LeadDataRequestModel leadDataRequestModel) async {
//     try {
//       final leadResponse = await leadApi.getLeads(leadDataRequestModel);
//
//       if (leadResponse is LeadSuccessResponseModel) {
//         return DataSuccess(leadResponse);
//       } else if (leadResponse is LeadErrorResponseModel) {
//         return DataFailed(ServerFailure(
//             leadResponse.message ?? Strings.defaultErrMsg, 401));
//       } else {
//         return DataFailed(UnknownFailure(Strings.defaultErrMsg, 0));
//       }
//     } on ServerException catch (e) {
//       return DataFailed(ServerFailure(e.message ?? Strings.defaultErrMsg, 0));
//     } on ApiServerException catch (e) {
//       return DataFailed(
//           ServerFailure(e.message ?? Strings.defaultErrMsg, e.statusCode!));
//     } on DioException catch (e) {
//       return DataFailed(UnknownFailure(e.toString(), 0));
//     } catch (e) {
//       return DataFailed(UnknownFailure(e.toString(), 0));
//     }
//   }
// }