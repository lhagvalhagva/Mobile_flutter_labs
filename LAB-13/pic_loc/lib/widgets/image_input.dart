import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key, required this.OnTakeImg});
  final Function(File image) OnTakeImg;

  @override
  State<ImageInput> createState() => IimageInputState();
}

class IimageInputState extends State<ImageInput> {
  File? takenImage;
  void _takePhoto() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.camera, maxWidth: 500);
    if (pickedImage == null) {
      debugPrint('No image selected');
      return;
    }
    takenImage = File(pickedImage.path);
    widget.OnTakeImg(takenImage!);
    setState(() {});

  }

  @override
  Widget build(BuildContext context) {
    Widget content = TextButton.icon(
      onPressed: _takePhoto,
      icon: const Icon(Icons.camera),
      label: const Text('Take Photo'),
    );

    if(takenImage != null) {
      content = GestureDetector(
        onTap: _takePhoto,
        child: Image.file(
          takenImage!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Theme.of(context).colorScheme.primary.withOpacity(0.5)
        ),
      ),
      height: 200,
      width: double.infinity,
      alignment: Alignment.center,
      child: content,
    );
  }
}
