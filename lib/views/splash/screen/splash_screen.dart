import 'package:connection_notifier/connection_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hamazh_auth/utls/base_widget/base_widget.dart';
import 'package:hamazh_auth/utls/helper/extension.dart';
import 'package:hamazh_auth/utls/manger/assets_manger.dart';

import '../../../utls/helper/enum_helper.dart';
import '../../home/screen/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    if (ConnectionNotifierTools.isConnected) {
      context.homeCuibt.getArticleData(ArticleType.home, context).then((value) {
        navigatorWid(
            page: const HomeScreen(), context: context, returnPage: false);
      });
    } else {
      context.homeCuibt
          .getArticleOfflineData(
        ArticleType.home,
      )
          .then((value) {
        navigatorWid(
            page: const HomeScreen(), context: context, returnPage: false);
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                AssetsManger.logo,
                height: context.height * .35,
                width: context.width * .9,
              ),
              const SizedBox(
                height: 30,
              ),
              const CircularProgressIndicator.adaptive()
            ],
          ),
        ),
      ),
    );
  }
}
