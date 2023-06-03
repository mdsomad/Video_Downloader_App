class DownloadDetailsStoreModel {
  String? title;
  String? videourl;
  String? videoquality;
  String? thumbnails;
  String? type_Of_File;

  DownloadDetailsStoreModel(
      {required this.title, required this.videourl, required this.videoquality, required this.thumbnails,required this.type_Of_File});

  DownloadDetailsStoreModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    videourl = json['videourl'];
    videoquality = json['videoquality'];
    thumbnails = json['thumbnails'];
    type_Of_File = json['type_Of_File'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['videourl'] = this.videourl;
    data['videoquality'] = this.videoquality;
    data['thumbnails'] = this.thumbnails;
    data['type_Of_File'] = this.type_Of_File;
    return data;
  }
}
