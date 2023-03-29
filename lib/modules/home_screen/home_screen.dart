import 'package:flutter/material.dart';
import 'package:pertemuan_v/models/user.dart';
import 'package:pertemuan_v/modules/home_screen/fragments/home_fragment/home_fragment.dart';
import 'package:pertemuan_v/modules/home_screen/fragments/menu_fragment/menu_fragment.dart';
import 'package:pertemuan_v/modules/home_screen/fragments/news_fragment/news_fragment.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.user,
  });
  final User user;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  late Size size;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final PageController _pageController = PageController();

  tapBottomItem(int index) {
    if (index != 2) {
      setState(() {
        _currentIndex = index;
      });
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      _scaffoldKey.currentState!.openEndDrawer();
    }
  }

  @override
  void initState() {
    _pageController.addListener(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: const Drawer(),
      body: PageView(
        controller: _pageController,
        children: [
          HomeFragment(
            user: widget.user,
          ),
          const NewsFragment(),
          const MenuFragment()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: tapBottomItem,
        items: [
          bottomMenuItem(
            "Home",
            Icons.home_rounded,
          ),
          bottomMenuItem(
            "News",
            Icons.newspaper_rounded,
          ),
          bottomMenuItem(
            "Menu",
            Icons.menu_rounded,
          ),
        ],
      ),
    );
  }

  BottomNavigationBarItem bottomMenuItem(
    String label,
    IconData iconData,
  ) {
    return BottomNavigationBarItem(
      label: label,
      icon: Icon(
        iconData,
      ),
    );
  }
}
