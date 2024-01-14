import 'package:flutter/material.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  BottomNavigationBarWidget({
    required this.currentIndex,
    required this.onTap,
  });

  @override
  State<BottomNavigationBarWidget> createState() => _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {

  int _page = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }
  void navigationTapped(int page) {
    //Animating Page
    pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    return

      BottomNavigationBar(
      currentIndex: widget.currentIndex,
      onTap: widget.onTap,
      showSelectedLabels: true,
      showUnselectedLabels: true,

      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined,
            color: Colors.grey.shade600,
            size: 26,),
          label: "Anasayfa",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search,
            color: Colors.grey.shade600,
            size: 26,),
          label: 'Kategoriler',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_circle_outline,
            color: Colors.grey.shade600,
            size: 26,),
          label: 'Ürün Sat',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications_none_outlined,
            color: Colors.grey.shade600,
            size: 26,),
          label: 'Bildirimler',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline_outlined,
            color: Colors.grey.shade600,
            size: 26,),
          label: 'Profilim',
        ),
      ],
      selectedItemColor: Colors.grey.shade600,
      unselectedItemColor: Colors.grey.shade600,
      selectedFontSize: 11,
      unselectedFontSize: 11,
    );
  }
}