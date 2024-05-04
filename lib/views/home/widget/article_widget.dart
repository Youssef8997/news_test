import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hamazh_auth/data/model/articles_model.dart';
import 'package:hamazh_auth/utls/helper/extension.dart';
import 'package:intl/intl.dart';

import '../../../utls/base_widget/base_widget.dart';
import '../../../utls/manger/assets_manger.dart';
import '../../../utls/manger/color_manger.dart';
import '../../../utls/manger/fonts_manger.dart';
import '../../article/screen/article_screen.dart';

class ArticleWidget extends StatefulWidget {
  final ArticlesModel article;
  const ArticleWidget({super.key, required this.article});

  @override
  State<ArticleWidget> createState() => _ArticleWidgetState();
}

class _ArticleWidgetState extends State<ArticleWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navigatorWid(
            page: ArticlesScreen(
              articles: widget.article,
            ),
            context: context,
            returnPage: true);
      },
      child: Row(
        children: [
          CachedNetworkImage(
            imageUrl: widget.article.multimedia.firstOrNull?.url ?? "",
            cacheKey: widget.article.multimedia.firstOrNull?.url ?? "",
            useOldImageOnUrlChange: true,
            imageBuilder: (context, i) => Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(image: i, fit: BoxFit.cover)),
            ),
            progressIndicatorBuilder: (context, i, l) =>
                CircularProgressIndicator.adaptive(
              value: l.progress,
              backgroundColor: Colors.white,
            ),
            errorWidget: (context, i, _) => Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: const DecorationImage(
                      image: AssetImage(
                        AssetsManger.newYorkTimeLogo,
                      ),
                      fit: BoxFit.cover)),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: context.width * .56,
                child: Text(
                  widget.article.title,
                  style: FontsManger.mediumFont(context)
                      .copyWith(fontSize: 12, color: ColorsManger.white),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                DateFormat('yyyy-MM-dd hh:mm a')
                    .format(DateTime.parse(widget.article.publishedDate)),
                style: FontsManger.mediumFont(context).copyWith(
                    fontSize: 10, color: ColorsManger.white.withOpacity(.5)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
