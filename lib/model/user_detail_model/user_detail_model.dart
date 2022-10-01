class UserDetailModel {
  String? uId;
  String? email;
  String? fullName;
  String? gender;
  String? profileImgUrl;
  List<String>? additionalImages = [];
  String? dob;
  List<String>? interests = [];
  String? bio;
  String? createdAt;

  UserDetailModel({
    this.uId = '',
    this.email = '',
    this.fullName = '',
    this.additionalImages,
    this.gender = '',
    this.profileImgUrl = '',
    this.dob = '',
    this.interests,
    this.bio = '',
    this.createdAt = '',
  });

  factory UserDetailModel.fromJson(Map<String, dynamic> json) =>
      UserDetailModel(
        uId: json['uId'],
        email: json['email'],
        fullName: json['fullName'],
        additionalImages: json['additionalImages'],
        gender: json['gender'],
        profileImgUrl: json['profileImgUrl'],
        dob: json['dob'],
        interests: json['interests'],
        bio: json['bio'],
        createdAt: json['createdAt'],
      );

  Map<String, dynamic> toJson() => {
        'uId': uId,
        'email': email,
        'fullName': fullName,
        'additionalImages': additionalImages,
        'gender': gender,
        'dob': dob,
        'interests': interests,
        'bio': bio,
        'createdAt': createdAt,
      };
}
