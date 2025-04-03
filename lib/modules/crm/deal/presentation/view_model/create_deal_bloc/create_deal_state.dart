import 'package:equatable/equatable.dart';


enum CreateDealStatus {
  createDealInitial,
  createDealLoading,
  createDealSuccess,
  createDealFailure
}

class CreateDealFormUpdate extends Equatable {
  final String salutation;
  final String firstName;
  final String lastName;
  final String gender;
  final String numberOfEmployees;
  final String industry;
  final String leadOwner;
  final String dealStatus;
  final String email;
  final String contact;
  final String organization;
  final String website;
  final String date;
  final CreateDealStatus createDealStatus;

  const CreateDealFormUpdate({
    this.salutation = '',
    this.firstName = '',
    this.lastName = '',
    this.gender = '',
    this.numberOfEmployees = '',
    this.industry = '',
    this.leadOwner = '',
    this.dealStatus = 'Qualification',
    this.email = '',
    this.contact = '',
    this.organization = '',
    this.website = '',
    this.date = '',
    this.createDealStatus = CreateDealStatus.createDealInitial,
  });

  CreateDealFormUpdate copyWith({
    String? salutation,
    String? firstName,
    String? lastName,
    String? gender,
    String? numberOfEmployees,
    String? industry,
    String? leadOwner,
    String? dealStatus,
    String? email,
    String? contact,
    String? organization,
    String? website,
    String? date,
    CreateDealStatus? createDealStatus,
  }) {
    return CreateDealFormUpdate(
      salutation: salutation ?? this.salutation,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      gender: gender ?? this.gender,
      numberOfEmployees: numberOfEmployees ?? this.numberOfEmployees,
      industry: industry ?? this.industry,
      leadOwner: leadOwner ?? this.leadOwner,
      dealStatus: dealStatus ?? this.dealStatus,
      email: email ?? this.email,
      contact: contact ?? this.contact,
      organization: organization ?? this.organization,
      website: website ?? this.website,
      date: date ?? this.date,
      createDealStatus: createDealStatus ?? this.createDealStatus,
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
        dealStatus,
        email,
        contact,
        organization,
        website,
        date,
        createDealStatus,
      ];
}


