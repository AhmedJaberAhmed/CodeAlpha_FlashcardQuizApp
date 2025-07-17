import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../utils/database_helper.dart';
import '../../../../data/flashcard_model.dart';

part 'flashcard_state.dart';




class FlashcardCubit extends Cubit<FlashcardState> {
  final LocalDatabase localDatabase;

  FlashcardCubit(this.localDatabase) : super(FlashcardInitial());

  Future<void> loadFlashcards() async {
    try {
      emit(FlashcardLoading());
      final flashcards = await localDatabase.getAllFlashcards();
      emit(FlashcardLoaded(flashcards));
    } catch (e) {
      emit(FlashcardError('Failed to load flashcards'));
    }
  }

  Future<void> addFlashcard(FlashcardModel model) async {
    await localDatabase.insertFlashcard(model);
    await loadFlashcards();
  }

  Future<void> updateFlashcard(FlashcardModel model) async {
    await localDatabase.updateFlashcard(model);
    await loadFlashcards();
  }

  Future<void> deleteFlashcard(int id) async {
    await localDatabase.deleteFlashcard(id);
    await loadFlashcards();
  }
}