import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../data/flashcard_model.dart';
import '../managers/cubits/flashcard_cubit/flashcard_cubit.dart';

class AddFlashcardPage extends StatefulWidget {
  final FlashcardModel? flashcard;

  const AddFlashcardPage({super.key, this.flashcard});

  @override
  State<AddFlashcardPage> createState() => _AddFlashcardPageState();
}

class _AddFlashcardPageState extends State<AddFlashcardPage> {
  late final TextEditingController _questionController;
  late final TextEditingController _answerController;

  @override
  void initState() {
    super.initState();
    _questionController = TextEditingController(
      text: widget.flashcard?.question ?? '',
    );
    _answerController = TextEditingController(
      text: widget.flashcard?.answer ?? '',
    );
  }

  @override
  void dispose() {
    _questionController.dispose();
    _answerController.dispose();
    super.dispose();
  }

  void _saveFlashcard() {
    final question = _questionController.text.trim();
    final answer = _answerController.text.trim();

    if (question.isNotEmpty && answer.isNotEmpty) {
      final flashcard = FlashcardModel(
        id: widget.flashcard?.id,
        question: question,
        answer: answer,
      );

      if (widget.flashcard == null) {
        context.read<FlashcardCubit>().addFlashcard(flashcard);
      } else {
        context.read<FlashcardCubit>().updateFlashcard(flashcard);
      }

      Navigator.pop(context);

      // Toast instead of SnackBar
      Fluttertoast.showToast(
        msg: widget.flashcard == null
            ? "Flashcard added!"
            : "Flashcard updated!",
        backgroundColor: Colors.greenAccent,
        textColor: Colors.black,
      );
    }
  }

  void _deleteFlashcard() {
    if (widget.flashcard != null && widget.flashcard!.id != null) {
      context.read<FlashcardCubit>().deleteFlashcard(widget.flashcard!.id!);
      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Flashcard deleted!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.flashcard != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? "Edit Flashcard" : "Add Flashcard"),
        backgroundColor: Color(0xFF1DA1F2),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              "Fill out the flashcard information",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: _questionController,
              decoration: const InputDecoration(
                labelText: 'Question',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _answerController,
              decoration: const InputDecoration(
                labelText: 'Answer',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                if (isEditing)
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.delete, color: Colors.white),
                      label: const Text("Delete"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: _deleteFlashcard,
                    ),
                  ),
                if (isEditing) const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.save, color: Colors.white),
                    label: Text(isEditing ? "Update" : "Save Flashcard"),
                    onPressed: _saveFlashcard,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF1DA1F2),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
