class AboutUs {
  int? yearsOfExperience;
  int? hoursTeaching;
  int? contestCount;

  AboutUs({this.yearsOfExperience, this.hoursTeaching, this.contestCount});

  AboutUs.fromJson(Map<String, dynamic> json) {
    yearsOfExperience = json['years_of_experience'];
    hoursTeaching = json['hours_teaching'];
    contestCount = json['contest_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['years_of_experience'] = yearsOfExperience;
    data['hours_teaching'] = hoursTeaching;
    data['contest_count'] = contestCount;
    return data;
  }
}
