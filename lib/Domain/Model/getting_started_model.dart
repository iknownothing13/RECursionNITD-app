class GettingStartedModel {
  int? count;
  String? next;
  Null previous;
  List<Results>? results;

  GettingStartedModel({this.count, this.next, this.previous, this.results});

  GettingStartedModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(new Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['next'] = this.next;
    data['previous'] = this.previous;
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  int? number;
  List<Topic>? topic;
  String? color;
  Null image;
  String? levelTitle;

  Results({this.number, this.topic, this.color, this.image, this.levelTitle});

  Results.fromJson(Map<String, dynamic> json) {
    number = json['Number'];
    if (json['topic'] != null) {
      topic = <Topic>[];
      json['topic'].forEach((v) {
        topic!.add(new Topic.fromJson(v));
      });
    }
    color = json['Color'];
    image = json['Image'];
    levelTitle = json['Level_title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Number'] = this.number;
    if (this.topic != null) {
      data['topic'] = this.topic!.map((v) => v.toJson()).toList();
    }
    data['Color'] = this.color;
    data['Image'] = this.image;
    data['Level_title'] = this.levelTitle;
    return data;
  }
}

class Topic {
  String? topicTitle;
  List<Subtopic>? subtopic;

  Topic({this.topicTitle, this.subtopic});

  Topic.fromJson(Map<String, dynamic> json) {
    topicTitle = json['Topic_title'];
    if (json['subtopic'] != null) {
      subtopic = <Subtopic>[];
      json['subtopic'].forEach((v) {
        subtopic!.add(new Subtopic.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Topic_title'] = this.topicTitle;
    if (this.subtopic != null) {
      data['subtopic'] = this.subtopic!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Subtopic {
  int? id;
  String? subTopic;

  Subtopic({this.id, this.subTopic});

  Subtopic.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subTopic = json['sub_topic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sub_topic'] = this.subTopic;
    return data;
  }
}
