import 'package:crm_mobile_app/config/dio_client/dio_client.dart';
import 'package:crm_mobile_app/core/utils/constants.dart';
import 'package:crm_mobile_app/modules/dashboard/data/services/models/dashboard_model.dart';
import 'package:dio/dio.dart';

abstract class DashboardApi {
  Future<DashboardModel> getDashboardData();
}

class DashboardApiImplementation implements DashboardApi {
  final DioClient dioClient;

  DashboardApiImplementation(this.dioClient);
  @override
  Future<DashboardModel> getDashboardData() async {
    try {
      final response = await dioClient.dio.get(Constants.baseUrlDev);
      if (response.statusCode == 200) {
        return DashboardModel.fromJson(response.data);
      }
    } catch (e) {
    }
    Map<String,dynamic> mpp = {"Error":""};
    return DashboardModel.fromJson(mpp);
  }
}
