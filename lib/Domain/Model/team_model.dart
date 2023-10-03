class Team {
  String? name;
  String? branch;
  String? designation;
  int? batchYear;
  String? urlFacebook;
  String? urlLinkedIn;
  String? mobile;
  String? image;
  String? createdAt;
  String? updatedAt;

  Team(
      {this.name,
      this.branch,
      this.designation,
      this.batchYear,
      this.urlFacebook,
      this.urlLinkedIn,
      this.mobile,
      this.image,
      this.createdAt,
      this.updatedAt});

  Team.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    branch = json['branch'];
    designation = json['designation'];
    batchYear = json['batch_year'];
    urlFacebook = json['url_Facebook'];
    urlLinkedIn = json['url_LinkedIn'];
    mobile = json['mobile'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['branch'] = branch;
    data['designation'] = designation;
    data['batch_year'] = batchYear;
    data['url_Facebook'] = urlFacebook;
    data['url_LinkedIn'] = urlLinkedIn;
    data['mobile'] = mobile;
    data['image'] = image;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
