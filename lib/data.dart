class Data {
  final String pid;
  final String name;
  final String upload;
  final String download;
  final String uploadSpeed;
  final String downloadSpeed;

  num get uploadNum => double.parse(upload.substring(0, upload.length - 2));
  num get downloadNum =>
      double.parse(download.substring(0, download.length - 2));
  num get uploadSpeedNum =>
      double.parse(uploadSpeed.substring(0, uploadSpeed.length - 3));
  num get downloadSpeedNum =>
      double.parse(downloadSpeed.substring(0, downloadSpeed.length - 3));

  Data(
      {this.pid = "",
      this.name = "",
      this.upload = "",
      this.download = "",
      this.uploadSpeed = "",
      this.downloadSpeed = ""});

  Data.fromJson(Map<String, dynamic> json)
      : pid = json["pid"],
        name = json["name"],
        upload = json["upload"],
        download = json["download"],
        uploadSpeed = json["upload_speed"],
        downloadSpeed = json["download_speed"];

  @override
  String toString() {
    return "\npid: $pid, name: $name, upload: $upload, download: $download, uploadSpeed: $uploadSpeed, downloadSpeed: $downloadSpeed";
  }

  String getInfo() {
    return "Upload: $upload\nDownload: $download\nUploadSpeed: $uploadSpeed\nDownloadSpeed: $downloadSpeed";
  }
}
