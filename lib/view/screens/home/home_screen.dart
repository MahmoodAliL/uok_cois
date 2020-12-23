import 'package:flutter/material.dart';
import 'package:uok_cois/view/screens/home/destination.dart';
import 'package:uok_cois/view/widgets/drawer_widget.dart';
import 'package:uok_cois/view/widgets/firebase_notification_widget.dart';

const _kBottomLabelFontSize = 16.0;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with TickerProviderStateMixin<HomeScreen> {
  List<AnimationController> _faders;
  List<Key> _destinationKeys;
  int _currentIndex = 1;

  @override
  void initState() {
    super.initState();

    _faders = allDestination.map<AnimationController>(
      (destination) {
        return AnimationController(
          vsync: this,
          duration: Duration(milliseconds: 500),
        );
      },
    ).toList();

    _faders[_currentIndex].value = 1;
    _destinationKeys =
        List<Key>.generate(allDestination.length, (index) => GlobalKey())
            .toList();
  }

  @override
  void dispose() {
    for (AnimationController animationController in _faders) {
      animationController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text('UOK COIS',
              style: TextStyle(
                color: Colors.black87,
              )),
        ),
      ),
      drawer: AppDrawer(),
      body: Stack(
        children: allDestination.map((destination) {
          final Widget view = FadeTransition(
            opacity: _faders[destination.index],
            child: KeyedSubtree(
              key: _destinationKeys[destination.index],
              child: allDestinationView[destination.index],
            ),
          );

          if (destination.index == _currentIndex) {
            _faders[_currentIndex].forward();
            return view;
          } else {
            _faders[destination.index].reverse();
            if (_faders[destination.index].isAnimating) {
              return IgnorePointer(child: view);
            }
            return Offstage(child: view);
          }
        }).toList()
          ..add(FirebaseNotificationWidget()),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              width: 1,
              color: Theme.of(context).dividerColor,
            ),
          ),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          elevation: 4,
          selectedFontSize: _kBottomLabelFontSize,
          unselectedFontSize: _kBottomLabelFontSize,
          items: allDestination.map((destination) {
            return BottomNavigationBarItem(
              icon: Icon(destination.icon),
              activeIcon: Icon(destination.activeIcon),
              label: destination.title,
            );
          }).toList(),
          currentIndex: _currentIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  void _onItemTapped(index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
