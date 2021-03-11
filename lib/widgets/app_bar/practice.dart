import 'package:flutter/material.dart';

// void main() => runApp(MyApp());
//
// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Overlay for Filtering',
//       theme: ThemeData(
//
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(title: 'Overlay for Filtering'),
//     );
//   }
// }

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;


  OverlayEntry _overlayEntry;
  OverlayState _overlay;
  bool _isBreakfast = false;
  bool _isLunch = false;
  bool _isDinner = false;




  @override
  void initState() {
    super.initState();
    _overlay = Overlay.of(context);

  }


  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
          title: Text(widget.title),
          actions: <Widget>[IconButton(
              icon: Icon(
                Icons.sort,
                semanticLabel: 'sort',
              ),
              onPressed: () =>
              {
                _overlayEntry = _createOverlayEntry(),
                _overlay.insert(_overlayEntry)
              }),
          ]),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme
                  .of(context)
                  .textTheme
                  .display1,
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


  OverlayEntry _createOverlayEntry() {
    return OverlayEntry(maintainState: true, builder: (context) =>
        Positioned(
            right: 50,
            top: 40,
            width:200,height:300,
            child: Material(
                elevation: 4.0,
                child: DefaultTabController(length: 2,
                    child: new Container(

                        child: Scaffold(appBar: TabBar(labelColor: Colors.black,
                            tabs: [
                              Tab(child: new Text('Meal Type')),
                              Tab(child: Text('Dietary'))
                            ]),
                            body: TabBarView(
                                children: <Widget>[new Container(
                                    child: getTab1Contents(_overlayEntry)),
                                  new Padding(padding:EdgeInsets.all(10.0),child:
                                  new Column(children:<Widget>[
                                    new ListTile(title:new Text('Vegan')),
                                    new ListTile(title: new Text('Vegetarian')),
                                    new ListTile(title: new Text('GlutenFree')),
                                  ]
                                  ))]),
                            bottomNavigationBar: SizedBox(child:ListTile(title: new Text('Done'), onTap: () =>
                            {
                              _overlayEntry.remove()
                            }),))
                    )))));
  }

  getTab1Contents(OverlayEntry overlayEntry) {
    return Column(
        children:<Widget>[
          ListTile(
              title: new Text('Lunch'), trailing:Checkbox(value: _isLunch,
            onChanged: (bool value) {
              _overlay.setState(() {
                _isLunch = value;
              });

            }, )),
          ListTile(title: new Text('Breakfast'),
              trailing: Checkbox(value: _isBreakfast,
                onChanged: (bool value) {
                  _overlay.setState(() {
                    _isBreakfast = value;
                  });
                },)),
          ListTile(title: new Text('Dinner'),
              trailing: Checkbox(value: _isDinner,
                onChanged: (bool value) {
                  _overlay.setState(() {
                    _isDinner = value;
                  });
                },)),



        ]);
  }



}

