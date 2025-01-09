// Compresse le document scanné sinon erreur de l'api
import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

Future<File> compressFile(File file) async {
  var temporaryDirectory = await getTemporaryDirectory();
  String fileName = "${file.path.split('/').last}.jpg";
  String path = "${temporaryDirectory.path}/$fileName";
  final File compressedFile = File(path);
  await FlutterImageCompress.compressAndGetFile(
    file.path,
    compressedFile.path,
    quality: 50,
  );

  return compressedFile;
}

String getFileExtension(String filePath) {
  int lastIndex = filePath.lastIndexOf('.');
  // Utilisation de la classe Path pour extraire l'extension
  if (lastIndex != -1 && lastIndex < filePath.length - 1) {
    // Récupérer l'extension en utilisant la sous-chaîne
    String extension = filePath.substring(lastIndex + 1);
    return extension;
  } else {
    // Aucune extension trouvée
    return '';
  }
}

Future<File> takePicture({
  void Function(File currentFile)? onPictureTaked,
}) async {
  File currentFile = File("");
  // LAUNCH CAMERA PICKER
  final ImagePicker picker = ImagePicker();
  XFile? result = await picker.pickImage(
    source: ImageSource.camera,
    imageQuality: 80,
  );
  if (result != null) {
    // File size is within the limit
    currentFile = File(result.path);
    currentFile = await compressFile(currentFile);
    return currentFile;
  } else {
    return currentFile;
  }
}
