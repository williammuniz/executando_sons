import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';


void main() =>
    runApp(MaterialApp(
      home: Home(),
    ));

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AudioPlayer audioPlayer = AudioPlayer();
  AudioCache audioCache = AudioCache();
  bool primeiraExecucao = true;
  double volume = 0.5;

  _executar() async {
    audioPlayer.setVolume(volume);
    if(primeiraExecucao){
      audioPlayer = await audioCache.play("audios/musica.mp3");
      primeiraExecucao = false;
    }else{
      audioPlayer.resume();
    }
  }

  _pausar() async {
    int resultado = await audioPlayer.pause();
  }

  _parar() async {
    int resultado = await audioPlayer.stop();
    primeiraExecucao = true;
  }

  @override
  Widget build(BuildContext context) {
    // _executar();
    return Scaffold(
      appBar: AppBar(
        title: Text("Executando sons"),
      ),
      body: Column(
        children: [
          Slider(
              value: volume,
              min: 0,
              max: 1,
              onChanged: (novoVolume){
                setState((){
                  volume = novoVolume;
                });
                audioPlayer.setVolume(novoVolume);
              }),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(8),
                child: GestureDetector(
                  onTap: (){
                    _executar();
                  },
                  child: Image.asset("assets/images/executar.png"),
                )                ,
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: GestureDetector(
                  onTap: (){
                    _pausar();
                  },
                  child: Image.asset("assets/images/pausar.png"),
                )                ,
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: GestureDetector(
                  onTap: (){
                    _parar();
                  },
                  child: Image.asset("assets/images/parar.png"),
                )                ,
              ),

            ],
          )
        ],
      ),
    );
  }
}
