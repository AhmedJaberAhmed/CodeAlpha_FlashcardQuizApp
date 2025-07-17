part of 'flashcard_cubit.dart';

abstract class FlashcardState extends Equatable {
  const FlashcardState();

  @override
  List<Object?> get props => [];
}

class FlashcardInitial extends FlashcardState {}

class FlashcardLoading extends FlashcardState {}

class FlashcardLoaded extends FlashcardState {
  final List<FlashcardModel> flashcards;

  const FlashcardLoaded(this.flashcards);

  @override
  List<Object?> get props => [flashcards];
}

class FlashcardError extends FlashcardState {
  final String message;

  const FlashcardError(this.message);

  @override
  List<Object?> get props => [message];
}