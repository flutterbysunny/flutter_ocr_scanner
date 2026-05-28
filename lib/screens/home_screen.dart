import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/scanner_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final controller = Get.put(ScannerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('OCR Scanner')),
      body: GetBuilder<ScannerController>(
        builder: (_) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton.icon(
                    onPressed: controller.scanCard,
                    icon: const Icon(Icons.credit_card_rounded),
                    label: const Text(
                      'Scan Card',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      elevation: 4,
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton.icon(
                    onPressed: controller.scanPassbook,
                    icon: const Icon(Icons.account_balance_rounded),
                    label: const Text(
                      'Scan Passbook',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      elevation: 4,
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                if (controller.imageFile != null)
                  Image.file(controller.imageFile!, height: 250),
                const SizedBox(height: 20),
                if (controller.isLoading) const CircularProgressIndicator(),
                if (controller.cardDetails != null)
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Card Number: ${controller.cardDetails!.cardNumber}',
                          ),
                          Text('Expiry: ${controller.cardDetails!.expiryDate}'),
                          Text('Holder: ${controller.cardDetails!.holderName}'),
                        ],
                      ),
                    ),
                  ),
                if (controller.bankDetails != null)
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Account Name: ${controller.bankDetails!.accountName}',
                          ),
                          Text(
                            'Account Number: ${controller.bankDetails!.accountNumber}',
                          ),
                          Text('IFSC: ${controller.bankDetails!.ifscCode}'),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
