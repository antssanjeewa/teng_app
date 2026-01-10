class JobModel {
  final String id;
  final String description;
  final String estimatedCost;
  final String specialInstructions;
  final String category;
  final List<String> photos;
  final String status; // 'active', 'completed', etc.
  final String locationId;

  JobModel({
    required this.id,
    required this.description,
    required this.estimatedCost,
    required this.specialInstructions,
    required this.category,
    required this.photos,
    required this.status,
    required this.locationId,
  });

  factory JobModel.fromMap(Map<String, dynamic> map, String documentId) {
    return JobModel(
      id: documentId,
      description: map['description'] ?? '',
      estimatedCost: map['estimatedCost'] ?? '',
      specialInstructions: map['specialInstructions'] ?? '',
      category: map['category'] ?? '',
      photos: List<String>.from(map['photos'] ?? []),
      status: map['status'] ?? 'active',
      locationId: map['locationId'] ?? '',
    );
  }
}
