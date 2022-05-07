import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

import '../generated/l10n.dart';
import '../util/context.dart';

class Pdfview extends StatefulWidget {
  final String path;

  const Pdfview({Key? key, required this.path}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PdfviewState();
}

class _PdfviewState extends State<Pdfview> {
  PdfController? controller;
  PdfControllerPinch? controllerPinch;

  @override
  Widget build(BuildContext context) {
    if (Context.isLinux) return Center(child: Text(S.of(context).notCurrentlySupported));

    if (Context.isWindows) {
      controller = PdfController(document: PdfDocument.openFile(widget.path));

      return PdfView(controller: controller!);
    }

    controllerPinch = PdfControllerPinch(document: PdfDocument.openFile(widget.path));

    return PdfViewPinch(controller: controllerPinch!);
  }

  @override
  void dispose() {
    controller?.dispose();
    controllerPinch?.dispose();
    super.dispose();
  }
}
