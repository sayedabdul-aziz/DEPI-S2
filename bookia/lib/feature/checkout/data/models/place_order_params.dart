class PlaceOrderParams {
  final int governorateId;
  final String address;
  final String email;
  final String phone;
  final String name;

  PlaceOrderParams({
    required this.governorateId,
    required this.address,
    required this.email,
    required this.phone,
    required this.name,
  });

  Map<String, dynamic> toJson() => {
    "governorate_id": governorateId,
    "address": address,
    "email": email,
    "phone": phone,
    "name": name,
  };
}
