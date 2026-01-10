// lib/domain/entities/location.dart
class Location {
  final String id;
  final String title;
  final String subtitle;
  final String fullAddress;
  final String date;

  Location({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.fullAddress,
    required this.date,
  });
}
