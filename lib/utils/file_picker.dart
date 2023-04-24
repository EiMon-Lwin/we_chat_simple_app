import 'dart:io';

import 'package:file_picker/file_picker.dart';

Future<File?> getSelectedFile() async {
  FilePickerResult? pickerResult = await FilePicker.platform
      .pickFiles(type: FileType.any, allowMultiple: false);
  if (pickerResult != null) {
    File tempFile = File(pickerResult.files.single.path ?? '');
    return tempFile;
  }
  return null;
}
