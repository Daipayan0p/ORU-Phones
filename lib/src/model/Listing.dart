class Listing {
  final String id;
  final String deviceCondition;
  final String listedBy;
  final String deviceStorage;
  final List<String> images;
  final String defaultImage;
  final String listingState;
  final String listingLocation;
  final String listingLocality;
  final double listingPrice;
  final String make;
  final String marketingName;
  final bool openForNegotiation;
  final double discountPercentage;
  final bool verified;
  final String status;
  final String listingId;
  final String deviceRam;
  final String warranty;
  final double originalPrice;
  final double discountedPrice;

  Listing({
    required this.id,
    required this.deviceCondition,
    required this.listedBy,
    required this.deviceStorage,
    required this.images,
    required this.defaultImage,
    required this.listingState,
    required this.listingLocation,
    required this.listingLocality,
    required this.listingPrice,
    required this.make,
    required this.marketingName,
    required this.openForNegotiation,
    required this.discountPercentage,
    required this.verified,
    required this.status,
    required this.listingId,
    required this.deviceRam,
    required this.warranty,
    required this.originalPrice,
    required this.discountedPrice,
  });

  factory Listing.fromJson(Map<String, dynamic> json) {
    return Listing(
      id: json['_id'] ?? '',
      deviceCondition: json['deviceCondition'] ?? 'Unknown',
      listedBy: json['listedBy'] ?? 'Unknown',
      deviceStorage: json['deviceStorage'] ?? 'Unknown',
      images: (json['images'] as List?)?.map((img) => img['fullImage'] as String? ?? '').toList() ?? [],
      defaultImage: json['defaultImage']?['fullImage'] ?? '',
      listingState: json['listingState'] ?? 'Unknown',
      listingLocation: json['listingLocation'] ?? 'Unknown',
      listingLocality: json['listingLocality'] ?? 'Unknown',
      listingPrice: (json['listingPrice'] is num) ? (json['listingPrice'] as num).toDouble() : 0.0,
      make: json['make'] ?? 'Unknown',
      marketingName: json['marketingName'] ?? 'Unknown',
      openForNegotiation: json['openForNegotiation'] ?? false,
      discountPercentage: (json['discountPercentage'] is num) ? (json['discountPercentage'] as num).toDouble() : 0.0,
      verified: json['verified'] ?? false,
      status: json['status'] ?? 'Unknown',
      listingId: json['listingId'] ?? '',
      deviceRam: json['deviceRam'] ?? 'Unknown',
      warranty: json['warranty'] ?? 'None',
      originalPrice: (json['originalPrice'] is num) ? (json['originalPrice'] as num).toDouble() : 0.0,
      discountedPrice: (json['discountedPrice'] is num) ? (json['discountedPrice'] as num).toDouble() : 0.0,
    );
  }
}