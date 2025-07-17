import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../views/AddFlashcardPage.dart';
import '../managers/cubits/flashcard_cubit/flashcard_cubit.dart';
import 'FlipCard.dart';

class FlipCardListView extends StatefulWidget {
  const FlipCardListView({super.key});

  @override
  State<FlipCardListView> createState() => _FlipCardListViewState();
}

class _FlipCardListViewState extends State<FlipCardListView> {
  int _currentIndex = 0;
  List _flashcards = [];

  void _nextCard() {
    if (_currentIndex < _flashcards.length - 1) {
      setState(() {
        _currentIndex++;
      });
    }
  }

  void _previousCard() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
      });
    }
  }

  void _shuffleCards() {
    setState(() {
      _flashcards.shuffle();
      _currentIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FlashcardCubit, FlashcardState>(
      builder: (context, state) {
        if (state is FlashcardLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is FlashcardLoaded) {
          _flashcards = state.flashcards;

          if (_flashcards.isEmpty) {
            return const Center(
              child: Text(
                "No flashcards yet.\nTap '+' to add one!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }

          final flashcard = _flashcards[_currentIndex];

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onLongPress: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AddFlashcardPage(flashcard: flashcard),
                    ),
                  );
                },
                child: FlipCard(
                  question: flashcard.question,
                  answer: flashcard.answer,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: _previousCard,
                    icon: const Icon(Icons.arrow_back),
                    label: const Text("Previous"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton.icon(
                    onPressed: _nextCard,
                    icon: const Icon(Icons.arrow_forward),
                    label: const Text("Next"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton.icon(
                    onPressed: _shuffleCards,
                    icon: const Icon(Icons.shuffle),
                    label: const Text("Shuffle"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                '${_currentIndex + 1} of ${_flashcards.length}',
                style: const TextStyle(fontSize: 16),
              ),
            ],
          );
        } else if (state is FlashcardError) {
          return Center(child: Text(state.message));
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
