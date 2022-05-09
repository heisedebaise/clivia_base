import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

import '../util/context.dart';
import '../util/l10n.dart';

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
    if (Context.isLinux) return Center(child: Text(l10n(context, 'not-currently-supported')));

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
