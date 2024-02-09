// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fe_lab_clinicas_self_service/src/model/patient_model.dart';
import 'package:flutter/material.dart';

enum DocumentType { healthInsuranceCard, medicalOrder }

final class SelfServiceModel {
  final String? name;
  final String? lastname;
  final PatientModel? patient;
  final Map<DocumentType, List<String>>? documents;

  const SelfServiceModel(
      {this.name, this.lastname, this.patient, this.documents});

  SelfServiceModel clear() => copyWith(
      name: () => null,
      lastname: () => null,
      patient: () => null,
      documents: () => null);

  SelfServiceModel copyWith({
    ValueGetter<String?>? name,
    ValueGetter<String?>? lastname,
    ValueGetter<PatientModel?>? patient,
    ValueGetter<Map<DocumentType, List<String>>?>? documents,
  }) {
    return SelfServiceModel(
        name: name != null ? name() : this.name,
        lastname: lastname != null ? lastname() : this.lastname,
        patient: patient != null ? patient() : this.patient,
        documents: documents != null ? documents() : this.documents);
  }
}
