// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

abstract class CreateDealTagEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SaveCreatedOrSelectedDealTagsEvent extends CreateDealTagEvent {
  final List<String> createdOrSelectedDealTags;

  SaveCreatedOrSelectedDealTagsEvent({required this.createdOrSelectedDealTags});

  @override
  List<Object> get props => [createdOrSelectedDealTags];
}

class SaveOneCreatedOrSelectedDealTagsEvent extends CreateDealTagEvent {
  final String createdOrSelectedDealTags;
  final String dealIdValue;

  SaveOneCreatedOrSelectedDealTagsEvent({
    required this.createdOrSelectedDealTags,
    required this.dealIdValue,
  });

  @override
  List<Object> get props => [createdOrSelectedDealTags,dealIdValue];
}
