import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bienvenidos a flutter',
      home: RandomWords(),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RandomWordsState();
  }
}

class RandomWordsState extends State<RandomWords> {
  //Lista de palabras
  final _sugggestions = <WordPair>[];
  // Lista de palabras guardadas con set no permite palabras repetidasrc
  final _saved = Set<WordPair>();
  // Fuente para el texto
  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    // Genera papabras aleatorias

    return Scaffold(
      appBar: AppBar(
        title: Text('Startup generador de putos'),
      ),
      body: _buildSuggestion(),
    );
  }

  Widget _buildSuggestion() {
    // Retona un lista de pareja de palabras
    return ListView.builder(
        // Inserta margenes a las palabras en la lista
        padding: const EdgeInsets.all(16.0),
        // Constructor
        itemBuilder: (context, i) {
          // Agrega linea divisioria a cada elemento de la lista
          if (i.isOdd) {
            return Divider();
          }
          // si la lista llega al final se generan 10 palabras mas para la lista
          if (i >= _sugggestions.length) {
            // Funcion que genera 10 palabras mas en la lista
            _sugggestions.addAll(generateWordPairs().take(10));
          }
          final index = i ~/ 2;
          // Funcion que crea el objeto que se vizualisa con la lista de palabras
          return _buildRow(_sugggestions[index]);
        });
  }

// Funcion que crea el objeto que se muestra como lista
  Widget _buildRow(WordPair pair) {
    // Variable que contiene si respuesta de si la palabra ya se encuentra en el Set
    final alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(
        // Si la palabra esta en la lista pinta el corazon lleno si no vacio
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        // Si esta en la lista muestra el corazon rojo si no nada
        color: alreadySaved ? Colors.red : null,
      ),
      // Accion cuando se presiona el boton
      onTap: () {
        // Configura el estado dependiendo de si la palabra esta o no en la lista
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }
}
