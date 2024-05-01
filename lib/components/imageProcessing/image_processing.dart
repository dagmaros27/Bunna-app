import 'package:flutter/material.dart';
import '../../themes.dart';
import 'processing_card.dart';

class ImageProcessing extends StatefulWidget {
  const ImageProcessing({super.key});

  @override
  _ImageProcessingState createState() => _ImageProcessingState();
}

class _ImageProcessingState extends State<ImageProcessing> {
  bool _showProcessingCard = false;

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
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                image: DecorationImage(
                  image: AssetImage('assets/images/coffee_image.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
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
