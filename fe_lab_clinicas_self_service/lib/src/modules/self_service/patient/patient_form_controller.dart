import 'package:fe_lab_clinicas_self_service/src/model/patient_model.dart';
import 'package:fe_lab_clinicas_self_service/src/modules/self_service/patient/patient_page.dart';
import 'package:fe_lab_clinicas_self_service/src/repositories/patients/patient_repository.dart';
import 'package:flutter/material.dart';

mixin PatientFormController on State<PatientPage> {
  final nameEC = TextEditingController();
  final emailEC = TextEditingController();
  final phoneEC = TextEditingController();
  final documentEC = TextEditingController();
  final cepEC = TextEditingController();
  final streetEC = TextEditingController();
  final numberEC = TextEditingController();
  final complementsEC = TextEditingController();
  final stateEC = TextEditingController();
  final cityEC = TextEditingController();
  final districtEC = TextEditingController();
  final guardianEC = TextEditingController();
  final guardianIdentificationNumbeEC = TextEditingController();

  void disposeForm() {
    nameEC.dispose();
    emailEC.dispose();
    phoneEC.dispose();
    documentEC.dispose();
    cepEC.dispose();
    streetEC.dispose();
    numberEC.dispose();
    complementsEC.dispose();
    stateEC.dispose();
    cityEC.dispose();
    districtEC.dispose();
    guardianEC.dispose();
    guardianIdentificationNumbeEC.dispose();
  }

  void initializeForm(PatientModel? patient) {
    if (patient != null) {
      nameEC.text = patient.name;
      emailEC.text = patient.email;
      phoneEC.text = patient.phoneNumber;
      documentEC.text = patient.document;
      cepEC.text = patient.address.cep;
      streetEC.text = patient.address.streetAddress;
      numberEC.text = patient.address.number;
      complementsEC.text = patient.address.addressComplement;
      stateEC.text = patient.address.state;
      cityEC.text = patient.address.city;
      districtEC.text = patient.address.district;
      guardianEC.text = patient.guardian;
      guardianIdentificationNumbeEC.text = patient.guardianIdentificationNumber;
    }
  }

  PatientModel updatePatient(PatientModel patient) {
    return patient.copyWith(
      name: nameEC.text,
      email: emailEC.text,
      phoneNumber: phoneEC.text,
      document: documentEC.text,
      address: patient.address.copyWith(
        cep: cepEC.text,
        streetAddress: streetEC.text,
        number: numberEC.text,
        addressComplement: complementsEC.text,
        state: stateEC.text,
        city: cityEC.text,
        district: districtEC.text,
      ),
      guardian: guardianEC.text,
      guardianIdentificationNumber: guardianIdentificationNumbeEC.text,
    );
  }

  RegisterPatientModel createPatientRegister() {
    return (
      name: nameEC.text,
      email: emailEC.text,
      phoneNumber: phoneEC.text,
      document: documentEC.text,
      address: (
        cep: cepEC.text,
        addressComplement: complementsEC.text,
        district: districtEC.text,
        city: cityEC.text,
        number: numberEC.text,
        state: stateEC.text,
        streetAddress: streetEC.text
      ),
      guardian: guardianEC.text,
      guardianIdentificatorNumber: guardianIdentificationNumbeEC.text
    );
  }
}
