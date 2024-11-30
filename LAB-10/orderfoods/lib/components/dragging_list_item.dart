import 'package:flutter/material.dart';

class DraggingListItem extends StatelessWidget {
  const DraggingListItem({
    super.key,
    required this.dragKey,
    required this.photoProvider,
  });

  final GlobalKey dragKey;
  final ImageProvider photoProvider;

  @override
  Widget build(BuildContext context) {
    // FractionalTranslation нь child widget-ийг өгөгдсөн хэмжээгээр шилжүүлдэг
    // translation: Offset(-0.5, -0.5) гэвэл:
    // x тэнхлэгт: -0.5 буюу зүүн тийш widget-ийн өргөний 50% хэмжээгээр
    // y тэнхлэгт: -0.5 буюу дээш widget-ийн өндрийн 50% хэмжээгээр шилжинэ
    return FractionalTranslation(
      translation: const Offset(-0.5, -0.5),
      child: ClipRRect(
        key: dragKey,
        borderRadius: BorderRadius.circular(12),
        child: SizedBox(
          height: 150,
          width: 150,
          child: Opacity(
            opacity: 0.85,
            child: Image(
              image: photoProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
} 