import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PDFview extends StatefulWidget {
  final String name;
  const PDFview({super.key, required this.name});

  @override
  State<PDFview> createState() => _PDFviewState();
}

class _PDFviewState extends State<PDFview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Visualización del PDF")),
      body: SfPdfViewer.network(
        widget.name,
        // key: pdfViewerKey,
        initialScrollOffset: Offset.infinite,
      ),
    );
  }
}
