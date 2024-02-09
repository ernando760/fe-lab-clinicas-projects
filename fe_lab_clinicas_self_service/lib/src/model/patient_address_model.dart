// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:json_annotation/json_annotation.dart';

part 'patient_address_model.g.dart';

@JsonSerializable()
class PatientAddressModel {
  final String cep;
  @JsonKey(name: 'street_address')
  final String streetAddress;
  final String number;
  @JsonKey(name: 'address_complement', defaultValue: "")
  final String addressComplement;
  final String state;
  final String city;
  final String district;

  PatientAddressModel(
      {required this.cep,
      required this.streetAddress,
      required this.number,
      required this.addressComplement,
      required this.state,
      required this.city,
      required this.district});

  factory PatientAddressModel.fromJson(Map<String, dynamic> json) =>
      _$PatientAddressModelFromJson(json);

  Map<String, dynamic> toJson() => _$PatientAddressModelToJson(this);

  PatientAddressModel copyWith({
    String? cep,
    String? streetAddress,
    String? number,
    String? addressComplement,
    String? state,
    String? city,
    String? district,
  }) {
    return PatientAddressModel(
      cep: cep ?? this.cep,
      streetAddress: streetAddress ?? this.streetAddress,
      number: number ?? this.number,
      addressComplement: addressComplement ?? this.addressComplement,
      state: state ?? this.state,
      city: city ?? this.city,
      district: district ?? this.district,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cep': cep,
      'streetAddress': streetAddress,
      'number': number,
      'addressComplement': addressComplement,
      'state': state,
      'city': city,
      'district': district,
    };
  }

  factory PatientAddressModel.fromMap(Map<String, dynamic> map) {
    return PatientAddressModel(
      cep: map['cep'] as String,
      streetAddress: map['streetAddress'] as String,
      number: map['number'] as String,
      addressComplement: map['addressComplement'] as String,
      state: map['state'] as String,
      city: map['city'] as String,
      district: ['district'] as String,
    );
  }

  @override
  String toString() {
    return 'PatientAddressModel(cep: $cep, streetAddress: $streetAddress, number: $number, addressComplement: $addressComplement, state: $state, city: $city, district: $district)';
  }

  @override
  bool operator ==(covariant PatientAddressModel other) {
    if (identical(this, other)) return true;

    return other.cep == cep &&
        other.streetAddress == streetAddress &&
        other.number == number &&
        other.addressComplement == addressComplement &&
        other.state == state &&
        other.city == city &&
        other.district == district;
  }

  @override
  int get hashCode {
    return cep.hashCode ^
        streetAddress.hashCode ^
        number.hashCode ^
        addressComplement.hashCode ^
        state.hashCode ^
        city.hashCode ^
        district.hashCode;
  }
}
