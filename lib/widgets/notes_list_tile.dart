import 'package:feather_note/model/note_model.dart';
import 'package:flutter/material.dart';

class NotesListTile extends StatelessWidget {
  const NotesListTile({
    super.key,
    required this.note,
    required this.onTap,
    required this.onDismissed,
    required this.onLongPress,
  });

  final NoteModel note;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  final void Function(DismissDirection direction)? onDismissed;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: GlobalKey(),
      onDismissed: onDismissed,
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        child: Stack(
          children: [
            Container(
              constraints: const BoxConstraints(maxHeight: 100, minHeight: 10),
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 3),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: note.bgColor,
                border: Border.all(width: 2, color: Colors.grey),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    note.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    note.content,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              bottom: 10,
              left: 15,
              child: CircleAvatar(
                radius: 12,
                backgroundColor: Colors.grey,
                child: CircleAvatar(
                  radius: 11,
                  backgroundColor: note.bgColor,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
