import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class FileLocal {
  late final StreamController<int> _downloadProgressController;

  static final _instance = FileLocal._();

  factory FileLocal() => _instance;

  FileLocal._() {
    _downloadProgressController = StreamController<int>.broadcast();
  }

  Stream<int> get downloadProgress => _downloadProgressController.stream;

  Future<void> saveFileFromUrl(String url, String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    final dio = Dio();
    await dio.download(
      url,
      '${directory.path}/$fileName',
      onReceiveProgress: (received, total) {
        if (total != -1) {
          _downloadProgressController.add((received / total * 100).toInt());
        }
      },
    );
  }

  Future<void> deleteFile(String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$fileName');
    if (await file.exists()) {
      await file.delete();
    }
  }

  Future<bool> isFileExist(String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$fileName');
    return await file.exists();
  }

  Future<String> getFilePath(String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/$fileName';
  }
}
