// ignore_for_file: dead_code, unused_local_variable, avoid_print

import 'dart:math';

import 'package:circleuis/wheel_models.dart';
import 'package:flutter/material.dart';

// Lists with all states
List<bool> isRequiredReady = List.filled(5, false);
List<bool> isAdditionalReady = List.filled(21, false);

// wheel counts
int n = 4;
int m = 7;

String hand = '';
String letter = '';

// for moving between pages
bool lookingAtRequired = true;
bool toggle = false;
bool startDoing = false;
int _selectedModeIndex = 0;

class HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    isRequiredReady.last = true;
    isAdditionalReady.last = true;
    if (isRequiredReady.contains(false)) {
      setState(() {
        if (isRequiredReady.contains(false)) {
          n = isRequiredReady.lastIndexWhere((element) => element == false) + 1;
        }
      });
      setState(() {
        startDoing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () => setState(() {
          n = 5;
          m = 9;
        }),
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildRequiredOrAdditionalButtons(),
                if (lookingAtRequired) ...[
                  _buildRequiredWheel(),
                ] else ...[
                  _buildAdditionalModes(),
                  _buildAdditionalNamesAndOrSet1and2Buttons(),
                  _buildAdditionalWheel(),
                ],
                const SizedBox(height: 50),
                Container(
                    color: Colors.blue.withOpacity(0.6),
                    padding: const EdgeInsets.all(20),
                    child: const Center(
                        child: Text('Description', style: TextStyle(color: Colors.red, fontSize: 25)))),
                Container(
                  color: Colors.blue.withOpacity(0.6),
                  padding: const EdgeInsets.all(20),
                  child: const Text(
                      "This is an example of two circle UIs I've built. Since this is taken out of"
                      " a project and is made to be usable as a template, the colors aren't made to look nice. "
                      "Make sure you keep a look at the output of the program since some features have been"
                      " removed that would usually interrupt the flow of the program. \n\n All Required items "
                      "must be completed by clicking in the Center and then stopping first, before you can go to"
                      " Additional. If you click away on the screen, the focus is lost. so that's why everything "
                      "disappears. The style is different on the two circle UIs. On the first one, you have a "
                      "fancier highlight but no immediate feedback on completion, so you have to click on another"
                      " item to see the change in completion state. \n\nOn the second UI, there are 3 sets, with"
                      " 3 different sets of items which each needs completion individually. The first Set has "
                      "two sets in addition to it. The Second and Third Set intentionally have only 2 items. ",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white)),
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRequiredOrAdditionalButtons() {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: Colors.grey,
            border: Border.all(
              color: Colors.white,
            ),
            borderRadius: BorderRadius.circular(80),
          ),
          child: Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () => startDoing
                      ? null
                      : setState(() {
                          lookingAtRequired = true;
                        }),
                  child: Container(
                    height: 50,
                    decoration: lookingAtRequired
                        ? BoxDecoration(
                            color: Colors.orangeAccent,
                            border: Border.all(
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(80),
                          )
                        : const BoxDecoration(),
                    child: const Center(
                      child: Text(
                        'Required',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    {
                      if (isRequiredReady.contains(false)) {
                        print('you must finish required first');
                      } else {
                        startDoing
                            ? null
                            : setState(() {
                                lookingAtRequired = false;
                                m = 7;
                                _selectedModeIndex = 0;
                              });
                      }
                    }
                  },
                  child: Container(
                    height: 50,
                    decoration: !lookingAtRequired
                        ? BoxDecoration(
                            color: Colors.orangeAccent,
                            border: Border.all(
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(80),
                          )
                        : const BoxDecoration(),
                    child: const Center(
                      child: Text(
                        'Additional',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRequiredWheel() {
    final w = MediaQuery.of(context).size.width;
    const h = fourWheelPieceSize * 2 + 20;
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: SizedBox(
        height: fourWheelPieceSize * 2 + 20,
        child: Align(
          alignment: Alignment.topLeft,
          child: Stack(
            children: <Widget>[
              // the four wheel pieces
              Positioned(
                left: w / 2 + (fourWheelPieceSize * (sqrt(2) - 1)) / 2,
                top: h / 2 - fourWheelPieceSize / 2,
                child: Transform.rotate(
                  angle: pi / 4,
                  child: CustomPaint(
                    painter:
                        n == 3 ? const FourWheelPainter(isActive: true) : const FourWheelPainter(isActive: false),
                    child: ClipPath(
                      clipper: FourWheelPieceShape(),
                      child: InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () => startDoing
                            ? null
                            : setState(() {
                                n = 3;
                              }),
                        child: Container(
                          padding: const EdgeInsets.only(left: 22, bottom: 22),
                          height: fourWheelPieceSize,
                          width: fourWheelPieceSize,
                          decoration: n == 3
                              ? BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Theme.of(context).cardColor.withOpacity(0.3),
                                  boxShadow: [
                                    BoxShadow(
                                      blurStyle: BlurStyle.outer,
                                      blurRadius: 40,
                                      spreadRadius: -5.0,
                                      color: Colors.white.withOpacity(0.8),
                                    ),
                                    BoxShadow(
                                      offset: const Offset(-15, 15),
                                      blurStyle: BlurStyle.outer,
                                      blurRadius: 40,
                                      spreadRadius: -20.0,
                                      color: Colors.white.withOpacity(0.8),
                                    ),
                                  ],
                                )
                              : isRequiredReady[3 - 1]
                                  ? BoxDecoration(
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          offset: const Offset(-50, 50),
                                          blurStyle: BlurStyle.inner,
                                          blurRadius: 1000,
                                          spreadRadius: 50,
                                          color: Colors.lightGreenAccent.withOpacity(0.5),
                                        ),
                                      ],
                                    )
                                  : null,
                          alignment: Alignment.center,
                          child: Transform.rotate(
                            angle: -pi / 4,
                            child: Container(
                              height: iconBoxSize,
                              width: iconBoxSize,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color.fromRGBO(22, 41, 128, 1),
                              ),
                              child: getRequiredIcon(3),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: w / 2 - fourWheelPieceSize / 2,
                top: h / 2 + (fourWheelPieceSize * (sqrt(2) - 1)) / 2,
                child: Transform.rotate(
                  angle: pi * 3 / 4,
                  child: CustomPaint(
                    painter:
                        n == 2 ? const FourWheelPainter(isActive: true) : const FourWheelPainter(isActive: false),
                    child: ClipPath(
                      clipper: FourWheelPieceShape(),
                      child: InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () => startDoing
                            ? null
                            : setState(() {
                                n = 2;
                              }),
                        customBorder: FourWheelInkWellShape(),
                        child: Container(
                          padding: const EdgeInsets.only(left: 22, bottom: 22),
                          height: fourWheelPieceSize,
                          width: fourWheelPieceSize,
                          decoration: n == 2
                              ? BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Theme.of(context).cardColor.withOpacity(0.3),
                                  boxShadow: [
                                    BoxShadow(
                                      blurStyle: BlurStyle.outer,
                                      blurRadius: 40,
                                      spreadRadius: -5.0,
                                      color: Colors.white.withOpacity(0.8),
                                    ),
                                    BoxShadow(
                                      offset: const Offset(-15, 15),
                                      blurStyle: BlurStyle.outer,
                                      blurRadius: 40,
                                      spreadRadius: -20.0,
                                      color: Colors.white.withOpacity(0.8),
                                    ),
                                  ],
                                )
                              : isRequiredReady[2 - 1]
                                  ? BoxDecoration(
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          offset: const Offset(-50, 50),
                                          blurStyle: BlurStyle.inner,
                                          blurRadius: 1000,
                                          spreadRadius: 50,
                                          color: Colors.lightGreenAccent.withOpacity(0.5),
                                        ),
                                      ],
                                    )
                                  : null,
                          alignment: Alignment.center,
                          child: Transform.rotate(
                            angle: -pi * 3 / 4,
                            child: Container(
                              height: iconBoxSize,
                              width: iconBoxSize,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color.fromRGBO(22, 41, 128, 1),
                              ),
                              child: getRequiredIcon(2),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                right: w / 2 + (fourWheelPieceSize * (sqrt(2) - 1)) / 2,
                top: h / 2 - fourWheelPieceSize / 2,
                child: Transform.rotate(
                  angle: -pi * 3 / 4,
                  child: CustomPaint(
                    painter:
                        n == 1 ? const FourWheelPainter(isActive: true) : const FourWheelPainter(isActive: false),
                    child: ClipPath(
                      clipper: FourWheelPieceShape(),
                      child: InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () => startDoing
                            ? null
                            : setState(() {
                                n = 1;
                              }),
                        customBorder: FourWheelInkWellShape(),
                        child: Container(
                          padding: const EdgeInsets.only(left: 22, bottom: 22),
                          height: fourWheelPieceSize,
                          width: fourWheelPieceSize,
                          decoration: n == 1
                              ? BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Theme.of(context).cardColor.withOpacity(0.3),
                                  boxShadow: [
                                    BoxShadow(
                                      blurStyle: BlurStyle.outer,
                                      blurRadius: 40,
                                      spreadRadius: -5.0,
                                      color: Colors.white.withOpacity(0.8),
                                    ),
                                    BoxShadow(
                                      offset: const Offset(-15, 15),
                                      blurStyle: BlurStyle.outer,
                                      blurRadius: 40,
                                      spreadRadius: -20.0,
                                      color: Colors.white.withOpacity(0.8),
                                    ),
                                  ],
                                )
                              : isRequiredReady[1 - 1]
                                  ? BoxDecoration(
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          offset: const Offset(-50, 50),
                                          blurStyle: BlurStyle.inner,
                                          blurRadius: 1000,
                                          spreadRadius: 50,
                                          color: Colors.lightGreenAccent.withOpacity(0.5),
                                        ),
                                      ],
                                    )
                                  : null,
                          alignment: Alignment.center,
                          child: Transform.rotate(
                            angle: pi * 3 / 4,
                            child: Container(
                              height: iconBoxSize,
                              width: iconBoxSize,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color.fromRGBO(22, 41, 128, 1),
                              ),
                              child: getRequiredIcon(1),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: w / 2 - fourWheelPieceSize / 2,
                top: (h - fourWheelPieceSize * (sqrt(2) + 1)) / 2,
                child: Transform.rotate(
                  angle: -pi / 4,
                  child: CustomPaint(
                    painter:
                        n == 4 ? const FourWheelPainter(isActive: true) : const FourWheelPainter(isActive: false),
                    child: ClipPath(
                      clipper: FourWheelPieceShape(),
                      child: InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () => startDoing
                            ? null
                            : setState(() {
                                n = 4;
                              }),
                        customBorder: FourWheelInkWellShape(),
                        child: Container(
                          padding: const EdgeInsets.only(left: 22, bottom: 22),
                          height: fourWheelPieceSize,
                          width: fourWheelPieceSize,
                          decoration: n == 4
                              ? BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Theme.of(context).cardColor.withOpacity(0.3),
                                  boxShadow: [
                                    BoxShadow(
                                      blurStyle: BlurStyle.outer,
                                      blurRadius: 40,
                                      spreadRadius: -5.0,
                                      color: Colors.white.withOpacity(0.8),
                                    ),
                                    BoxShadow(
                                      offset: const Offset(-15, 15),
                                      blurStyle: BlurStyle.outer,
                                      blurRadius: 40,
                                      spreadRadius: -20.0,
                                      color: Colors.white.withOpacity(0.8),
                                    ),
                                  ],
                                )
                              : isRequiredReady[4 - 1]
                                  ? BoxDecoration(
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          offset: const Offset(-50, 50),
                                          blurStyle: BlurStyle.inner,
                                          blurRadius: 1000,
                                          spreadRadius: 50,
                                          color: Colors.lightGreenAccent.withOpacity(0.5),
                                        ),
                                      ],
                                    )
                                  : null,
                          alignment: Alignment.center,
                          child: Transform.rotate(
                            angle: pi / 4,
                            child: Container(
                              height: iconBoxSize,
                              width: iconBoxSize,
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color.fromRGBO(22, 41, 128, 1),
                              ),
                              child: getRequiredIcon(4),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // the circular progress indicator
              if (startDoing)
                Positioned(
                  left: w / 2 - fourWheelCenterRadius,
                  top: h / 2 - fourWheelCenterRadius,
                  child: const SizedBox(
                    height: fourWheelCenterRadius * 2,
                    width: fourWheelCenterRadius * 2,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                      strokeWidth: 8,
                    ),
                  ),
                ),
              // the 'go' button
              Positioned(
                left: w / 2 - fourWheelCenterRadius,
                top: h / 2 - fourWheelCenterRadius,
                child: InkWell(
                  onTap: () async {
                    if (n < 5) {
                      if (isRequiredReady.contains(false) &&
                          isRequiredReady.lastIndexWhere((element) => element == false) > n - 1) {
                        print('error');
                      } else {
                        setState(() {
                          startDoing = !startDoing;
                        });
                        await doSomething();
                      }
                    }
                  },
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  customBorder: FourWheelInkWellShape(),
                  child: Container(
                    height: fourWheelCenterRadius * 2,
                    width: fourWheelCenterRadius * 2,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: isRequiredReady[n - 1] ? 6 : 2,
                        color: startDoing
                            ? Colors.transparent
                            : n == 5
                                ? Colors.transparent
                                : isRequiredReady[n - 1]
                                    ? Colors.orangeAccent
                                    : Colors.yellow,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Stack(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: getRequiredIcon(n),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 15,
                          ),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Text(
                              startDoing
                                  ? 'STOP'
                                  : n == 5
                                      ? ''
                                      : isRequiredReady[n - 1]
                                          ? 'Reset'
                                          : 'GO!',
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 25, color: Colors.orangeAccent),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getRequiredIcon(int n) {
    return SizedBox(
      height: eightWheelCenterRadius * 2 - 150,
      width: eightWheelCenterRadius * 2 - 150,
      child: Stack(
        children: [
          Center(child: Text(n.toString(), style: const TextStyle(color: Colors.red))),
          Center(
            child: Icon(const IconData(0xf3dc, fontFamily: 'MaterialIcons'),
                size: eightWheelCenterRadius * 2 - 150, color: Colors.white),
          ),
        ],
      ),
    );

    var path = '';
    switch (n) {
      case 1:
        {
          path = 'assets/img$n-$letter.svg';
          break;
        }
      case 2:
        {
          path = 'assets/img$n-$letter.svg';
          break;
        }
      case 3:
        {
          path = 'assets/img$n-$letter.svg';
          break;
        }
      case 4:
        {
          path = 'assets/img$n-$letter.svg';
          break;
        }
    }
    // if (path != '') {
    //   return SvgPicture.asset(
    //     path,
    //     width: fourWheelCenterRadius * 2 - 80,
    //     height: fourWheelCenterRadius * 2 - 80,
    //   );
    // }

    return Container();
  }

  Widget buildRequiredNames() {
    return Align(
      alignment: Alignment.topCenter,
      child: Text(
        n == 4
            ? 'Set1'
            : n == 3
                ? 'Set2'
                : n == 2
                    ? 'Set3'
                    : n == 1
                        ? 'Set4'
                        : '',
        style: const TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }

  Future<void> doSomething() async {
    print('Under Development');
    while (startDoing == true) {
      await Future.delayed(const Duration(milliseconds: 25), () {});
    }
    if (lookingAtRequired) {
      setState(() {
        isRequiredReady[n - 1] = true;
        for (var i = 0; i < n - 1; i++) {
          isRequiredReady[i] = false;
        }
        for (var i = 0; i < isAdditionalReady.length - 1; i++) {
          isAdditionalReady[i] = false;
        }
      });
    } else {
      setState(() {
        isAdditionalReady[getAdditionalIndex()] = true;
      });
    }
  }

  Widget _buildAdditionalNamesAndOrSet1and2Buttons() {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
      child: _selectedModeIndex == 0
          ? Row(
              children: [
                Container(
                  height: 35,
                  width: 160,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(22, 41, 128, 1),
                    border: Border.all(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () => startDoing
                              ? null
                              : setState(() {
                                  m = 7;
                                  toggle = true;
                                }),
                          child: Container(
                            height: 35,
                            width: 80,
                            padding: const EdgeInsets.only(
                              left: 15,
                              right: 15,
                              top: 5,
                              bottom: 5,
                            ),
                            decoration: toggle
                                ? BoxDecoration(
                                    color: Theme.of(context).cardColor,
                                    border: Border.all(
                                      color: Colors.white,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                  )
                                : const BoxDecoration(),
                            child: const Center(
                              child: Text(
                                'Set 1',
                                style: TextStyle(
                                  fontSize: 10,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () => startDoing
                              ? null
                              : setState(() {
                                  m = 7;
                                  toggle = false;
                                }),
                          child: Container(
                            height: 35,
                            width: 80,
                            padding: const EdgeInsets.only(
                              left: 15,
                              right: 15,
                              top: 5,
                              bottom: 5,
                            ),
                            decoration: !toggle
                                ? BoxDecoration(
                                    color: Theme.of(context).cardColor,
                                    border: Border.all(
                                      color: Colors.white,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                  )
                                : const BoxDecoration(),
                            child: const Center(
                              child: Text(
                                'Set2',
                                style: TextStyle(
                                  fontSize: 10,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(child: Container()),
                Container(
                  padding: const EdgeInsets.only(
                    left: 15,
                    right: 15,
                    top: 5,
                    bottom: 5,
                  ),
                  height: 35,
                  width: 160,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(22, 41, 128, 1),
                    border: Border.all(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text(
                      getAdditionalNames(),
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            )
          : Row(
              children: [
                Expanded(child: Container()),
                Container(
                  padding: const EdgeInsets.only(
                    left: 15,
                    right: 15,
                    top: 5,
                    bottom: 5,
                  ),
                  height: 35,
                  width: 180,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(22, 41, 128, 1),
                    border: Border.all(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text(
                      getAdditionalNames(),
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Expanded(child: Container())
              ],
            ),
    );
  }

  String getAdditionalNames() {
    var name = '';
    switch (_selectedModeIndex) {
      case 0:
        {
          switch (toggle) {
            case true:
              {
                switch (m) {
                  case 1:
                    name = 'Icon 1';
                    break;
                  case 2:
                    name = 'Icon 2';
                    break;
                  case 3:
                    name = 'Icon 3';
                    break;
                  case 4:
                    name = 'Icon 4';
                    break;
                  case 5:
                    name = 'Icon 5';
                    break;
                  case 6:
                    name = 'Icon 6';
                    break;
                  case 7:
                    name = 'Icon 7';
                    break;
                  case 8:
                    name = 'Icon 8';
                    break;
                }
                break;
              }
            case false:
              {
                switch (m) {
                  case 1:
                    name = 'Icon 1';
                    break;
                  case 2:
                    name = 'Icon 2';
                    break;
                  case 3:
                    name = 'Icon 3';
                    break;
                  case 4:
                    name = 'Icon 4';
                    break;
                  case 5:
                    name = 'Icon 5';
                    break;
                  case 6:
                    name = 'Icon 6';
                    break;
                  case 7:
                    name = 'Icon 7';
                    break;
                }
                break;
              }
          }
          break;
        }
      case 1:
        switch (m) {
          case 7:
            name = 'Icon 8';
            break;
          case 8:
            name = 'Icon 9';
            break;
        }
        break;
      case 2:
        switch (m) {
          case 7:
            name = 'Icon 10';
            break;
          case 8:
            name = 'Icon 11';
            break;
        }
        break;
    }
    return name;
  }

  Widget _buildAdditionalWheel() {
    final w = MediaQuery.of(context).size.width;
    const h = fourWheelPieceSize * 2 + 20 + 20;
    const eightWheelPieceColor = Color.fromRGBO(22, 41, 128, 1);
    return SizedBox(
      height: fourWheelPieceSize * 2 + 20 + 20,
      child: Align(
        alignment: Alignment.topLeft,
        child: Stack(
          children: <Widget>[
            // the background
            Center(
              child: Container(
                height: eightWheelPieceSize * 2 + 50,
                width: eightWheelPieceSize * 2 + 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.orangeAccent,
                  border: Border.all(width: 4, color: Colors.white),
                ),
              ),
            ),
            // the eight pieces
            Positioned(
              left: w / 2 + eightWheelCenterRadius / 2 - 11,
              top: h / 2 + (eightWheelPieceSize * (sqrt(2) - 1)) / 2 - eightWheelPieceSize / 2 * sqrt(2) - 6,
              child: Transform.rotate(
                angle: pi / 4,
                child: ClipPath(
                  clipper: EightWheelPieceShape(),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: eightWheelPieceColor,
                      backgroundColor: eightWheelPieceColor,
                    ),
                    onPressed: () {
                      startDoing || _selectedModeIndex != 0
                          ? null
                          : setState(() {
                              m = 1;
                            });
                    },
                    child: CustomPaint(
                      //painter: m == 1 ? eightWheelPainter(true) : eightWheelPainter(false),
                      child: Container(
                        padding: EdgeInsets.only(
                          top: eightWheelPieceSize -
                              (eightWheelCenterRadius + eightWheelCenterRadius) / 2 * sin(pi / 8) -
                              60,
                          left: (eightWheelPieceSize + eightWheelCenterRadius) / 2 * cos(pi / 8) - 40,
                        ),
                        height: eightWheelPieceSize,
                        width: eightWheelPieceSize,
                        decoration: m == 1
                            ? BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    blurStyle: BlurStyle.outer,
                                    offset: const Offset(30, 45),
                                    blurRadius: 60,
                                    spreadRadius: -40.0,
                                    color: Colors.white.withOpacity(0.8),
                                  ),
                                ],
                              )
                            : _selectedModeIndex != 0
                                ? null
                                : isAdditionalReady[getAdditionalIndex(1)]
                                    ? BoxDecoration(
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            blurStyle: BlurStyle.outer,
                                            offset: const Offset(30, 45),
                                            blurRadius: 60,
                                            spreadRadius: -40.0,
                                            color: Colors.lightGreenAccent.withOpacity(0.8),
                                          ),
                                        ],
                                      )
                                    : null,
                        alignment: Alignment.center,
                        child: _selectedModeIndex != 0
                            ? Container()
                            : Transform.rotate(
                                angle: -pi / 4,
                                child: Container(
                                  height: iconBoxSize,
                                  width: iconBoxSize,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.black,
                                  ),
                                  child: getAdditionalIcon(1),
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: w / 2,
              top: h / 2 + 2,
              child: Transform.rotate(
                angle: pi / 2,
                child: ClipPath(
                  clipper: EightWheelPieceShape(),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: eightWheelPieceColor,
                      backgroundColor: eightWheelPieceColor,
                    ),
                    onPressed: () {
                      startDoing
                          ? null
                          : _selectedModeIndex != 0
                              ? null
                              : setState(() {
                                  m = 2;
                                });
                    },
                    child: CustomPaint(
                      //painter: m == 2 ? eightWheelPainter(true) :  eightWheelPainter(false),
                      child: Container(
                        padding: EdgeInsets.only(
                          top: eightWheelPieceSize -
                              (eightWheelCenterRadius + eightWheelCenterRadius) / 2 * sin(pi / 8) -
                              60,
                          left: (eightWheelPieceSize + eightWheelCenterRadius) / 2 * cos(pi / 8) - 40,
                        ),
                        height: eightWheelPieceSize,
                        width: eightWheelPieceSize,
                        decoration: m == 2
                            ? BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    blurStyle: BlurStyle.outer,
                                    offset: const Offset(30, 45),
                                    blurRadius: 60,
                                    spreadRadius: -40.0,
                                    color: Colors.white.withOpacity(0.8),
                                  ),
                                ],
                              )
                            : _selectedModeIndex != 0
                                ? null
                                : isAdditionalReady[getAdditionalIndex(2)]
                                    ? BoxDecoration(
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            blurStyle: BlurStyle.outer,
                                            offset: const Offset(30, 45),
                                            blurRadius: 60,
                                            spreadRadius: -40.0,
                                            color: Colors.lightGreenAccent.withOpacity(0.8),
                                          ),
                                        ],
                                      )
                                    : null,
                        alignment: Alignment.center,
                        child: _selectedModeIndex != 0
                            ? Container()
                            : Transform.rotate(
                                angle: -pi / 2,
                                child: Container(
                                  height: iconBoxSize,
                                  width: iconBoxSize,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.black,
                                  ),
                                  child: getAdditionalIcon(2),
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: eightWheelPieceSize * (sqrt(2) - 1) / 2 + w / 2 - eightWheelPieceSize / sqrt(2) - 10,
              top: h / 2 + eightWheelPieceSize * (sqrt(2) - 1) / 2 + 5,
              child: Transform.rotate(
                angle: pi * 3 / 4,
                child: ClipPath(
                  clipper: EightWheelPieceShape(),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: eightWheelPieceColor,
                      backgroundColor: eightWheelPieceColor,
                    ),
                    onPressed: () {
                      startDoing
                          ? null
                          : _selectedModeIndex != 0
                              ? null
                              : setState(() {
                                  m = 3;
                                });
                    },
                    child: CustomPaint(
                      //painter: m == 3 ? eightWheelPainter(true) :  eightWheelPainter(false),
                      child: Container(
                        padding: EdgeInsets.only(
                          top: eightWheelPieceSize -
                              (eightWheelCenterRadius + eightWheelCenterRadius) / 2 * sin(pi / 8) -
                              60,
                          left: (eightWheelPieceSize + eightWheelCenterRadius) / 2 * cos(pi / 8) - 40,
                        ),
                        height: eightWheelPieceSize,
                        width: eightWheelPieceSize,
                        decoration: m == 3
                            ? BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    blurStyle: BlurStyle.outer,
                                    offset: const Offset(30, 45),
                                    blurRadius: 60,
                                    spreadRadius: -40.0,
                                    color: Colors.white.withOpacity(0.8),
                                  ),
                                ],
                              )
                            : _selectedModeIndex != 0
                                ? null
                                : isAdditionalReady[getAdditionalIndex(3)]
                                    ? BoxDecoration(
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            blurStyle: BlurStyle.outer,
                                            offset: const Offset(30, 45),
                                            blurRadius: 60,
                                            spreadRadius: -40.0,
                                            color: Colors.lightGreenAccent.withOpacity(0.8),
                                          ),
                                        ],
                                      )
                                    : null,
                        alignment: Alignment.center,
                        child: _selectedModeIndex != 0
                            ? Container()
                            : Transform.rotate(
                                angle: -pi * 3 / 4,
                                child: Container(
                                  height: iconBoxSize,
                                  width: iconBoxSize,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.black,
                                  ),
                                  child: getAdditionalIcon(3),
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              right: w / 2 + 2,
              top: h / 2,
              child: Transform.rotate(
                angle: pi,
                child: ClipPath(
                  clipper: EightWheelPieceShape(),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: eightWheelPieceColor,
                      backgroundColor: eightWheelPieceColor,
                    ),
                    onPressed: () {
                      startDoing
                          ? null
                          : _selectedModeIndex != 0
                              ? null
                              : setState(() {
                                  m = 4;
                                });
                    },
                    child: CustomPaint(
                      //painter: m == 4 ? eightWheelPainter(true) :  eightWheelPainter(false),
                      child: Container(
                        padding: EdgeInsets.only(
                          top: eightWheelPieceSize -
                              (eightWheelCenterRadius + eightWheelCenterRadius) / 2 * sin(pi / 8) -
                              60,
                          left: (eightWheelPieceSize + eightWheelCenterRadius) / 2 * cos(pi / 8) - 40,
                        ),
                        height: eightWheelPieceSize,
                        width: eightWheelPieceSize,
                        decoration: m == 4
                            ? BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    blurStyle: BlurStyle.outer,
                                    offset: const Offset(30, 45),
                                    blurRadius: 60,
                                    spreadRadius: -40.0,
                                    color: Colors.white.withOpacity(0.8),
                                  ),
                                ],
                              )
                            : _selectedModeIndex != 0
                                ? null
                                : isAdditionalReady[getAdditionalIndex(4)]
                                    ? BoxDecoration(
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            blurStyle: BlurStyle.outer,
                                            offset: const Offset(30, 45),
                                            blurRadius: 60,
                                            spreadRadius: -40.0,
                                            color: Colors.lightGreenAccent.withOpacity(0.8),
                                          ),
                                        ],
                                      )
                                    : null,
                        alignment: Alignment.center,
                        child: _selectedModeIndex != 0
                            ? Container()
                            : Transform.rotate(
                                angle: -pi,
                                child: Container(
                                  height: iconBoxSize,
                                  width: iconBoxSize,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.black,
                                  ),
                                  child: getAdditionalIcon(4),
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              right: w / 2 + (eightWheelPieceSize * (sqrt(2) - 1)) / 2 + 4,
              top: h / 2 - eightWheelPieceSize / sqrt(2) + (eightWheelPieceSize * (sqrt(2) - 1)) / 2 - 9,
              child: Transform.rotate(
                angle: -pi * 3 / 4,
                child: ClipPath(
                  clipper: EightWheelPieceShape(),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: eightWheelPieceColor,
                      backgroundColor: eightWheelPieceColor,
                    ),
                    onPressed: () {
                      startDoing
                          ? null
                          : _selectedModeIndex != 0
                              ? null
                              : setState(() {
                                  m = 5;
                                });
                    },
                    child: CustomPaint(
                      //painter: m == 5 ? eightWheelPainter(true) :  eightWheelPainter(false),
                      child: Container(
                        padding: EdgeInsets.only(
                          top: eightWheelPieceSize -
                              (eightWheelCenterRadius + eightWheelCenterRadius) / 2 * sin(pi / 8) -
                              60,
                          left: (eightWheelPieceSize + eightWheelCenterRadius) / 2 * cos(pi / 8) - 40,
                        ),
                        height: eightWheelPieceSize,
                        width: eightWheelPieceSize,
                        decoration: m == 5
                            ? BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    blurStyle: BlurStyle.outer,
                                    offset: const Offset(30, 45),
                                    blurRadius: 60,
                                    spreadRadius: -40.0,
                                    color: Colors.white.withOpacity(0.8),
                                  ),
                                ],
                              )
                            : _selectedModeIndex != 0
                                ? null
                                : isAdditionalReady[getAdditionalIndex(5)]
                                    ? BoxDecoration(
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            blurStyle: BlurStyle.outer,
                                            offset: const Offset(30, 45),
                                            blurRadius: 60,
                                            spreadRadius: -40.0,
                                            color: Colors.lightGreenAccent.withOpacity(0.8),
                                          ),
                                        ],
                                      )
                                    : null,
                        alignment: Alignment.center,
                        child: _selectedModeIndex != 0
                            ? Container()
                            : Transform.rotate(
                                angle: pi * 3 / 4,
                                child: Container(
                                  height: iconBoxSize,
                                  width: iconBoxSize,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.black,
                                  ),
                                  child: getAdditionalIcon(5),
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: w / 2 - eightWheelPieceSize - 16,
              bottom: h / 2 + 2,
              child: Transform.rotate(
                angle: -pi / 2,
                child: ClipPath(
                  clipper: EightWheelPieceShape(),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: eightWheelPieceColor,
                      backgroundColor: eightWheelPieceColor,
                    ),
                    onPressed: () {
                      startDoing
                          ? null
                          : _selectedModeIndex != 0
                              ? null
                              : setState(() {
                                  m = 6;
                                });
                    },
                    child: CustomPaint(
                      //painter: m == 6 ? eightWheelPainter(true) :  eightWheelPainter(false),
                      child: Container(
                        padding: EdgeInsets.only(
                          top: eightWheelPieceSize -
                              (eightWheelCenterRadius + eightWheelCenterRadius) / 2 * sin(pi / 8) -
                              60,
                          left: (eightWheelPieceSize + eightWheelCenterRadius) / 2 * cos(pi / 8) - 40,
                        ),
                        height: eightWheelPieceSize,
                        width: eightWheelPieceSize,
                        decoration: m == 6
                            ? BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    blurStyle: BlurStyle.outer,
                                    offset: const Offset(30, 45),
                                    blurRadius: 60,
                                    spreadRadius: -40.0,
                                    color: Colors.white.withOpacity(0.8),
                                  ),
                                ],
                              )
                            : _selectedModeIndex != 0
                                ? null
                                : isAdditionalReady[getAdditionalIndex(6)]
                                    ? BoxDecoration(
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            blurStyle: BlurStyle.outer,
                                            offset: const Offset(30, 45),
                                            blurRadius: 60,
                                            spreadRadius: -40.0,
                                            color: Colors.lightGreenAccent.withOpacity(0.8),
                                          ),
                                        ],
                                      )
                                    : null,
                        alignment: Alignment.center,
                        child: _selectedModeIndex != 0
                            ? Container()
                            : Transform.rotate(
                                angle: pi / 2,
                                child: Container(
                                  height: iconBoxSize,
                                  width: iconBoxSize,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.black,
                                  ),
                                  child: getAdditionalIcon(6),
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: w / 2 + (eightWheelPieceSize * (sqrt(2) - 1)) / 2 - eightWheelPieceSize * sqrt(2) / 2 - 6,
              top: (eightWheelPieceSize * (sqrt(2) - 1)) / 2 + h / 2 - eightWheelPieceSize * sqrt(2) - 20,
              child: Transform.rotate(
                angle: -pi / 4,
                child: ClipPath(
                  clipper: EightWheelPieceShape(),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: eightWheelPieceColor,
                      backgroundColor: eightWheelPieceColor,
                    ),
                    onPressed: () {
                      startDoing
                          ? null
                          : _selectedModeIndex > 2
                              ? null
                              : setState(() {
                                  m = 7;
                                });
                    },
                    child: CustomPaint(
                      //painter: m == 7 ? eightWheelPainter(true) :  eightWheelPainter(false),
                      child: Container(
                        padding: EdgeInsets.only(
                          top: eightWheelPieceSize -
                              (eightWheelCenterRadius + eightWheelCenterRadius) / 2 * sin(pi / 8) -
                              60,
                          left: (eightWheelPieceSize + eightWheelCenterRadius) / 2 * cos(pi / 8) - 40,
                        ),
                        height: eightWheelPieceSize,
                        width: eightWheelPieceSize,
                        decoration: m == 7
                            ? BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    blurStyle: BlurStyle.outer,
                                    offset: const Offset(30, 45),
                                    blurRadius: 60,
                                    spreadRadius: -40.0,
                                    color: Colors.white.withOpacity(0.8),
                                  ),
                                ],
                              )
                            : isAdditionalReady[getAdditionalIndex(7)]
                                ? BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        blurStyle: BlurStyle.outer,
                                        offset: const Offset(30, 45),
                                        blurRadius: 60,
                                        spreadRadius: -40.0,
                                        color: Colors.lightGreenAccent.withOpacity(0.8),
                                      ),
                                    ],
                                  )
                                : null,
                        alignment: Alignment.center,
                        child: _selectedModeIndex > 2
                            ? Container()
                            : Transform.rotate(
                                angle: pi / 4,
                                child: Container(
                                  height: iconBoxSize,
                                  width: iconBoxSize,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.black,
                                  ),
                                  child: getAdditionalIcon(7),
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: w / 2 + 2,
              bottom: h / 2 - 1,
              child: Transform.rotate(
                angle: -pi * 0,
                child: ClipPath(
                  clipper: EightWheelPieceShape(),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: eightWheelPieceColor,
                      backgroundColor: eightWheelPieceColor,
                    ),
                    onPressed: () => startDoing || (_selectedModeIndex == 0 && !toggle)
                        ? null
                        : setState(() {
                            m = 8;
                          }),
                    child: CustomPaint(
                      //painter: m == 8 ? eightWheelPainter(true) :  eightWheelPainter(false),
                      child: Container(
                        padding: EdgeInsets.only(
                          top: eightWheelPieceSize -
                              (eightWheelCenterRadius + eightWheelCenterRadius) / 2 * sin(pi / 8) -
                              60,
                          left: (eightWheelPieceSize + eightWheelCenterRadius) / 2 * cos(pi / 8) - 40,
                        ),
                        height: eightWheelPieceSize,
                        width: eightWheelPieceSize,
                        decoration: m == 8
                            ? BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    blurStyle: BlurStyle.outer,
                                    offset: const Offset(30, 45),
                                    blurRadius: 60,
                                    spreadRadius: -40.0,
                                    color: Colors.white.withOpacity(0.8),
                                  ),
                                ],
                              )
                            : isAdditionalReady[getAdditionalIndex(8)]
                                ? BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        blurStyle: BlurStyle.outer,
                                        offset: const Offset(30, 45),
                                        blurRadius: 60,
                                        spreadRadius: -40.0,
                                        color: Colors.lightGreenAccent.withOpacity(0.8),
                                      ),
                                    ],
                                  )
                                : null,
                        alignment: Alignment.center,
                        child: _selectedModeIndex == 0 && !toggle
                            ? Container()
                            : Transform.rotate(
                                angle: -pi * 0,
                                child: Container(
                                  height: iconBoxSize,
                                  width: iconBoxSize,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.black,
                                  ),
                                  child: getAdditionalIcon(8),
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // the circular progress indicator
            if (startDoing)
              Positioned(
                left: w / 2 - eightWheelCenterRadius,
                top: h / 2 - eightWheelCenterRadius,
                child: SizedBox(
                  height: eightWheelCenterRadius * 2,
                  width: eightWheelCenterRadius * 2,
                  child: const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                    strokeWidth: 14,
                  ),
                ),
              ),
            // the 'go' button
            Center(
              child: InkWell(
                onTap: () async {
                  setState(() {
                    startDoing = !startDoing;
                  });
                  await doSomething();
                },
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                borderRadius: BorderRadius.circular(140),
                child: Container(
                  height: fourWheelCenterRadius * 2 + 2,
                  width: fourWheelCenterRadius * 2 + 2,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color.fromRGBO(22, 41, 128, 1),
                    border: Border.all(
                      width: isAdditionalReady[getAdditionalIndex()] ? 6 : 2,
                      color: startDoing
                          ? Colors.transparent
                          : isAdditionalReady[getAdditionalIndex()]
                              ? Colors.orangeAccent
                              : Colors.yellow,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Stack(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: getAdditionalIcon(m),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 10,
                        ),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            startDoing
                                ? 'STOP'
                                : isAdditionalReady[getAdditionalIndex()]
                                    ? 'Reset'
                                    : 'GO!',
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 25),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getAdditionalIcon(int m) {
    return const Icon(
      IconData(0xf3dc, fontFamily: 'MaterialIcons'),
      size: (fourWheelCenterRadius * 2 - 80) / 2,
    );
    var path = '';
    switch (_selectedModeIndex) {
      case 0:
        {
          switch (toggle) {
            case true:
              {
                switch (m) {
                  case 1:
                    path = 'assets/img$m-$letter.svg';
                    break;

                  case 2:
                    path = 'assets/img$m-$letter.svg';
                    break;
                  case 3:
                    path = 'assets/img$m-$letter.svg';
                    break;
                  case 4:
                    path = 'assets/img$m-$letter.svg';
                    break;
                  case 5:
                    path = 'assets/img$m-$letter.svg';
                    break;
                  case 6:
                    path = 'assets/img$m-$letter.svg';
                    break;
                  case 7:
                    path = 'assets/img$m-$letter.svg';
                    break;
                  case 8:
                    path = 'assets/img$m-$letter.svg';
                    break;
                }
                break;
              }
            case false:
              {
                switch (m) {
                  case 1:
                    path = 'assets/img$m-$letter.svg';
                    break;
                  case 2:
                    path = 'assets/img$m-$letter.svg';
                    break;
                  case 3:
                    path = 'assets/img$m-$letter.svg';
                    break;
                  case 4:
                    path = 'assets/img$m-$letter.svg';
                    break;
                  case 5:
                    path = 'assets/img$m-$letter.svg';
                    break;
                  case 6:
                    path = 'assets/img$m-$letter.svg';
                    break;
                  case 7:
                    path = 'assets/img$m-$letter.svg';
                    break;
                }
                break;
              }
          }
          break;
        }
      case 1:
        switch (m) {
          case 7:
            path = 'assets/img$m-$letter.svg';
            break;
          case 8:
            path = 'assets/img$m-$letter.svg';
            break;
        }
        break;
      case 2:
        switch (m) {
          case 7:
            path = 'assets/img$m-$letter.svg';
            break;
          case 8:
            path = 'assets/img$m-$letter.svg';
            break;
        }
        break;
    }

    if (path != '') {
      // return SvgPicture.asset(
      //   path,
      //   width: eightWheelCenterRadius * 2 - 60,
      //   height: eightWheelCenterRadius * 2 - 60,
      // );
    }
    return Container();
  }

  Widget _buildAdditionalModes() {
    final kShortcutIconHeight = MediaQuery.of(context).size.width / 6.4655172414;

    return SizedBox(
      height: MediaQuery.of(context).size.width / 3,
      child: CustomScrollView(
        slivers: <Widget>[
          SliverPadding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
            sliver: SliverGrid.count(
              crossAxisCount: 3,
              childAspectRatio: 105 / 104,
              crossAxisSpacing: 10.0,
              children: [1, 2, 3]
                  .asMap()
                  .map(
                    (index, item) => MapEntry(
                      index,
                      Stack(
                        fit: StackFit.expand,
                        children: [
                          RawMaterialButton(
                            fillColor: _selectedModeIndex == index ? Colors.blue : Colors.grey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            onPressed: () {
                              startDoing
                                  ? null
                                  : setState(() {
                                      m = 7;
                                      if (_selectedModeIndex != index) {
                                        _selectedModeIndex = index;
                                      }
                                    });
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                const Icon(Icons.accessibility),
                                Text(
                                  'Set $index',
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .values
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  int getAdditionalIndex([int x = 0]) {
    var weight = 0;
    weight += _selectedModeIndex * 2;
    if (_selectedModeIndex == 0 && toggle) weight += 12;
    if (x != 0) return weight + x - 1;
    return weight + m - 1;
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}
