// lib/domain/entities/location.dart
import 'package:flutter/material.dart';

class Location {
  final String id;
  final String title;
  final String status;
  final Color statusColor;
  final String fullAddress;
  final String date;

  Location({
    required this.id,
    required this.title,
    required this.status,
    required this.statusColor,
    required this.fullAddress,
    required this.date,
  });
}
