// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class DashboardModel extends Equatable {
  final String? name;
  final String? last_name;
  final String? surname;

  DashboardModel(this.name, this.last_name, this.surname);

  @override
  List<Object?> get props => [name, last_name, surname];

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'last_name': last_name,
      'surname': surname,
    };
  }

  factory DashboardModel.fromJson(Map<String, dynamic> map) {
    return DashboardModel(
      map['name'] != null ? map['name'] as String : null,
      map['last_name'] != null ? map['last_name'] as String : null,
      map['surname'] != null ? map['surname'] as String : null,
    );
  }

 
}
