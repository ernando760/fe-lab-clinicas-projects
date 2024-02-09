// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatientModel _$PatientModelFromJson(Map<String, dynamic> json) => PatientModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phoneNumber: json['phone_number'] as String,
      address:
          PatientAddressModel.fromJson(json['address'] as Map<String, dynamic>),
      document: json['document'] as String,
      guardian: json['guardian'] as String? ?? '',
      guardianIdentificationNumber:
          json['guardian_identification_number'] as String? ?? '',
    );

Map<String, dynamic> _$PatientModelToJson(PatientModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'phone_number': instance.phoneNumber,
      'address': instance.address,
      'document': instance.document,
      'guardian': instance.guardian,
      'guardian_identification_number': instance.guardianIdentificationNumber,
    };
