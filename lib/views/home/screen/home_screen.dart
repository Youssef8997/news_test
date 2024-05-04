import 'package:connection_notifier/connection_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hamazh_auth/cuibts/home_cuibt/home_cuibt.dart';
import 'package:hamazh_auth/cuibts/home_cuibt/home_state.dart';
import 'package:hamazh_auth/utls/helper/extension.dart';
import 'package:hamazh_auth/utls/manger/assets_manger.dart';
import 'package:hamazh_auth/utls/manger/color_manger.dart';
import 'package:hamazh_auth/utls/manger/fonts_manger.dart';

import '../../../utls/helper/enum_helper.dart';
import '../widget/article_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(
      length: 6,
      vsync: this,
      animationDuration: Duration.zero,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        toolbarHeight: 50,
        leadingWidth: 100,
        leading: Image.asset(
          AssetsManger.newYorkTimeLogo,
          height: 50,
          width: 100,
        ),
        title: Text(
          "the new york times",
          style: FontsManger.largeFont(context).copyWith(color: Colors.white),
        ),
        bottom: AppBar(
          flexibleSpace: TabBar(
            controller: tabController,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            isScrollable: true,
            indicatorColor: ColorsManger.indicatorColor,
            automaticIndicatorColorAdjustment: true,
            indicatorWeight: 5,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorPadding: const EdgeInsets.only(top: 40),
            indicator: const BoxDecoration(
                color: ColorsManger.indicatorColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
            labelStyle: FontsManger.largeFont(context)
                .copyWith(color: Colors.white, fontSize: 16),
            unselectedLabelColor: ColorsManger.blueColors,
            unselectedLabelStyle: FontsManger.largeFont(context)
                .copyWith(color: ColorsManger.blueColors, fontSize: 14),
            onTap: (int index) {
              if (index == 0) {
                if (ConnectionNotifierTools.isConnected) {
                  context.homeCuibt.getArticleData(ArticleType.home, context);
                } else {
                  context.homeCuibt.getArticleOfflineData(
                    ArticleType.home,
                  );
                }
              } else if (index == 1) {
                if (ConnectionNotifierTools.isConnected) {
                  context.homeCuibt.getArticleData(ArticleType.world, context);
                } else {
                  context.homeCuibt.getArticleOfflineData(
                    ArticleType.world,
                  );
                }
              } else if (index == 2) {
                if (ConnectionNotifierTools.isConnected) {
                  context.homeCuibt.getArticleData(ArticleType.us, context);
                } else {
                  context.homeCuibt.getArticleOfflineData(
                    ArticleType.us,
                  );
                }
              } else if (index == 3) {
                if (ConnectionNotifierTools.isConnected) {
                  context.homeCuibt.getArticleData(ArticleType.health, context);
                } else {
                  context.homeCuibt.getArticleOfflineData(
                    ArticleType.health,
                  );
                }
              } else if (index == 4) {
                if (ConnectionNotifierTools.isConnected) {
                  context.homeCuibt.getArticleData(ArticleType.food, context);
                } else {
                  context.homeCuibt.getArticleOfflineData(
                    ArticleType.food,
                  );
                }
              } else if (index == 5) {
                if (ConnectionNotifierTools.isConnected) {
                  context.homeCuibt.getArticleData(ArticleType.arts, context);
                } else {
                  context.homeCuibt.getArticleOfflineData(
                    ArticleType.arts,
                  );
                }
              }
            },
            tabs: const [
              Tab(
                text: "Home",
              ),
              Tab(
                text: "World",
              ),
              Tab(
                text: "Us",
              ),
              Tab(
                text: "Health",
              ),
              Tab(
                text: "Food",
              ),
              Tab(
                text: "Arts",
              ),
            ],
          ),
        ),
      ),
      body: BlocBuilder<HomeCuibt, HomeState>(builder: (context, state) {
        return TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: tabController,
          children: List.generate(
              6,
              (index) => context.homeCuibt.articles.isNotEmpty &&
                      !context.homeCuibt.isLoading
                  ? ListView.separated(
                      padding: const EdgeInsets.all(10),
                      itemCount: context.homeCuibt.articles.length,
                      itemBuilder: (context, i) =>
                          context.homeCuibt.articles[i].section != "admin"
                              ? ArticleWidget(
                                  article: context.homeCuibt.articles[i],
                                )
                              : const SizedBox(
                                  width: 0,
                                  height: 0,
                                ),
                      separatorBuilder: (context, _) => SizedBox(
                        height: context.height * .02,
                      ),
                    )
                  : context.homeCuibt.isLoading
                      ? const Center(
                          child: CircularProgressIndicator.adaptive(
                            backgroundColor: Colors.white,
                          ),
                        )
                      : Center(
                          child: Text(
                            "Sorry we don't find any articles for you ",
                            style: FontsManger.largeFont(context)
                                .copyWith(color: Colors.white),
                          ),
                        )),
        );
      }),
    );
  }
}
