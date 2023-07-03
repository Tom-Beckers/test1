import 'package:flutter/material.dart';
import 'dart:math' as math;

const Color primaryColor = Colors.orange;
const TargetPlatform platform = TargetPlatform.android;
void main() {
  runApp(Sunflower());
}


class SunflowerPainter extends CustomPainter {
  static const seedRadius = 2.0;
  static const scaleFactor = 4;
  static const tau = math.pi * 2;

  static final phi = (math.sqrt(5) + 1) / 2;

  final int seeds;

  SunflowerPainter(this.seeds);

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.width / 2;

    for (var i = 0; i < seeds; i++) {
      final theta = i * tau / phi;
      final r = math.sqrt(i) * scaleFactor;
      final x = center + r * math.cos(theta);
      final y = center - r * math.sin(theta);
      final offset = Offset(x, y);
      if (!size.contains(offset)) {
        continue;
      }
      drawSeed(canvas, x, y);
    }
  }

  @override
  bool shouldRepaint(SunflowerPainter oldDelegate) {
    return oldDelegate.seeds != seeds;
  }

  // Draw a small circle representing a seed centered at (x,y).
  void drawSeed(Canvas canvas, double x, double y) {
    final paint = Paint()
      ..strokeWidth = 2
      ..style = PaintingStyle.fill
      ..color = primaryColor;
    canvas.drawCircle(Offset(x, y), seedRadius, paint);
  }
}

class Sunflower extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SunflowerState();
  }
}

class _SunflowerState extends State<Sunflower> {
  double seeds = 100.0;

  int get seedCount => seeds.floor();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData().copyWith(
        platform: platform,
        brightness: Brightness.dark,
        sliderTheme: SliderThemeData.fromPrimaryColors(
          primaryColor: primaryColor,
          primaryColorLight: primaryColor,
          primaryColorDark: primaryColor,
          valueIndicatorTextStyle: const DefaultTextStyle.fallback().style,
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Sunflower"),
        ),
        drawer: Drawer(
          child: ListView(
            children: const [
              DrawerHeader(
                child: Center(
                  child: Text(
                    "Sunflower 🌻",
                    style: TextStyle(fontSize: 32),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Container(
          constraints: const BoxConstraints.expand(),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.transparent,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.transparent,
                  ),
                ),
                child: SizedBox(
                  width: 400,
                  height: 400,
                  child: CustomPaint(
                    painter: SunflowerPainter(seedCount),
                  ),
                ),
              ),
              Text("Showing $seedCount seeds"),
              ConstrainedBox(
                constraints: const BoxConstraints.tightFor(width: 300),
                child: Slider.adaptive(
                  min: 20,
                  max: 2000,
                  value: seeds,
                  onChanged: (newValue) {
                    setState(() {
                      seeds = newValue;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
