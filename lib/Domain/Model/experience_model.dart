class ExperienceModel {
  final String id;
  final String companyName;
  final String roleType;
  final String description;

  ExperienceModel({
    required this.id,
    required this.companyName,
    required this.roleType,
    required this.description,
  });

  factory ExperienceModel.fromJson(Map<String, dynamic> json) {
    return ExperienceModel(
      id: json['id'],
      companyName: json['companyName'] ?? 'Unknown',
      roleType: json['roleType'] ?? 'Unknown',
      description: json['description'] ?? '',
    );
  }
}
