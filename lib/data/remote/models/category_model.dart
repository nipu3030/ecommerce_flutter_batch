class CategoryModel {
  String id, name, status, created_at, updated_at;

  CategoryModel({
    required this.id,
    required this.name,
    required this.status,
    required this.created_at,
    required this.updated_at
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json){
    return CategoryModel(
        id: json['id']?.toString() ?? '',
        name: json['name'] ?? '',
        status: json['status']?.toString() ?? '',
        created_at: json['created_at'] ?? '',
        updated_at: json['updated_at'] ?? '');
  }

}