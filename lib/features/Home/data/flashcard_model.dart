class FlashcardModel {
  final int? id;
  final String question;
  final String answer;

  FlashcardModel({this.id, required this.question, required this.answer});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'question': question,
      'answer': answer,
    };
  }

  factory FlashcardModel.fromMap(Map<String, dynamic> map) {
    return FlashcardModel(
      id: map['id'],
      question: map['question'],
      answer: map['answer'],
    );
  }
}
