import 'package:flutter/material.dart';
import 'package:memorize_flutter/EmojiMemoryGame.dart';

void main() {
  runApp(MemorizeApp());
}

class MemorizeApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Memorize Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ContentPage(),
    );
  }
}

class ContentPage extends StatelessWidget {
  ContentPage({Key? key}) : super(key: key);

  final EmojiMemoryGame _viewModel = EmojiMemoryGame();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Memorize App")),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          childAspectRatio: 3 / 4,
        ),
        itemCount: _viewModel.cards!.length,
        itemBuilder: (context, index) {
          return CardView(content: _viewModel.cards![index].content);
        },
      ),
    );
  }
}

class CardView extends StatelessWidget {
  final String content;
  const CardView({Key? key, required this.content}) : super(key: key);

  final bool isFaceUp = true;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 20,
        height: 50,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          clipBehavior: Clip.antiAlias,
          child: isFaceUp
              ? Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    Container(
                      margin: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    Text(
                      content,
                      style: TextStyle(fontSize: 32),
                    )
                  ],
                )
              : Container(
                  decoration: BoxDecoration(color: Colors.amber),
                ),
        ));
  }
}
