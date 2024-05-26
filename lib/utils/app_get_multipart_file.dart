import "dart:io";

import "package:get/get_connect/http/src/multipart/multipart_file.dart";
import "package:mime/mime.dart";
import "package:path/path.dart";

class AppGetMultipartFile {
  factory AppGetMultipartFile() {
    return _singleton;
  }

  AppGetMultipartFile._internal();
  static final AppGetMultipartFile _singleton = AppGetMultipartFile._internal();

  MultipartFile getFile({required String filePath}) {
    final MultipartFile multipartFile = MultipartFile(
      File(filePath),
      filename: basename(filePath),
      contentType: lookupMimeType(filePath) ?? "application/octet-stream",
    );

    return multipartFile;
  }
}
