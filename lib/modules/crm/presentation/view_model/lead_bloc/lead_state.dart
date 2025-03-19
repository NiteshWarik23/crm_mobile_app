import 'package:crm_mobile_app/modules/crm/data/services/models/response/lead_response.dart';
import 'package:equatable/equatable.dart';

enum LeadListStatus { initial, success, failure,convertToDealSuccess,convertToDealFailure,updateLeadStatusSuccess,updateLeadStatusFailure }

final class LeadState extends Equatable {
  final LeadListStatus status;
  final List<LeadData> leadData;
  final bool hasReachedMax;

  const LeadState({
    this.status = LeadListStatus.initial,
    this.leadData = const <LeadData>[],
    this.hasReachedMax = false,
  });

  LeadState copyWith({
    LeadListStatus? status,
    List<LeadData>? leadData,
    bool? hasReachedMax,
  }) {
    return LeadState(
      status: status ?? this.status,
      leadData: leadData ?? this.leadData,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''PostState { status: $status, hasReachedMax: $hasReachedMax, posts: ${leadData.length} }''';
  }

  @override
  List<Object> get props => [status,leadData,hasReachedMax];
}


