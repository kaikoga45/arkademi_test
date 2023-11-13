import 'package:arkademi_test/data/local/file_local.dart';

class FileRepository {
  final FileLocal fileLocal;

  FileRepository(this.fileLocal);

  Stream<int> saveFileFromUrl(String url, String fileName) {
    fileLocal.saveFileFromUrl(url, '$fileName.mp4');
    return fileLocal.downloadProgress;
  }

  Future<void> deleteFile(String fileName) async {
    return fileLocal.deleteFile('$fileName.mp4');
  }

  Future<bool> isFileExist(String fileName) async {
    return fileLocal.isFileExist(fileName);
  }
}
