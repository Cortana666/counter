import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '计算器',
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _color = {
    'orange': Colors.orange,
    'white': Colors.white,
    'grey': Colors.grey,
    'black': Colors.black,
    'grey850': Colors.grey[850],
  };

  String clear = 'AC';
  String res = '0';
  String do_data = '0';
  String do_type = '';
  double result_size = 90.0;
  String show = '0';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        padding: EdgeInsets.only(
          bottom:55,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              width: 370.0,
              margin: EdgeInsets.only(
                bottom: 15.0,
              ),
              child: Text(
                result(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: result_size,
                  fontWeight: FontWeight.w300,
                ),
                textAlign: TextAlign.right,
                maxLines: 1,
              ),
            ),
            Container(
              child: Column(
                children: [
                  Row(
                    children: [
                      button(clear, 'grey', 'black', 'short', () {
                        initActive();
                      }),
                      button('±', 'grey', 'black', 'short', () {
                        reverse();
                      }),
                      button('%', 'grey', 'black', 'short', () {
                        percent();
                      }),
                      button('÷', 'orange', 'white', 'short', () {
                        doFunc('÷');
                      }),
                    ],
                  ),
                  Row(
                    children: [
                      button('7', 'grey850', 'white', 'short', () {
                        doActive();
                        putAny('7');
                      }),
                      button('8', 'grey850', 'white', 'short', () {
                        doActive();
                        putAny('8');
                      }),
                      button('9', 'grey850', 'white', 'short', () {
                        doActive();
                        putAny('9');
                      }),
                      button('x', 'orange', 'white', 'short', () {
                        doFunc('x');
                      }),
                    ],
                  ),
                  Row(
                    children: [
                      button('4', 'grey850', 'white', 'short', () {
                        doActive();
                        putAny('4');
                      }),
                      button('5', 'grey850', 'white', 'short', () {
                        doActive();
                        putAny('5');
                      }),
                      button('6', 'grey850', 'white', 'short', () {
                        doActive();
                        putAny('6');
                      }),
                      button('-', 'orange', 'white', 'short', () {
                        doFunc('-');
                      }),
                    ],
                  ),
                  Row(
                    children: [
                      button('1', 'grey850', 'white', 'short', () {
                        doActive();
                        putAny('1');
                      }),
                      button('2', 'grey850', 'white', 'short', () {
                        doActive();
                        putAny('2');
                      }),
                      button('3', 'grey850', 'white', 'short', () {
                        doActive();
                        putAny('3');
                      }),
                      button('+', 'orange', 'white', 'short', () {
                        doFunc('+');
                      }),
                    ],
                  ),
                  Row(
                    children: [
                      button('0', 'grey850', 'white', 'long', () {
                        putAny('0');
                      }),
                      button('.', 'grey850', 'white', 'short', () {
                        doActive();
                        dot();
                      }),
                      button('=', 'orange', 'white', 'short', () {
                        equal();
                      }),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget button(content, bgcolor, ftcolor, btype, active) {
    return Container(
      margin: EdgeInsets.only(
        left: 15.0,
        bottom: 15.0,
      ),
      child: TextButton(
        style: btype == 'long'
            ? longStyle(bgcolor, ftcolor)
            : shortStyle(bgcolor, ftcolor),
        child: btype == 'long' ? longText(content) : shortText(content),
        onPressed: active,
      ),
    );
  }

  ButtonStyle longStyle(bgcolor, ftcolor) {
    return ButtonStyle(
      backgroundColor: MaterialStateProperty.all(_color[bgcolor]),
      foregroundColor: MaterialStateProperty.all(_color[ftcolor]),
      shape: MaterialStateProperty.all(StadiumBorder()),
      fixedSize: MaterialStateProperty.all(Size(190.0, 88.0)),
    );
  }

  ButtonStyle shortStyle(bgcolor, ftcolor) {
    return ButtonStyle(
      backgroundColor: MaterialStateProperty.all(_color[bgcolor]),
      foregroundColor: MaterialStateProperty.all(_color[ftcolor]),
      shape: MaterialStateProperty.all(CircleBorder()),
      fixedSize: MaterialStateProperty.all(Size.square(88.0)),
    );
  }

  Widget longText(content) {
    return Container(
      margin: EdgeInsets.only(
        right: 100.0,
      ),
      child: Text(
        content,
        style: TextStyle(
          fontSize: 35.0,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget shortText(content) {
    return Text(
      content,
      style: TextStyle(
        fontSize: 35.0,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  String result() {
    if (do_type.isNotEmpty && res.isEmpty) {
      show = do_data;
    } else {
      show = res;
      if (show.length > 6) {
        result_size = 59.0;
      } else {
        result_size = 91.0;
      }
      setState(() {});
      if (!show.contains('.')) {
        int z = 1;
        for (var i = show.length - 1; i > -1; i--) {
          if (z % 3 == 0) {
            show = '${show.substring(0, i)},${show.substring(i)}';
          }
          z++;
        }
      }
      if (show.substring(0, 1) == ',') {
        show = show.substring(1);
      }
    }
    return show;
  }

  void doActive() {
    clear = 'C';
    setState(() {});
  }

  void initActive() {
    clear = 'AC';
    res = '0';
    setState(() {});
  }

  void putAny(thing) {
    if (res.contains('.')) {
      if (res.length >= 10) {
        return;
      }
    } else {
      if (res.length >= 9) {
        return;
      }
    }

    if (res == '0') {
      if (thing != '0') {
        res = thing;
      }
    } else {
      res = '$res$thing';
    }

    setState(() {});
  }

  void reverse() {
    if (res.substring(0, 1) == '-') {
      res = res.substring(1);
    } else {
      res = '-$res';
    }
    setState(() {});
  }

  void percent() {
    res = (double.parse(res) / 100).toString();
    setState(() {});
  }

  void dot() {
    if (!res.contains('.')) {
      if (res.isEmpty) {
        res = '0';
      }
      res = '$res.';
    }
    setState(() {});
  }

  void equal() {
    if (do_type.isNotEmpty) {
      switch (do_type) {
        case '+':
          res = (double.parse(do_data) + double.parse(res)).toString();
          break;
        case '-':
          res = (double.parse(do_data) - double.parse(res)).toString();
          break;
        case 'x':
          res = (double.parse(do_data) * double.parse(res)).toString();
          break;
        case '÷':
          res = (double.parse(do_data) / double.parse(res)).toString();
          break;
        default:
      }
      do_type = '';
      do_data = '0';
      if (double.parse(res) - double.parse(res).truncate() == 0) {
        res = (double.parse(res)).toInt().toString();
      }
    } else {
      if (res.contains('.')) {
        if (res.substring(res.length - 1) == '.') {
          res = (int.parse(res.substring(0, res.length - 1)) + 1).toString();
        } else {
          if (double.parse(res) - double.parse(res).truncate() == 0) {
            res = (double.parse(res)).toInt().toString();
          }
        }
      }
    }
    setState(() {});
  }

  void doFunc(thing) {
    do_data = res;
    do_type = thing;
    res = '';
    setState(() {});
  }
}
