import 'package:atur_uang/pages/home/widget/history.dart';
import 'package:atur_uang/pages/home/widget/history_header.dart';
import 'package:atur_uang/pages/home/widget/horizontal_menu.dart';
import 'package:atur_uang/pages/home/widget/money_banner.dart';
import 'package:atur_uang/pages/home/widget/app_bar_custom.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController scrollController = ScrollController();
  int alphaColorAppBar = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverAppBar(
            backgroundColor: Color.fromARGB(alphaColorAppBar, 255, 255, 255),
            elevation: 0.5,
            pinned: true,
            title: const AppBarCustom(),
          ),
          const SliverToBoxAdapter(
            child: MoneyBanner(),
          ),
          const SliverToBoxAdapter(
            child: HorizontalMenu(),
          ),
          const SliverToBoxAdapter(
            child: HistoryHeader(),
          ),
          const SliverToBoxAdapter(
            child: History(),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    // Listener Scrolling
    scrollController.addListener(() async {
      if (scrollController.position.pixels <= 16) {
        setState(() {
          final alpha = (scrollController.position.pixels * 16) - 1;

          if (alpha < 0) {
            alphaColorAppBar = 0;
            return;
          }

          alphaColorAppBar = alpha.toInt();
        });
        print(
            'scroll : ${scrollController.position.pixels} -- alpha : $alphaColorAppBar');
      }
    });
    super.initState();
  }
}
