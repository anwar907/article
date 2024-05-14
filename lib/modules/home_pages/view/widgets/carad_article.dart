import 'package:article/modules/home_pages/bloc/article_bloc.dart';
import 'package:client/client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardArticle extends StatelessWidget {
  const CardArticle(
      {super.key, required this.dataKey, required this.dataValue});
  final int dataKey;
  final Article dataValue;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: dataKey,
      transitionOnUserGestures: true,
      createRectTween: (begin, end) {
        return Tween(begin: begin, end: end);
      },
      placeholderBuilder: (context, heroSize, child) {
        return Container(
          width: heroSize.width,
          height: heroSize.height,
          color: Colors.grey.shade200,
          child: const Center(child: CircularProgressIndicator()),
        );
      },
      flightShuttleBuilder: (flightContext, animation, flightDirection,
          fromHeroContext, toHeroContext) {
        return ScaleTransition(
          scale: animation.drive(
            Tween(begin: 0.0, end: 6.0).chain(
              CurveTween(curve: Curves.easeInOut),
            ),
          ),
          child: fromHeroContext.widget,
        );
      },
      child: InkWell(
        onTap: () {
          context.read<ArticleBloc>().add(ParsingArticle(article: dataValue));
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Container(
                  padding: const EdgeInsets.all(12.0),
                  height: MediaQuery.of(context).size.height / 3.5,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(dataValue.urlToImage ?? ''))),
                  foregroundDecoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.transparent, Colors.black54]),
                      backgroundBlendMode: BlendMode.colorBurn),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          dataValue.author ?? '',
                          maxLines: 2,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(color: Colors.white),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          dataValue.title ?? '',
                          maxLines: 2,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(color: Colors.white),
                        ),
                      ),
                    ],
                  ))),
        ),
      ),
    );
  }
}
