import 'package:atur_uang/pages/home/widget/form_register.dart';
import 'package:atur_uang/pages/home/widget/history.dart';
import 'package:atur_uang/pages/home/widget/history_header.dart';
import 'package:atur_uang/pages/home/widget/horizontal_menu.dart';
import 'package:atur_uang/pages/home/widget/money_banner.dart';
import 'package:atur_uang/pages/home/widget/app_bar_custom.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

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
    var boxUser = Hive.box('user_data');
    print(boxUser.length);
    return Scaffold(
      body: boxUser.length > 0
          ? CustomScrollView(
              controller: scrollController,
              slivers: [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor:
                      Color.fromARGB(alphaColorAppBar, 255, 255, 255),
                  elevation: 0.5,
                  pinned: true,
                  title: AppBarCustom(name: boxUser.getAt(0).username),
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
            )
          : const FormRegister(),
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
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
