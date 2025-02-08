import 'dart:convert';

import 'package:crm_mobile_app/config/dio_client/dio_client.dart';
import 'package:crm_mobile_app/core/error/dio_error.dart';
import 'package:crm_mobile_app/modules/leads/data/services/models/request/lead_request_model.dart';
import 'package:crm_mobile_app/modules/leads/data/services/models/response/lead_response.dart';
import 'package:dio/dio.dart';

abstract class LeadApi {
 Future<List<LeadSuccessResponseModel>> getLeads(LeadDataRequestModel leadDataRequestModel);
}

class LeadApiImpl implements LeadApi {
 final DioClient dioClient;

 LeadApiImpl(this.dioClient);

 @override
 Future<List<LeadSuccessResponseModel>> getLeads(LeadDataRequestModel leadDataRequestModel) async {
  try {
   final String jsonResponse = '''
[
  {
    "name": "Anna Smith",
    "email": "annasmith12@gmail.com",
    "contact": "0987654321",
    "status": "In Progress",
    "status_color": 16744163
  },
  {
    "name": "Carla Cardos",
    "email": "Carla87@gmail.com",
    "contact": "0987654321",
    "status": "On Hold",
    "status_color": 9573101
  },
  {
    "name": "Hannah Smith",
    "email": "hannahsmith84@gmail.com",
    "contact": "0987654321",
    "status": "Closed",
    "status_color": 13711121
  },
  {
    "name": "Aanya",
    "email": "Anyadsouza09@gmail.com",
    "contact": "0987654321",
    "status": "In Progress",
    "status_color": 16744163
  }
]
''';

   final List<dynamic> jsonData = json.decode(jsonResponse);
   final List<LeadSuccessResponseModel> leadList = jsonData
       .map((item) => LeadSuccessResponseModel.fromJson(item))
       .toList();

   return leadList;

  } on DioException catch (e) {
   print("Response Code !${e.response?.statusCode}");
   throw handleDioClientError(e);
  }
 }
}
