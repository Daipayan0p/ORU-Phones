class SearchFilters {
  final List<String> brands;
  final List<String> ram;
  final List<String> storage;
  final List<String> conditions;
  final List<String> warranty;

  SearchFilters({
    required this.brands,
    required this.ram,
    required this.storage,
    required this.conditions,
    required this.warranty,
  });

  factory SearchFilters.fromJson(Map<String, dynamic> json) {
    return SearchFilters(
      brands: List<String>.from(json['Brand'] ?? []),
      ram: List<String>.from(json['Ram'] ?? []),
      storage: List<String>.from(json['Storage'] ?? []),
      conditions: List<String>.from(json['Conditions'] ?? []),
      warranty: List<String>.from(json['Warranty'] ?? []),
    );
  }
}