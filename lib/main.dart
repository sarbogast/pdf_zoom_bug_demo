import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _pdfViewerController = PdfViewerController();
  bool _zoomMode = false;
  double? _backedUpZoomLevel;

  void _toggleZoomMode() {
    if (_zoomMode) {
      _pdfViewerController.zoomLevel = _backedUpZoomLevel!;
    } else {
      _backedUpZoomLevel = _pdfViewerController.zoomLevel;
    }
    setState(() {
      _zoomMode = !_zoomMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: SfPdfViewer.asset(
              'assets/pdf/score.pdf',
              controller: _pdfViewerController,
              enableDoubleTapZooming: _zoomMode,
              pageLayoutMode: PdfPageLayoutMode.single,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleZoomMode,
        tooltip: 'Zoom',
        child: Icon(_zoomMode ? Icons.zoom_out : Icons.zoom_in),
      ),
    );
  }
}
