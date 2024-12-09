import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class AnimatedBalloonWidget extends StatefulWidget {
  @override
  _AnimatedBalloonWidgetState createState() => _AnimatedBalloonWidgetState();
}

class _AnimatedBalloonWidgetState extends State<AnimatedBalloonWidget> with TickerProviderStateMixin {
  late AnimationController _controllerFloatUp;
  late AnimationController _controllerGrowSize;
  late AnimationController _controllerRotation; //controller for rotation
  late AnimationController _controllerPulse;
  late Animation<double> _animationFloatUp;
  late Animation<double> _animationGrowSize;
  late Animation<double> _animationRotation; //animation for rotation
  late Animation<double> _animationPulse;
  late AnimationController _cloudController1;
  late Offset _balloonPosition;
  Offset _dragOffset = Offset.zero;
  final AudioPlayer _soundPlayer = AudioPlayer();



  @override
  void initState() {
    super.initState();
    _controllerFloatUp = AnimationController(duration: Duration(seconds: 8), vsync: this);
    _controllerGrowSize = AnimationController(duration: Duration(seconds: 4), vsync: this);
    _controllerRotation = AnimationController(duration: Duration(seconds: 1), vsync: this); //initialize rotation controller
    _controllerPulse = AnimationController(duration: Duration(seconds: 1), vsync: this);

    _cloudController1 = AnimationController(duration: Duration(seconds: 20), vsync: this);
    _playWindSound();
  }
  Future<void> _playWindSound() async {
    try {
      await _soundPlayer.setVolume(1.0); // Ensure volume is at 100%
      await _soundPlayer.setLoopMode(LoopMode.one); // Loop the sound
      await _soundPlayer.setAsset('lib/assets/sounds/sound.mp3'); // Load 'sound.mp3'
      await _soundPlayer.play(); // Play the sound
      print("Sound started playing"); // Debug print
    } catch (e) {
      print("Error playing sound: $e"); // Print error if something goes wrong
    }
  }



  @override
  void dispose() {
    _controllerFloatUp.dispose();
    _controllerGrowSize.dispose();
    _controllerRotation.dispose();
    _controllerPulse.dispose();
    _cloudController1.dispose();
    _soundPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _balloonHeight = MediaQuery.of(context).size.height / 2;
    double _balloonWidth = MediaQuery.of(context).size.height / 3;
    double _balloonBottomLocation = MediaQuery.of(context).size.height - _balloonHeight;

    _animationFloatUp = Tween(begin: _balloonBottomLocation, end: 0.0).animate(
        CurvedAnimation(parent: _controllerFloatUp, curve: Curves.easeIn) //Adding easeIN
    );

    _animationGrowSize = Tween(begin: 50.0, end: _balloonWidth).animate(
        CurvedAnimation(parent: _controllerGrowSize, curve: Curves.easeOut) //Adding easeOut
    );

    //rotation
    _animationRotation = Tween(begin: -0.1, end: 0.1).animate(
      CurvedAnimation(parent: _controllerRotation, curve: Curves.easeInOutSine),
    )..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controllerRotation.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _controllerRotation.forward();
      }
    });

    // Pulse
    _animationPulse = Tween(begin: 1.0, end: 1.5).animate(
      CurvedAnimation(parent: _controllerPulse, curve: Curves.easeInOut),
    )..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controllerPulse.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _controllerPulse.forward();
      }
    });

    _controllerFloatUp.forward();
    _controllerGrowSize.forward();
    _controllerRotation.forward();
    _controllerPulse.forward();
    _cloudController1.repeat(reverse: false);
    _balloonPosition = Offset(100, 100);

    return Stack(
      children: [
      //clouds
      Positioned(
      top: 100,
      left: -100,
      child: AnimatedCloud(controller: _cloudController1, imagePath: '/Users/limhongthai/Desktop/aupp/animated_controller/lib/assets/images/cloud.png'),
    ),


    AnimatedBuilder(
      animation: _animationFloatUp,
      builder: (context, child) {
        return Container(
          child: child,
          margin: EdgeInsets.only(
            top: _animationFloatUp.value,
          ),
          width: _animationGrowSize.value * _animationPulse.value,
          height: _balloonHeight * _animationPulse.value,
        );
      },

      child: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            _dragOffset += details.delta; // Update drag offset on drag
          });
        },
        onTap: () {
          if (_controllerFloatUp.isCompleted) {
            _controllerFloatUp.reverse();
            _controllerGrowSize.reverse();
            _controllerRotation.reverse();
            _controllerPulse.reverse();

          } else {
            _controllerFloatUp.forward();
            _controllerGrowSize.forward();
            _controllerRotation.forward();
            _controllerPulse.forward();
          }
        },
        child: Transform.translate(
          offset: _dragOffset,
            child: RotationTransition(
              turns: _animationRotation, // Apply rotation to the balloon
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,

                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      offset: Offset(0, 5),
                      blurRadius: 3,
                      spreadRadius: 0.5,
                ),
              ],
            ),
    child: ClipOval(
      child: Image.asset(
          '/Users/limhongthai/Desktop/aupp/animated_controller/lib/assets/images/BeginningGoogleFlutter-Balloon.png',
          height: _balloonHeight,
          width: _balloonWidth,
        ),
      ),
      ),
      ),
      ),

    ),
    ),
    ]);

  }
}
class AnimatedCloud extends StatelessWidget {
  final AnimationController controller;
  final String imagePath;

  AnimatedCloud({required this.controller, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    final animation = Tween<Offset>(begin: Offset(-1.5, 0), end: Offset(1.5, 0)).animate(controller);

    return SlideTransition(
      position: animation,
      child: Image.asset(
        imagePath,
        width: 200,
        fit: BoxFit.cover,
      ),
    );
  }
}
