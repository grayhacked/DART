import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: EcranPrincipal(),
    );
  }
}

class EcranPrincipal extends StatefulWidget {
  @override
  _EcranPrincipalState createState() => _EcranPrincipalState();
}

class _EcranPrincipalState extends State<EcranPrincipal> {
  final List<String> moYo = [
    'Septembre',
    'Algebre',
    'Messi',
    'Attie',
    'Html',
    'Lub'
  ];
  final List<String> endis = [
     "- Le neuvieme mois de l'annee",
    "- Une des matieres des mathematiques",
    "- Le footballeur le plus celebre",
    "- Directeur General de l'ESIH",
    "- Un langage de programmation facile",
    "-Enseignant Flutter"
  ];
  late String moChwazi;
  late String endisLa;
  late String moAfiche;
  final Set<String> letDevine = {};
  int chans = 5;

  @override
  void initState() {
    super.initState();
    resetJwet();
  }

  void devineLet(String let) {
    setState(() {
      if (moChwazi.contains(let)) {
        moAfiche = moAfiche.split('').asMap().entries.map((entry) {
          int index = entry.key;
          String ch = entry.value;
          return moChwazi[index] == let ? let : ch;
        }).join();
      } else {
        chans--;
      }
      letDevine.add(let);
      verifyeEstatiJwet();
    });
  }

  void resetJwet() {
    setState(() {
      int index = Random().nextInt(moYo.length);
      moChwazi = moYo[index].split(' --> ').first.toLowerCase();
      endisLa = endis[index];
      moAfiche = '*' * moChwazi.length;
      letDevine.clear();
      chans = 5;
    });
  }

  void verifyeEstatiJwet() {
    if (moAfiche == moChwazi || chans == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => EkranRezilta(
            resetJwet,
            chans,
            moAfiche == moChwazi,
            moYo
                .firstWhere((mo) =>
                    mo.split(' --> ').first.toLowerCase() ==
                    moChwazi.toLowerCase())
                .split(' - ')
                .last,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jwet Mo Kache'),
        backgroundColor: Colors.blue,
        centerTitle: true,
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Text(
                'Chans: $chans',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Cheche mo kache!*',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              moAfiche.toUpperCase(),
              style: TextStyle(fontSize: 32),
            ),
            SizedBox(height: 10),
            Text(
              endisLa,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 7,
                children: List.generate(26, (index) {
                  String letter = String.fromCharCode('a'.codeUnitAt(0) + index);
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ElevatedButton(
                      onPressed: letDevine.contains(letter) ? null : () => devineLet(letter),
                      child: Text(letter.toUpperCase()),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EkranRezilta extends StatelessWidget {
  final Function() resetJwet;
  final int chansRestan;
  final bool seGanyan;
  final String endis;

  EkranRezilta(
      this.resetJwet, this.chansRestan, this.seGanyan, this.endis);

  @override
  Widget build(BuildContext context) {
    String mesajRezilta = seGanyan ? 'Ou genyen' : 'Ou pedi';
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              mesajRezilta,
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Text(
              'Chans Restan: $chansRestan',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              'Endis: $endis',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EcranPrincipal(),
                      ),
                    );
                  },
                  child: Text('Jwe Anko'),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Kite'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}