import 'package:atur_uang/pages/home/widget/form_register.dart';
import 'package:atur_uang/pages/home/widget/history.dart';
import 'package:atur_uang/pages/home/widget/history_header.dart';
import 'package:atur_uang/pages/home/widget/horizontal_menu.dart';
import 'package:atur_uang/pages/home/widget/money_banner.dart';
import 'package:atur_uang/pages/home/widget/app_bar_custom.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var boxUser = Hive.box('user_data');

    return Scaffold(
      body: boxUser.length > 0
          ? CustomScrollView(
              slivers: [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
}
