class ProfileModel {
  final String name;
  final String email;
  final String phone;
  final String address;
  final String about;
  final String photo;

  ProfileModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.about,
    required this.photo,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
      about: json['about'],
      photo: json['photo'],
    );
  }
}
