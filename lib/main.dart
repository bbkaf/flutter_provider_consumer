import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) => MyCounter(0),
            )
          ],
          child: MyHomePage(
            title: "home page title",
          ),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _incrementCounter() {
    // setState(() {
    //
    //   _counter++;
    // });
    MyCounter myCounter = Provider.of<MyCounter>(context,
        listen: false); //listen 預設是true，會刷新整個widget tree，改成false才不會刷新，v4.3.2不改成false執行會報錯
    myCounter.increaseCount();
    // context.read<MyCounter>().increaseCount(); // v4.3.2才有的語法
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '${DateTime.now().toString()}',
            ),
            Consumer<MyCounter>(
              builder: (context, MyCounter data, child) {
                return Text(
                  '${data.count}',
                  style: Theme.of(context).textTheme.headline4,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class MyCounter extends ChangeNotifier {
  int _count;

  get count => _count;

  MyCounter(this._count);

  void increaseCount() {
    _count += 1;
    notifyListeners();
  }
}
