import 'package:equatable/equatable.dart';


enum CreateLeadStatus {
  createLeadInitial,
  createLeadLoading,
  createLeadSuccess,
  createLeadFailure
}

class CreateLeadFormUpdate extends Equatable {
  final String salutation;
  final String firstName;
  final String lastName;
  final String gender;
  final String numberOfEmployees;
  final String industry;
  final String leadOwner;
  final String leadStatus;
  final String email;
  final String contact;
  final String organization;
  final String website;
  final String date;
  final CreateLeadStatus createLeadStatus;

  const CreateLeadFormUpdate({
    this.salutation = '',
    this.firstName = '',
    this.lastName = '',
    this.gender = '',
    this.numberOfEmployees = '',
    this.industry = '',
    this.leadOwner = '',
    this.leadStatus = 'New',
    this.email = '',
    this.contact = '',
    this.organization = '',
    this.website = '',
    this.date = '',
    this.createLeadStatus = CreateLeadStatus.createLeadInitial,
  });

  CreateLeadFormUpdate copyWith({
    String? salutation,
    String? firstName,
    String? lastName,
    String? gender,
    String? numberOfEmployees,
    String? industry,
    String? leadOwner,
    String? leadStatus,
    String? email,
    String? contact,
    String? organization,
    String? website,
    String? date,
    CreateLeadStatus? createLeadStatus,
  }) {
    return CreateLeadFormUpdate(
      salutation: salutation ?? this.salutation,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      gender: gender ?? this.gender,
      numberOfEmployees: numberOfEmployees ?? this.numberOfEmployees,
      industry: industry ?? this.industry,
      leadOwner: leadOwner ?? this.leadOwner,
      leadStatus: leadStatus ?? this.leadStatus,
      email: email ?? this.email,
      contact: contact ?? this.contact,
      organization: organization ?? this.organization,
      website: website ?? this.website,
      date: date ?? this.date,
      createLeadStatus: createLeadStatus ?? this.createLeadStatus,
    );
  }

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
        createLeadStatus,
      ];
}


