class VendorUserModels{
  final bool? approved;
  final String? vendorId;
  final String? businessName;
  final String? city;
  final String? country;
  final String? email;
  final String? phoneNumber;
  final String? state;
  final String? image;
  final String? taxNumber;
  final String? taxOptions;

  VendorUserModels(
      {
        required this.approved,
        required this.vendorId,
        required this.businessName,
        required this.city,
        required this.country,
        required this.email,
        required this.phoneNumber,
        required this.state,
        required this.image,
        required this.taxNumber,
        required this.taxOptions
      }
      );
  VendorUserModels.fromJson(Map<String, Object?> json):
        this(
        approved: json['approved'] as bool?,
        vendorId: json['vendorId'] as String?,
        businessName: json['businessName'] as String?,
        city: json['city'] as String?,
        country: json['country'] as String?,
        email: json['email'] as String?,
        phoneNumber: json['phoneNumber'] as String?,
        state: json['state'] as String?,
        image: json['image'] as String?,
        taxNumber: json['taxNumber'] as String?,
        taxOptions: json['taxOptions'] as String?,
      );
  Map<String, Object?>toJson(){
    return{
      'businessName': businessName,
      'email':email,
      'phoneNumber': phoneNumber,
      'country': country,
      'state':state,
      'city': city,
      'taxOptions': taxOptions,
      'taxNumber': taxNumber,
      'image': image,
      'approved':approved,
      'vendorId': vendorId
    };
  }
}
// in order for this to work effectively, the variable names must be the same as the names you are trying to
//map them to