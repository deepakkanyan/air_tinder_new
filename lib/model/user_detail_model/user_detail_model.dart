
class UserDetailModel {
  static UserDetailModel instance = UserDetailModel();

  String? uId;
  String? email;
  String? fullName;
  String? gender;
  String? profileImgUrl;
  List? additionalImages = [];
  String? dateOfBirth;
  List? interests = [];
  String? about;
  Map<String, dynamic>? departureDetails;
  Map<String, dynamic>? layoverDetails;
  Map<String, dynamic>? landingDetails;
  String? createdAt;

  UserDetailModel({
    this.uId = '',
    this.email = '',
    this.fullName = '',
    this.gender = '',
    this.profileImgUrl = '',
    this.additionalImages,
    this.dateOfBirth = '',
    this.interests,
    this.about = '',
    this.departureDetails,
    this.layoverDetails,
    this.landingDetails,
    this.createdAt = '',
  });

  factory UserDetailModel.fromJson(Map<String, dynamic> json) =>
      UserDetailModel(
        uId: json['uId'],
        email: json['email'],
        fullName: json['fullName'],
        gender: json['gender'],
        profileImgUrl: json['profileImage'],
        additionalImages: json['additionalImages'],
        dateOfBirth: json['dateOfBirth'],
        interests: json['interests'],
        about: json['about'],
        departureDetails: json['departureDetails'],
        layoverDetails: json['layoverDetails'],
        landingDetails: json['landingDetails'],
        createdAt: json['createdAt'],
      );

  Map<String, dynamic> toJson() => {
        'uId': uId,
        'email': email,
        'fullName': fullName,
        'gender': gender,
        'profileImage': profileImgUrl,
        'additionalImages': additionalImages,
        'dateOfBirth': dateOfBirth,
        'interests': interests,
        'about': about,
        'departureDetails': departureDetails,
        'layoverDetails': layoverDetails,
        'landingDetails': landingDetails,
        'createdAt': createdAt,
      };
}
