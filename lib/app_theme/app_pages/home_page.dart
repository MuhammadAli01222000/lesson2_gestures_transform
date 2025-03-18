import 'package:flutter/material.dart';
import 'package:lesson2_gestures_transform/app_theme/theme/dimens.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:lottie/lottie.dart';

/// Rasmlar
const imgPath = "asset/images/farm.png";
const chelak = "asset/images/img_1.png";
const bochka = "asset/images/img_3.png";
const quduq = "asset/images/img.png";
const flower = "asset/images/img_2.png";
const honey = "asset/images/img_4.png";

///sound effect
const sound = "asset/sound/water.wav";
//animation
const fire = "asset/animation/Animation - 1742273085741.json";

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomeScreen());
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _audioPlayer = AudioPlayer();

  Future<void> playSound() async {
    await _audioPlayer.play(AssetSource(sound));
  }

  @override
  void initState() {
    super.initState();
  }

  //play qismi
  Future<void> _play() async {
    await _audioPlayer.seek(Duration(seconds: 3));
    await _audioPlayer.play(sound as Source);
  }

  double count = 0;
  Widget buildWaterFilling(double height) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        height: height != 200 ? height : height = 0,
        width: double.infinity,
        decoration: BoxDecoration(
          color: count != 8 ? Colors.blue.withOpacity(0.7) : Colors.transparent,
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        title: count != 8 ? TextFire(count: count) : TextHero(),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          /// Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imgPath),
                fit: BoxFit.cover,
              ),
            ),
          ),

          Align(
            alignment: Alignment.bottomLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Draggable(
                  child: Image.asset(
                    quduq,
                    fit: BoxFit.contain,
                    width: AppDimens.d100 + 150,
                    height: AppDimens.d100 + 150,
                  ),
                  feedback: Image.asset(
                    chelak,
                    fit: BoxFit.contain,
                    width: AppDimens.d100,
                    height: AppDimens.d100,
                  ),
                  onDragCompleted: () {
                    setState(() {
                      count == 8 ? count = 0 : count++;
                      _play();
                    });
                    _play();
                  },
                ),

                const SizedBox(height: 20),

                count == 8
                    ? Image.asset(honey, width: 150, height: 150)
                    : Text(""),

                const SizedBox(height: 10),

                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    height: AppDimens.d100 + 100,
                    width: AppDimens.d100,

                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        DragTarget<Color>(
                          builder: (context, accepted, rejected) {
                            return Stack(
                              children: [
                                Positioned(
                                  child:
                                      count != 8
                                          ? FireAnimationWidget()
                                          : FlowerWidget(),
                                  right: 0.4,
                                  left: 0.5,
                                  top: 16,
                                ),
                                buildWaterFilling(count * 10),
                              ],
                            );
                          },
                          onWillAccept: (color) {
                            return true;
                          },

                          onAccept: (color) {
                            setState(() {
                              count++;
                            });
                            _play();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TextFire extends StatelessWidget {
  double count;
  TextFire({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    return Text(
      "Help the animals on the farm. Put out the fire. Pour ${8 - count} buckets of water on the fire.",
      style: TextStyle(
        color: Colors.red,
        fontWeight: FontWeight.bold,
        fontSize: 25,
      ),
    );
  }
}

class TextHero extends StatelessWidget {
  const TextHero({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "You are a Hero",
      style: TextStyle(
        color: Colors.green,
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class FlowerWidget extends StatelessWidget {
  const FlowerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(flower, fit: BoxFit.contain, width: 200, height: 200);
  }
}

class FireAnimationWidget extends StatelessWidget {
  const FireAnimationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(-0.5, 1),
      child: Lottie.asset(fire, width: 150, height: 250),
    );
  }
}
