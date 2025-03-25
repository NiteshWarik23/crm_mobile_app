import 'package:equatable/equatable.dart';

abstract class CreateLeadFormState extends Equatable {
  const CreateLeadFormState();

  @override
  List<Object?> get props => [];

}

class CreateLeadInitialState extends CreateLeadFormState{}

class CreateLeadFormUpdate extends CreateLeadFormState {
  final String salutation;
  final String firstName;
  final String lastName;
  final String email;
  final String contact;
  final String organization;
  final String website;
  final String date;

  const CreateLeadFormUpdate({
    this.salutation = '',
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.contact = '',
    this.organization = '',
    this.website = '',
    this.date = '',
  });

  CreateLeadFormUpdate copyWith({
    String? salutation,
    String? firstName,
    String? lastName,
    String? email,
    String? contact,
    String? organization,
    String? website,
    String? date,
  }) {
    return CreateLeadFormUpdate(
      salutation: salutation ?? this.salutation,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      contact: contact ?? this.contact,
      organization: organization ?? this.organization,
      website: website ?? this.website,
      date: date ?? this.date,
    );
  }

  @override
  List<Object?> get props => [
        salutation,
        firstName,
        lastName,
        email,
        contact,
        organization,
        website,
        date,
      ];
}

class LeadFormSubmitting extends CreateLeadFormState {}

class LeadFormSuccess extends CreateLeadFormState {
  final String message;

  const LeadFormSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class LeadFormFailure extends CreateLeadFormState {
  final String error;

  const LeadFormFailure(this.error);

  @override
  List<Object?> get props => [error];
}
