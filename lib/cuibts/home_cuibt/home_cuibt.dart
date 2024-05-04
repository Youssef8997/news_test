// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hamazh_auth/data/dio_data/dio_data.dart';
import 'package:hamazh_auth/utls/constant/end_point_constant.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:path_provider/path_provider.dart';

import '../../data/local_data/shared_preferences_data.dart';
import '../../data/model/articles_model.dart';
import '../../utls/constant/keys_constant.dart';
import '../../utls/helper/crypto_helper.dart';
import '../../utls/helper/enum_helper.dart';
import 'home_state.dart';

class HomeCuibt extends Cubit<HomeState> {
  HomeCuibt() : super(AppInitial());
  List<ArticlesModel> articles = [];
  bool isLoading = false;
// fun to know type of article which user wanna to know about it
  String getUrlOrKey(ArticleType articleType, {bool isApi = true}) {
    if (isApi) {
      switch (articleType) {
        case ArticleType.home:
          return EndPointConstant.homeUrl;
        case ArticleType.arts:
          return EndPointConstant.artsUrl;
        case ArticleType.food:
          return EndPointConstant.foodUrl;
        case ArticleType.health:
          return EndPointConstant.healthUrl;
        case ArticleType.world:
          return EndPointConstant.worldUrl;
        case ArticleType.us:
          return EndPointConstant.usUrl;
      }
    } else {
      switch (articleType) {
        case ArticleType.home:
          return KeysConstant.homeKey;
        case ArticleType.arts:
          return KeysConstant.artsKey;
        case ArticleType.food:
          return KeysConstant.foodKey;
        case ArticleType.health:
          return KeysConstant.healthKey;
        case ArticleType.world:
          return KeysConstant.worldKey;
        case ArticleType.us:
          return KeysConstant.usKey;
      }
    }
  }

//fun to get online data and storage it to use it if app disconnected
  Future getArticleData(ArticleType typeArticle, BuildContext context) async {
    isLoading = true;
    emit(LoadingState());
    Response response = await DioHelper.getData(url: getUrlOrKey(typeArticle));
    if (response.statusCode == 200 && response.data["status"] == "OK") {
      articles = List.generate(response.data["results"].length,
          (index) => ArticlesModel.fromJson(response.data["results"][index]));
      emit(GetOnlineArticle());
      saveArticleData(typeArticle, articles);
      isLoading = false;
      emit(LoadingState());
      return response.data;
    } else {
      isLoading = false;
      emit(LoadingState());
      try {
        MotionToast.error(
                description: Text(response.data["fault"]["faultstring"]))
            .show(context);
      } catch (e) {
        MotionToast.error(description: const Text("We found error in the Api"))
            .show(context);
      }
    }
  }

//fun to encrypt article Data and storage it
  Future saveArticleData(
      ArticleType typeArticle, List<ArticlesModel> articles) async {
    Map<String, String> encryptedArticles = {};
    for (ArticlesModel article in articles) {
      String encryptedArticle =
          CryptoHelper().encrypt(inputString: json.encode(article.toMap()));
      encryptedArticles.putIfAbsent(
        article.title,
        () => encryptedArticle,
      );
    }
    SharedPreference.setDate(
        key: getUrlOrKey(typeArticle, isApi: false),
        value: json.encode(encryptedArticles));
  }
//fun to decrypt article Data and get it from storage to use it if the app is disconnected

  Future getArticleOfflineData(ArticleType typeArticle) async {
    isLoading = true;
    emit(LoadingState());
    List<dynamic> encryptedArticleList = [];
    articles = [];
    if (await SharedPreference.getDate(
          key: getUrlOrKey(typeArticle, isApi: false),
        ) !=
        null) {
      encryptedArticleList.addAll((json.decode(SharedPreference.getDate(
        key: getUrlOrKey(typeArticle, isApi: false),
      )) as Map<String, dynamic>)
          .values);

      for (String encryptedArticle in encryptedArticleList) {
        String decryptArticle =
            CryptoHelper().decrypt(inputString: encryptedArticle);
        articles.add(ArticlesModel.fromJson(json.decode(decryptArticle)));
      }
    }

    isLoading = false;
    emit(GetOfflineArticle());
  }
//fun to storage article Data

  Future saveArticle(String articleUrl) async {
    Directory? directory = await getApplicationCacheDirectory();

    Dio().download("$articleUrl?api-key=NgGTUayqkspuPvoLSy0K7DnLAU3bVcNA",
        "${directory.path}/${articleUrl.split("/").last}");
  }
}
