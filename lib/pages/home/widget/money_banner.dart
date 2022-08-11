import 'package:atur_uang/pages/home/widget/banner_image.dart';
import 'package:atur_uang/pages/home/widget/card_money.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MoneyBanner extends StatelessWidget {
  const MoneyBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 720) {
          return Column(
            children: [
              Container(
                margin: const EdgeInsets.all(16),
                child:
                    CardMoney(heightContainer: constraints.maxWidth / 3 + 30),
              ),
              Container(
                margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                child: BannerImage(
                  heightContainer: constraints.maxWidth / 3 + 30,
                ),
              )
            ],
          );
        }
        return Container(
          margin: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: CardMoney(
                  heightContainer: constraints.maxWidth / 4 - 30,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: BannerImage(
                  heightContainer: constraints.maxWidth / 4 - 30,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
