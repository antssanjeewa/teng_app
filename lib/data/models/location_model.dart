import 'package:intl/intl.dart';

import '../../domain/entities/location.dart';
import '../../domain/entities/location_form.dart';

class LocationModel {
  final String id;
  final String name;
  final String customerName;
  final String customerContact;
  final String donorName;
  final String donorContact;
  final String address;
  final String district;
  final String model;
  final String status;
  final DateTime installationDate;
  final String estimatedCost;
  final String specialInstructions;

  LocationModel({
    required this.id,
    required this.name,
    required this.customerName,
    required this.customerContact,
    required this.donorName,
    required this.donorContact,
    required this.address,
    required this.district,
    required this.model,
    required this.status,
    required this.installationDate,
    required this.estimatedCost,
    required this.specialInstructions,
  });

  // Convert Firestore Map to Model
  factory LocationModel.fromMap(Map<String, dynamic> map, String documentId) {
    return LocationModel(
      id: documentId,
      name: map['name'] ?? '',
      customerName: map['customerName'] ?? 'a',
      customerContact: map['customerContact'] ?? '',
      donorName: map['donorName'] ?? '',
      donorContact: map['donorContact'] ?? '',
      address: map['address'] ?? 'a',
      district: map['district'] ?? '',
      model: map['model'] ?? '',
      status: map['status'] ?? 'active',
      installationDate: DateTime.parse(
        map['installationDate'] ?? DateTime.now().toIso8601String(),
      ),
      estimatedCost: map['estimatedCost'] ?? '',
      specialInstructions: map['specialInstructions'] ?? '',
    );
  }

  factory LocationModel.fromEntity(LocationForm entity) {
    return LocationModel(
      id: "RO-${DateTime.now().millisecondsSinceEpoch}",
      name: entity.name,
      customerName: entity.customerName,
      customerContact: entity.customerContact,
      donorName: entity.donorName,
      donorContact: entity.donorContact,
      address: entity.address,
      district: entity.district,
      model: entity.model,
      status: 'active',
      installationDate: entity.installationDate,
      estimatedCost: entity.estimatedCost,
      specialInstructions: entity.specialInstructions,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'customerName': customerName,
      'customerContact': customerContact,
      'donorName': donorName,
      'donorContact': donorContact,
      'address': address,
      'district': district,
      'model': model,
      'installationDate': installationDate.toIso8601String(),
      'estimatedCost': estimatedCost,
      'specialInstructions': specialInstructions,
    };
  }

  Location toEntity() {
    return Location(
      id: id,
      title: customerName,
      subtitle: address,
      fullAddress: address,
      date: DateFormat('dd MMM yyyy').format(installationDate),
    );
  }
}
