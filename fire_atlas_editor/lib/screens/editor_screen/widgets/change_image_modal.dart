import 'package:fire_atlas_editor/store/actions/atlas_actions.dart';
import 'package:fire_atlas_editor/store/actions/editor_actions.dart';
import 'package:fire_atlas_editor/store/store.dart';
import 'package:fire_atlas_editor/widgets/button.dart';
import 'package:fire_atlas_editor/widgets/image_selection_container.dart';
import 'package:fire_atlas_editor/widgets/text.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:slices/slices.dart';

class ChangeImageModal extends StatefulWidget {
  const ChangeImageModal({super.key});

  @override
  State createState() => _ChangeImageModalState();
}

class _ChangeImageModalState extends State<ChangeImageModal> {
  String? _imageData;

  @override
  Widget build(BuildContext ctx) {
    final store = SlicesProvider.of<FireAtlasState>(ctx);
    return Column(
      children: [
        const FSubtitleTitle(title: 'Update image'),
        Expanded(
          child: ImageSelectionContainer(
            margin: const EdgeInsets.all(30),
            imageData: _imageData,
            onSelectImage: (imageData) {
              Flame.images.clearCache();
              setState(() {
                _imageData = imageData;
              });
            },
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FButton(
              label: 'Cancel',
              onSelect: () {
                store.dispatch(CloseEditorModal());
              },
            ),
            FButton(
              disabled: _imageData == null,
              selected: true,
              label: 'Ok',
              onSelect: () {
                store.dispatch(CloseEditorModal());
                store.dispatchAsync(
                  UpdateAtlasImageAction(
                    imageData: _imageData!,
                  ),
                );
              },
            ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
