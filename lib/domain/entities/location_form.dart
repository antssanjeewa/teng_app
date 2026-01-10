// lib/domain/entities/location.dart
class LocationForm {
  final String name;
  final String customerName;
  final String customerContact;
  final String donorName;
  final String donorContact;
  final String address;
  final String district;
  final String model;
  final DateTime installationDate;
  final String estimatedCost;
  final String specialInstructions;

  LocationForm({
    required this.name,
    required this.customerName,
    required this.customerContact,
    required this.donorName,
    required this.donorContact,
    required this.address,
    required this.district,
    required this.model,
    required this.installationDate,
    required this.estimatedCost,
    required this.specialInstructions,
  });
}
