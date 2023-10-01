class Event {
  int? count;
  Null? next;
  Null? previous;
  List<Results>? results;

  Event({this.count, this.next, this.previous, this.results});

  Event.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    data['next'] = next;
    data['previous'] = previous;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
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

  Results(
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

  Results.fromJson(Map<String, dynamic> json) {
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
