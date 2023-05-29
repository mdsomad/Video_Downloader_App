class DownloadDetailsStoreModel {
  String? title;
  String? videourl;
  String? videoquality;
  String? thumbnails;

  DownloadDetailsStoreModel(
      {required this.title, required this.videourl, required this.videoquality, required this.thumbnails});

  DownloadDetailsStoreModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    videourl = json['videourl'];
    videoquality = json['videoquality'];
    thumbnails = json['thumbnails'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['videourl'] = this.videourl;
    data['videoquality'] = this.videoquality;
    data['thumbnails'] = this.thumbnails;
    return data;
  }
}
