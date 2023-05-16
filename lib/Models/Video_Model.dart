






// class VideoModel {
//   String? title;
//   String? description;
//   String? videoUrl;
//   String? videoId;
//   String? videoLength;
//   String? viewCount;
//   String? category;
//   String? publishDate;
//   String? channelName;
//   int? subscriberCount;
//   List<Thumbnails>? thumbnails;
//   String? channelUrl;
//   List<Videos>? videos;
//   List<Audios>? audios;
//   String? status;

//   VideoModel(
//       {this.title,
//       this.description,
//       this.videoUrl,
//       this.videoId,
//       this.videoLength,
//       this.viewCount,
//       this.category,
//       this.publishDate,
//       this.channelName,
//       this.subscriberCount,
//       this.thumbnails,
//       this.channelUrl,
//       this.videos,
//       this.audios,
//       this.status});

//   VideoModel.fromJson(Map<String, dynamic> json) {
//     title = json['title'];
//     description = json['description'];
//     videoUrl = json['videoUrl'];
//     videoId = json['videoId'];
//     videoLength = json['videoLength'];
//     viewCount = json['viewCount'];
//     category = json['category'];
//     publishDate = json['publishDate'];
//     channelName = json['channelName'];
//     subscriberCount = json['subscriberCount'];
//     if (json['thumbnails'] != null) {
//       thumbnails = <Thumbnails>[];
//       json['thumbnails'].forEach((v) {
//         thumbnails!.add(new Thumbnails.fromJson(v));
//       });
//     }
//     channelUrl = json['channelUrl'];
//     if (json['videos'] != null) {
//       videos = <Videos>[];
//       json['videos'].forEach((v) {
//         videos!.add(new Videos.fromJson(v));
//       });
//     }
//     if (json['audios'] != null) {
//       audios = <Audios>[];
//       json['audios'].forEach((v) {
//         audios!.add(new Audios.fromJson(v));
//       });
//     }
//     status = json['status'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['title'] = this.title;
//     data['description'] = this.description;
//     data['videoUrl'] = this.videoUrl;
//     data['videoId'] = this.videoId;
//     data['videoLength'] = this.videoLength;
//     data['viewCount'] = this.viewCount;
//     data['category'] = this.category;
//     data['publishDate'] = this.publishDate;
//     data['channelName'] = this.channelName;
//     data['subscriberCount'] = this.subscriberCount;
//     if (this.thumbnails != null) {
//       data['thumbnails'] = this.thumbnails!.map((v) => v.toJson()).toList();
//     }
//     data['channelUrl'] = this.channelUrl;
//     if (this.videos != null) {
//       data['videos'] = this.videos!.map((v) => v.toJson()).toList();
//     }
//     if (this.audios != null) {
//       data['audios'] = this.audios!.map((v) => v.toJson()).toList();
//     }
//     data['status'] = this.status;
//     return data;
//   }
// }

// class Thumbnails {
//   String? url;
//   int? width;
//   int? height;

//   Thumbnails({this.url, this.width, this.height});

//   Thumbnails.fromJson(Map<String, dynamic> json) {
//     url = json['url'];
//     width = json['width'];
//     height = json['height'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['url'] = this.url;
//     data['width'] = this.width;
//     data['height'] = this.height;
//     return data;
//   }
// }

// class Videos {
//   String? quality;
//   int? width;
//   int? height;
//   String? url;
//   String? contentLength;
//   String? videoFormat;
//   bool? hasAudio;
//   int? fps;

//   Videos(
//       {this.quality,
//       this.width,
//       this.height,
//       this.url,
//       this.contentLength,
//       this.videoFormat,
//       this.hasAudio,
//       this.fps});

//   Videos.fromJson(Map<String, dynamic> json) {
//     quality = json['quality'];
//     width = json['width'];
//     height = json['height'];
//     url = json['url'];
//     contentLength = json['contentLength'];
//     videoFormat = json['video_format'];
//     hasAudio = json['hasAudio'];
//     fps = json['fps'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['quality'] = this.quality;
//     data['width'] = this.width;
//     data['height'] = this.height;
//     data['url'] = this.url;
//     data['contentLength'] = this.contentLength;
//     data['video_format'] = this.videoFormat;
//     data['hasAudio'] = this.hasAudio;
//     data['fps'] = this.fps;
//     return data;
//   }
// }

// class Audios {
//   String? quality;
//   String? url;
//   String? contentLength;
//   String? audioFormat;

//   Audios({this.quality, this.url, this.contentLength, this.audioFormat});

//   Audios.fromJson(Map<String, dynamic> json) {
//     quality = json['quality'];
//     url = json['url'];
//     contentLength = json['contentLength'];
//     audioFormat = json['audio_format'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['quality'] = this.quality;
//     data['url'] = this.url;
//     data['contentLength'] = this.contentLength;
//     data['audio_format'] = this.audioFormat;
//     return data;
//   }
// }











class VideoModel {
  String? status;
  Response? response;

  VideoModel({this.status, this.response});

  VideoModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    response = json['response'] != null
        ? new Response.fromJson(json['response'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.response != null) {
      data['response'] = this.response!.toJson();
    }
    return data;
  }
}

class Response {
  String? title;
  String? description;
  String? videoUrl;
  String? videoId;
  String? videoLength;
  String? viewCount;
  String? category;
  String? publishDate;
  String? channelName;
  int? subscriberCount;
  List<Thumbnails>? thumbnails;
  String? channelUrl;
  List<Videos>? videos;
  List<Audios>? audios;

  Response(
      {this.title,
      this.description,
      this.videoUrl,
      this.videoId,
      this.videoLength,
      this.viewCount,
      this.category,
      this.publishDate,
      this.channelName,
      this.subscriberCount,
      this.thumbnails,
      this.channelUrl,
      this.videos,
      this.audios});

  Response.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    videoUrl = json['videoUrl'];
    videoId = json['videoId'];
    videoLength = json['videoLength'];
    viewCount = json['viewCount'];
    category = json['category'];
    publishDate = json['publishDate'];
    channelName = json['channelName'];
    subscriberCount = json['subscriberCount'];
    if (json['thumbnails'] != null) {
      thumbnails = <Thumbnails>[];
      json['thumbnails'].forEach((v) {
        thumbnails!.add(new Thumbnails.fromJson(v));
      });
    }
    channelUrl = json['channelUrl'];
    if (json['videos'] != null) {
      videos = <Videos>[];
      json['videos'].forEach((v) {
        videos!.add(new Videos.fromJson(v));
      });
    }
    if (json['audios'] != null) {
      audios = <Audios>[];
      json['audios'].forEach((v) {
        audios!.add(new Audios.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['videoUrl'] = this.videoUrl;
    data['videoId'] = this.videoId;
    data['videoLength'] = this.videoLength;
    data['viewCount'] = this.viewCount;
    data['category'] = this.category;
    data['publishDate'] = this.publishDate;
    data['channelName'] = this.channelName;
    data['subscriberCount'] = this.subscriberCount;
    if (this.thumbnails != null) {
      data['thumbnails'] = this.thumbnails!.map((v) => v.toJson()).toList();
    }
    data['channelUrl'] = this.channelUrl;
    if (this.videos != null) {
      data['videos'] = this.videos!.map((v) => v.toJson()).toList();
    }
    if (this.audios != null) {
      data['audios'] = this.audios!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Thumbnails {
  String? url;
  int? width;
  int? height;

  Thumbnails({this.url, this.width, this.height});

  Thumbnails.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    width = json['width'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['width'] = this.width;
    data['height'] = this.height;
    return data;
  }
}

class Videos {
  String? quality;
  int? width;
  int? height;
  String? url;
  String? contentLength;
  String? videoFormat;
  bool? hasAudio;
  int? fps;

  Videos(
      {this.quality,
      this.width,
      this.height,
      this.url,
      this.contentLength,
      this.videoFormat,
      this.hasAudio,
      this.fps});

  Videos.fromJson(Map<String, dynamic> json) {
    quality = json['quality'];
    width = json['width'];
    height = json['height'];
    url = json['url'];
    contentLength = json['contentLength'];
    videoFormat = json['video_format'];
    hasAudio = json['hasAudio'];
    fps = json['fps'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['quality'] = this.quality;
    data['width'] = this.width;
    data['height'] = this.height;
    data['url'] = this.url;
    data['contentLength'] = this.contentLength;
    data['video_format'] = this.videoFormat;
    data['hasAudio'] = this.hasAudio;
    data['fps'] = this.fps;
    return data;
  }
}

class Audios {
  String? quality;
  String? url;
  String? contentLength;
  String? audioFormat;

  Audios({this.quality, this.url, this.contentLength, this.audioFormat});

  Audios.fromJson(Map<String, dynamic> json) {
    quality = json['quality'];
    url = json['url'];
    contentLength = json['contentLength'];
    audioFormat = json['audio_format'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['quality'] = this.quality;
    data['url'] = this.url;
    data['contentLength'] = this.contentLength;
    data['audio_format'] = this.audioFormat;
    return data;
  }
}
