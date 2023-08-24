import 'package:fire_atlas_editor/store/actions/atlas_actions.dart';
import 'package:fire_atlas_editor/store/actions/editor_actions.dart';
import 'package:fire_atlas_editor/store/store.dart';
import 'package:fire_atlas_editor/widgets/button.dart';
import 'package:fire_atlas_editor/widgets/input_text_row.dart';
import 'package:fire_atlas_editor/widgets/text.dart';
import 'package:flame_fire_atlas/flame_fire_atlas.dart';
import 'package:flutter/material.dart';
import 'package:slices/slices.dart';

class RenameSelectionModal extends StatefulWidget {
  const RenameSelectionModal({
    required this.selection,
    super.key,
  });
  final BaseSelection selection;
  @override
  State<RenameSelectionModal> createState() => _RenameSelectionModalState();
}

class _RenameSelectionModalState extends State<RenameSelectionModal> {
  late final _nameController = TextEditingController(
    text: widget.selection.id,
  );
  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext ctx) {
    final store = SlicesProvider.of<FireAtlasState>(ctx);
    void closeModal() => store.dispatch(CloseEditorModal());

    void rename() {
      final action = RenameSelectionAction(
        selection: widget.selection.copyWith(id: _nameController.text),
      );
      store.dispatch(action);
      closeModal();
    }

    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
      child: Column(
        children: [
          const FSubtitleTitle(title: 'Rename selection'),
          InputTextRow(
            label: 'New name:',
            inputController: _nameController,
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FButton(
                label: 'Cancel',
                onSelect: closeModal,
              ),
              const SizedBox(width: 20),
              FButton(
                label: 'Rename',
                onSelect: rename,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
