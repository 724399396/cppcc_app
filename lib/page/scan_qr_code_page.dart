import 'package:cppcc_app/repository/api_provider.dart';
import 'package:cppcc_app/repository/scan_qr_code_repository.dart';
import 'package:cppcc_app/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mobile_scanner/mobile_scanner.dart';

class ScanQRCodePage extends StatelessWidget {
  const ScanQRCodePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('扫码')),
      body: MobileScanner(
          allowDuplicates: false,
          onDetect: (barcode, args) {
            final String? code = barcode.rawValue;
            debugPrint('Barcode found! $code');
            if (code != null) {
              RepositoryProvider.of<ScanQrCodeRepository>(context)
                  .get(code)
                  .then((value) {
                showToast(value.message);
                Navigator.pop(context);
              }, onError: (e) {
                Navigator.pop(context);
              });
            }
          }),
    );
  }
}
