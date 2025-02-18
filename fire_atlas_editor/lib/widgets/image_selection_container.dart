import 'dart:ui';

import 'package:fire_atlas_editor/services/storage/storage.dart';
import 'package:fire_atlas_editor/widgets/button.dart';
import 'package:fire_atlas_editor/widgets/container.dart';
import 'package:fire_atlas_editor/widgets/simple_sprite_widget.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart' hide Image;

typedef OnSelectImage = void Function(String);

class ImageSelectionContainer extends StatelessWidget {
  final String? imageData;
  final OnSelectImage onSelectImage;
  final EdgeInsets margin;

  const ImageSelectionContainer({
    required this.onSelectImage,
    this.imageData,
    this.margin = const EdgeInsets.only(
      left: 30,
      right: 2.5,
      top: 2.5,
      bottom: 2.5,
    ),
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: FContainer(
            margin: margin,
            child: imageData != null
                ? FutureBuilder<Image>(
                    // TODO(erick): image name
                    future: Flame.images.fromBase64('', imageData!),
                    builder: (ctx, snapshot) {
                      if (snapshot.hasData) {
                        Flame.images.clearCache();
                        return SizedBox(
                          width: 200,
                          child: SimpleSpriteWidget(
                            sprite: Sprite(snapshot.data!),
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return const Text('Something wrong happened :(');
                      } else {
                        return const Text('Loading');
                      }
                    },
                  )
                : const Center(child: Text('No image selected')),
          ),
        ),
        FButton(
          label: 'Select image',
          onSelect: () async {
            final storage = FireAtlasStorage();
            final imgDataUrl = await storage.selectFile();
            onSelectImage(imgDataUrl);
          },
        )
      ],
    );
  }
}
