import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';

class FilepickerUtil {
  Future<WebPickedFile?> pickFileFromWeb(
    List<String> allowedFiles,
  ) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      withReadStream: true,
      allowMultiple: false,
      allowedExtensions: allowedFiles,
    );

    if (result != null) {
      PlatformFile file = result.files.first;

      List<int> filebytes = await convertStreamToList(result.files.first.readStream!);
      return WebPickedFile(
        name: file.name,
        mimeType: mimeTypeFromExtension[file.extension],
        fileBytes: Uint8List.fromList(filebytes),
      );
    }
    return null;
  }

  Future<List<int>> convertStreamToList<int>(Stream<List<int>> stream) async {
    List<int> result = [];

    await for (List<int> list in stream) {
      result.addAll(list);
    }

    return result;
  }

  Future<PlatformFile?> pickFileFromAndroid() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      withReadStream: true,
      allowMultiple: false,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      return result.files.first;
    }

    return null;
  }
}

class WebPickedFile {
  final String? name;
  final String? mimeType;
  final Uint8List? fileBytes;

  WebPickedFile({this.name, this.mimeType, this.fileBytes});
}

Map<String, String> mimeTypeFromExtension = {
  'mp4': 'video/mp4',
  'mpeg': 'video/mpeg',
  'webm': 'video/webm',
  'mkv': 'video/x-matroska',
  'mov': 'video/quicktime',
};
