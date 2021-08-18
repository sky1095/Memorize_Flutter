class MemoryGame<T> {
  List<EmojiCard<T>>? _cards;

  List<EmojiCard<T>>? get cards => _cards;

  int? firstPickedAndFaceUpCard;

  MemoryGame.init(
      {required int numberOfPairsOfCards,
      required T Function(int) createCardContent}) {
    _cards = <EmojiCard<T>>[];
    for (int pairIndex = 0;
        pairIndex < numberOfPairsOfCards;
        ++numberOfPairsOfCards) {
      var content = createCardContent(pairIndex);
      cards?.add(EmojiCard(content: content, id: pairIndex * 2));
      cards?.add(EmojiCard(content: content, id: (pairIndex * 2) + 1));
    }
  }

  void choose(EmojiCard<T> card) {
    int? choosenIndex = _cards?.indexWhere((element) => element.id == card.id);
    if (!choosenIndex!.isNegative &&
        !_cards![choosenIndex].isFaceUp &&
        !_cards![choosenIndex].isMatched) {
      int potentialMatchedIndex = firstPickedAndFaceUpCard!;
      if (potentialMatchedIndex == null) {
        if (_cards![choosenIndex].content ==
            _cards![potentialMatchedIndex].content) {
          _cards![choosenIndex].isMatched = true;
          _cards![potentialMatchedIndex].isMatched = true;
        }
        firstPickedAndFaceUpCard = null;
      } else {
        for (EmojiCard<T> card in _cards!) {
          card.isFaceUp = false;
        }
        firstPickedAndFaceUpCard = choosenIndex;
      }
      _cards![choosenIndex].isFaceUp = !_cards![choosenIndex].isFaceUp;
    }
  }
}

class EmojiCard<T> {
  int id;
  bool isFaceUp;
  bool isMatched;
  T content;

  EmojiCard({
    required this.id,
    this.isFaceUp = false,
    this.isMatched = false,
    required this.content,
  });
}
