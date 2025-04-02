// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

abstract class CreateTagEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SaveCreatedOrSelectedTagsEvent extends CreateTagEvent {
  final List<String> createdOrSelectedTags;

  SaveCreatedOrSelectedTagsEvent({required this.createdOrSelectedTags});

  @override
  List<Object> get props => [createdOrSelectedTags];
}

class SaveOneCreatedOrSelectedTagsEvent extends CreateTagEvent {
  final String createdOrSelectedTags;
  final String leadIdValue;

  SaveOneCreatedOrSelectedTagsEvent({
    required this.createdOrSelectedTags,
    required this.leadIdValue,
  });

  @override
  List<Object> get props => [createdOrSelectedTags,leadIdValue];
}
