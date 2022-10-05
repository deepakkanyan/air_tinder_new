class InterestModels {
  static final InterestModels instance = InterestModels();
  String? interest;
  bool? isSelected;

  InterestModels({
    this.interest,
    this.isSelected = false,
  });

  factory InterestModels.fromJson(Map<String, dynamic> json) => InterestModels(
        interest: json['interest'],
        isSelected: json['isSelected'],
      );

  Map<String, dynamic> toJson() => {
        'interest': interest,
        'isSelected': isSelected,
      };
}
