import 'dart:io';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class OcrService {
  static Future<String> processImage(File file) async {
    final inputImage = InputImage.fromFile(file);

    final recognizer = TextRecognizer();

    final RecognizedText recognizedText =
    await recognizer.processImage(inputImage);

    await recognizer.close();

    return recognizedText.text;
  }
}