import 'package:equatable/equatable.dart';

abstract class CreateLeadFormEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class UpdateSalutation extends CreateLeadFormEvent {
  final String salutation;
  UpdateSalutation(this.salutation);
  @override
  List<Object?> get props => [salutation];
}

class UpdateFirstName extends CreateLeadFormEvent {
  final String firstName;
  UpdateFirstName(this.firstName);
  @override
  List<Object?> get props => [firstName];
}

class UpdateLastName extends CreateLeadFormEvent {
  final String lastName;
  UpdateLastName(this.lastName);
  @override
  List<Object?> get props => [lastName];
}

class UpdateEmail extends CreateLeadFormEvent {
  final String email;
  UpdateEmail(this.email);
  @override
  List<Object?> get props => [email];
}

class UpdateContact extends CreateLeadFormEvent {
  final String contact;
  UpdateContact(this.contact);
  @override
  List<Object?> get props => [contact];
}

class UpdateOrganization extends CreateLeadFormEvent {
  final String organization;
  UpdateOrganization(this.organization);
  @override
  List<Object?> get props => [organization];
}

class UpdateWebsite extends CreateLeadFormEvent {
  final String website;
  UpdateWebsite(this.website);
  @override
  List<Object?> get props => [website];
}

class UpdateDate extends CreateLeadFormEvent {
  final String date;
  UpdateDate(this.date);
  @override
  List<Object?> get props => [date];
}

class UpdateFormField extends CreateLeadFormEvent {
  final String? salutation;
  final String? firstName;
  final String? lastName;
  final String? gender;
  final String? numberOfEmployees;
  final String? industry;
  final String? leadOwner;
  final String? leadStatus;
  final String? email;
  final String? contact;
  final String? organization;
  final String? website;
  final String? date;

  UpdateFormField({
    this.salutation,
    this.firstName,
    this.lastName,
    this.gender,
    this.numberOfEmployees,
    this.industry,
    this.leadOwner,
    this.leadStatus,
    this.email,
    this.contact,
    this.organization,
    this.website,
    this.date,
  });

  @override
  List<Object?> get props => [
        salutation,
        firstName,
        lastName,
        gender,
        numberOfEmployees,
        industry,
        leadOwner,
        leadStatus,
        email,
        contact,
        organization,
        website,
        date,
      ];
}

class SubmitLeadForm extends CreateLeadFormEvent {
  final String? salutation;
  final String? firstName;
  final String? lastName;
  final String? gender;
  final String? numberOfEmployees;
  final String? industry;
  final String? leadOwner;
  final String? leadStatus;
  final String? email;
  final String? contact;
  final String? organization;
  final String? website;

  SubmitLeadForm({
    this.salutation,
    this.firstName,
    this.lastName,
    this.gender,
    this.numberOfEmployees,
    this.industry,
    this.leadOwner,
    this.leadStatus,
    this.email,
    this.contact,
    this.organization,
    this.website,
  });

   @override
  List<Object?> get props => [
        salutation,
        firstName,
        lastName,
        gender,
        numberOfEmployees,
        industry,
        leadOwner,
        leadStatus,
        email,
        contact,
        organization,
        website,
      ];
}
