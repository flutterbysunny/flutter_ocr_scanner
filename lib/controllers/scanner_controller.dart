import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../models/bank_details.dart';
import '../models/card_details.dart';
import '../parsers/card_parser.dart';
import '../parsers/passbook_parser.dart';
import '../services/ocr_service.dart';

class ScannerController extends GetxController {
  final picker = ImagePicker();

  File? imageFile;

  String rawText = '';

  CardDetails? cardDetails;
  BankDetails? bankDetails;

  bool isLoading = false;

  Future<void> scanCard() async {
    final picked = await picker.pickImage(
      source: ImageSource.camera,
    );

    if (picked == null) return;

    isLoading = true;
    update();

    imageFile = File(picked.path);

    rawText = await OcrService.processImage(imageFile!);

    cardDetails = CardParser.parseCard(rawText);

    isLoading = false;
    update();
  }

  Future<void> scanPassbook() async {
    final picked = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (picked == null) return;

    isLoading = true;
    update();

    imageFile = File(picked.path);

    rawText = await OcrService.processImage(imageFile!);

    bankDetails = PassbookParser.parsePassbook(rawText);

    isLoading = false;
    update();
  }
}