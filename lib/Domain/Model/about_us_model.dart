class AboutUs {
  int? yearsOfExperience;
  int? hoursTeaching;
  int? contestCount;
  List<UpcomingEvents>? mapUpcomingEvents;

  AboutUs({this.yearsOfExperience, this.hoursTeaching, this.contestCount});

  AboutUs.fromJson(Map<String, dynamic> json) {
    yearsOfExperience = json['years_of_experience'];
    hoursTeaching = json['hours_teaching'];
    contestCount = json['contest_count'];
    if (json['upcoming_events'] != null) {
      mapUpcomingEvents = <UpcomingEvents>[];
      json['upcoming_events'].forEach((v) {
        mapUpcomingEvents!.add(UpcomingEvents.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['years_of_experience'] = yearsOfExperience;
    data['hours_teaching'] = hoursTeaching;
    data['contest_count'] = contestCount;
    data['upcoming_events']=mapUpcomingEvents;
    return data;
  }
}
class UpcomingEvents{
  int? id;
  String? url;
  User? user;
  String? title;
  String? eventType;
  String? targetYear;
  String? description;
  String? image;
  String? link;
  String? startTime;
  String? endTime;
  String? duration;
  String? venue;
  String? createdAt;
  String? updatedAt;

  UpcomingEvents(
      {this.id,
        this.url,
        this.user,
        this.title,
        this.eventType,
        this.targetYear,
        this.description,
        this.image,
        this.link,
        this.startTime,
        this.endTime,
        this.duration,
        this.venue,
        this.createdAt,
        this.updatedAt});

  UpcomingEvents.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    title = json['title'];
    eventType = json['event_type'];
    targetYear = json['target_year'];
    description = json['description'];
    image = json['image'];
    link = json['link'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    duration = json['duration'];
    venue = json['venue'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['url'] = url;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['title'] = title;
    data['event_type'] = eventType;
    data['target_year'] = targetYear;
    data['description'] = description;
    data['image'] = image;
    data['link'] = link;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['duration'] = duration;
    data['venue'] = venue;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
class User {
  String? username;
  String? email;
  String? url;

  User({this.username, this.email, this.url});

  User.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['email'] = email;
    data['url'] = url;
    return data;
  }
}
