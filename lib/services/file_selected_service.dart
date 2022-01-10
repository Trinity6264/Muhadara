import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class FileSelectService {

  Future<FilePickerResult?> pickAudio() async {
    if (await Permission.storage.request().isGranted) {
      return await FilePicker.platform.pickFiles(
        type: FileType.audio,
        withData: true,
        allowCompression: true,
      );
    } else {
      await [
        Permission.storage,
      ].request();
    }
  }

  // picture path
  Future<FilePickerResult?> pickImage() async {
    if (await Permission.storage.request().isGranted) {
      return await FilePicker.platform.pickFiles(
        type: FileType.image,
        withData: true,
      );
      // if (result == null) return null;
      // _getImage = File(result.files.single.path.toString());
    } else {
       await [
        Permission.storage,
      ].request();
    }
  }
}
