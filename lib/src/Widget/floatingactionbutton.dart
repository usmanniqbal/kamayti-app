import 'package:ballotcommette_app_office/src/NewCommette.dart';
import 'package:flutter/material.dart';

class FancyFab extends StatefulWidget {
  final Function() onPressed;
  final String tooltip;
  final IconData icon;

  FancyFab({this.onPressed, this.tooltip, this.icon});

  @override
  _FancyFabState createState() => _FancyFabState();
}

class _FancyFabState extends State<FancyFab>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  bool isOpened = false;
  AnimationController _animationController;
  Animation<Color> _buttonColor;
  Animation<double> _animateIcon;
  Animation<double> _translateButton;
  Curve _curve = Curves.easeOut;
  double _fabHeight = 56.0;

  @override
  initState() {
    _animationController =
    AnimationController(vsync: this, duration: Duration(milliseconds: 500))
      ..addListener(() {
        setState(() {});
      });
    _animateIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _buttonColor = ColorTween(
      begin: Colors.blue,
      end: Colors.red,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.00,
        1.00,
        curve: Curves.linear,
      ),
    ));
    _translateButton = Tween<double>(
      begin: _fabHeight,
      end: -14.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.0,
        0.75,
        curve: _curve,
      ),
    ));
    super.initState();
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  animate() {
    if (!isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    isOpened = !isOpened;
  }

  Widget add() {
    return Container(
      child: FloatingActionButton(
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NewCommettee(
                    maxSlide: MediaQuery.of(context).size.width * 0.835))),
        tooltip: 'New Committe',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget image(BuildContext context) {
    return Container(
      child: FloatingActionButton(
        heroTag: "img",
        onPressed: () {
          showDialog(
            context: context,
            builder: (context){
              return AlertDialog(
                title: Text('Join Committe'),
                content: Padding(
                  padding: EdgeInsets.fromLTRB(1, 1, 1, 1),
                  child: Form(
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                              decoration: InputDecoration(
                            labelText: 'Code',
                            hintText: "Enter code",
                            icon: Icon(Icons.details),
                          )),
                        ],
                    ),
                  ),
                ),
                actions: [
                  RaisedButton(
                      child: Text("Submit"),
                      color: Colors.orange,
                      onPressed: () {
                        // your code
                      })
                ],
              );
            }

          );
        },
        tooltip: 'Join Committe',
        child: Icon(Icons.account_tree_outlined),
      ),
    );
  }

  Widget inbox() {
    return Container(
      child: FloatingActionButton(
        heroTag: "inb",
        onPressed: () => showjoincommittedialog(context),
        tooltip: 'Inbox',
        child: Icon(Icons.inbox),
      ),
    );
  }

  Widget toggle() {
    return Container(
      child: FloatingActionButton(
        heroTag: "tg",
        backgroundColor: _buttonColor.value,
        onPressed: animate,
        tooltip: 'Toggle',
        child: AnimatedIcon(
          icon: AnimatedIcons.menu_close,
          progress: _animateIcon,
        ),
      ),
    );
  }

  Widget showjoincommittedialog(BuildContext context){
    return AlertDialog(
      content: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          Positioned(
            right: -40.0,
            top: -40.0,
            child: InkResponse(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: CircleAvatar(
                child: Icon(Icons.close),
                backgroundColor: Colors.red,
              ),
            ),
          ),
          Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      child: Text("Submitß"),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                        }
                      },
                    ),
                  )
                ],
              )
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //return toggle();
      return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value * 2.0,
            0.0,
          ),
          child: add(),
        ),
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value * 1.0,
            0.0,
          ),
          child: image(context),
        ),
        // Transform(
        //   transform: Matrix4.translationValues(
        //     0.0,
        //     _translateButton.value,
        //     0.0,
        //   ),
        //   child: inbox(),
        // ),
        toggle(),
      ],
    );
  }
}