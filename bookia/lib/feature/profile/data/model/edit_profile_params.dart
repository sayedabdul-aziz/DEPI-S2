import 'dart:io';

import 'package:dio/dio.dart';

class EditProfileParams {
  String? name;
  String? phone;
  String? address;
  String? city;
  File? image;

  EditProfileParams({
    this.name,
    this.phone,
    this.address,
    this.city,
    this.image,
  });

  Map<String, String> toJson() {
    final data = <String, String>{};
    if (name != null) data['name'] = name!;
    if (phone != null) data['phone'] = phone!;
    if (address != null) data['address'] = address!;
    if (city != null) data['city'] = city!;
    return data;
  }

  Future<FormData> toFormData() async {
    return FormData.fromMap({
      if (name != null) 'name': name,
      if (phone != null) 'phone': phone,
      if (address != null) 'address': address,
      if (city != null) 'city': city,
      if (image != null)
        'image': await MultipartFile.fromFile(
          image!.path,
          filename: image!.path.split('/').last,
        ),
    });
  }
}
