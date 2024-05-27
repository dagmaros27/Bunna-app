import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../themes.dart';
import 'processing_card.dart';
import '../../services/image_process_service.dart';

class ImageProcessing extends StatefulWidget {
  final File imageFile;

  const ImageProcessing({super.key, required this.imageFile});

  @override
  _ImageProcessingState createState() => _ImageProcessingState();
}

class _ImageProcessingState extends State<ImageProcessing> {
  bool _showProcessingCard = false;

  _sendData() async {
    processImage(widget.imageFile, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "CODICAP",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              "Selected Image: ",
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
          Center(
            child: Container(
              width: 360,
              height: 400,
              child: Image.file(widget.imageFile),
            ),
          ),
          if (!_showProcessingCard)
            Padding(
              padding: const EdgeInsets.all(24),
              child: Center(
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      _showProcessingCard = true;
                    });
                    _sendData();
                    log("pressed");
                  },
                  child: const Text("Process Image"),
                ),
              ),
            ),
          if (_showProcessingCard) const ProcessingCard(),
        ],
      ),
    );
  }
}
