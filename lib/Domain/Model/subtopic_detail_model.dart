class SubtopicDetailModel {
  int? id;
  List<Note>? note;
  List<File>? file;
  String? subTopic;
  int? topic;
  int? level;

  SubtopicDetailModel(
      {this.id, this.note, this.file, this.subTopic, this.topic, this.level});

  SubtopicDetailModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['note'] != null) {
      note = <Note>[];
      json['note'].forEach((v) {
        note!.add(new Note.fromJson(v));
      });
    }
    if (json['file'] != null) {
      file = <File>[];
      json['file'].forEach((v) {
        file!.add(new File.fromJson(v));
      });
    }
    subTopic = json['sub_topic'];
    topic = json['topic'];
    level = json['level'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.note != null) {
      data['note'] = this.note!.map((v) => v.toJson()).toList();
    }
    if (this.file != null) {
      data['file'] = this.file!.map((v) => v.toJson()).toList();
    }
    data['sub_topic'] = this.subTopic;
    data['topic'] = this.topic;
    data['level'] = this.level;
    return data;
  }
}

class Note {
  int? id;
  String? notesTopic;
  String? description;
  String? codeSnippet;
  Null? image1;
  Null? image2;
  int? topic;
  int? level;
  int? subtopic;

  Note(
      {this.id,
      this.notesTopic,
      this.description,
      this.codeSnippet,
      this.image1,
      this.image2,
      this.topic,
      this.level,
      this.subtopic});

  Note.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    notesTopic = json['Notes_topic'];
    description = json['Description'];
    codeSnippet = json['Code_snippet'];
    image1 = json['Image1'];
    image2 = json['Image2'];
    topic = json['topic'];
    level = json['level'];
    subtopic = json['subtopic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Notes_topic'] = this.notesTopic;
    data['Description'] = this.description;
    data['Code_snippet'] = this.codeSnippet;
    data['Image1'] = this.image1;
    data['Image2'] = this.image2;
    data['topic'] = this.topic;
    data['level'] = this.level;
    data['subtopic'] = this.subtopic;
    return data;
  }
}

class File {
  int? id;
  List<Link>? link;
  String? heading;
  Null? upload;
  int? topic;
  int? level;
  int? subtopic;

  File(
      {this.id,
      this.link,
      this.heading,
      this.upload,
      this.topic,
      this.level,
      this.subtopic});

  File.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['link'] != null) {
      link = <Link>[];
      json['link'].forEach((v) {
        link!.add(new Link.fromJson(v));
      });
    }
    heading = json['heading'];
    upload = json['upload'];
    topic = json['topic'];
    level = json['level'];
    subtopic = json['subtopic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.link != null) {
      data['link'] = this.link!.map((v) => v.toJson()).toList();
    }
    data['heading'] = this.heading;
    data['upload'] = this.upload;
    data['topic'] = this.topic;
    data['level'] = this.level;
    data['subtopic'] = this.subtopic;
    return data;
  }
}

class Link {
  int? id;
  String? link1;
  String? urlLink1;
  String? link2;
  String? urlLink2;
  String? link3;
  String? urlLink3;
  String? link4;
  String? urlLink4;
  int? file;

  Link(
      {this.id,
      this.link1,
      this.urlLink1,
      this.link2,
      this.urlLink2,
      this.link3,
      this.urlLink3,
      this.link4,
      this.urlLink4,
      this.file});

  Link.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    link1 = json['link1'];
    urlLink1 = json['url_link1'];
    link2 = json['link2'];
    urlLink2 = json['url_link2'];
    link3 = json['link3'];
    urlLink3 = json['url_link3'];
    link4 = json['link4'];
    urlLink4 = json['url_link4'];
    file = json['file'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['link1'] = this.link1;
    data['url_link1'] = this.urlLink1;
    data['link2'] = this.link2;
    data['url_link2'] = this.urlLink2;
    data['link3'] = this.link3;
    data['url_link3'] = this.urlLink3;
    data['link4'] = this.link4;
    data['url_link4'] = this.urlLink4;
    data['file'] = this.file;
    return data;
  }
}