import 'package:article/modules/details_pages/view/details_pages_view.dart';
import 'package:article/modules/home_pages/bloc/article_bloc.dart';
import 'package:client/client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePagesView extends StatelessWidget {
  const HomePagesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Article Pages'),
      ),
      body: RefreshIndicator(
        onRefresh: () => context.read<ArticleBloc>().getArticle(),
        child: SingleChildScrollView(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
            child: BlocListener<ArticleBloc, ArticleState>(
              listener: (context, state) {
                if (state.status == GlobalStateStatus.success) {
                  if (state.article != null) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            DetailsPagesView(article: state.article!)));
                  }
                }
              },
              child: BlocBuilder<ArticleBloc, ArticleState>(
                  builder: (context, state) {
                final listArticle = state.articleModels?.articles ?? [];
                if (state.status == GlobalStateStatus.loading) {
                  return const Center(
                      heightFactor: 2, child: CircularProgressIndicator());
                }

                if (state.status == GlobalStateStatus.success) {
                  return Column(children: [
                    ...listArticle.asMap().entries.map((e) => Hero(
                          tag: e.key,
                          transitionOnUserGestures: true,
                          createRectTween: (begin, end) {
                            return Tween(begin: begin, end: end);
                          },
                          placeholderBuilder: (context, heroSize, child) {
                            return Container(
                              width: heroSize.width,
                              height: heroSize.height,
                              color: Colors.grey.shade200,
                              child: const Center(
                                  child: CircularProgressIndicator()),
                            );
                          },
                          flightShuttleBuilder: (flightContext, animation,
                              flightDirection, fromHeroContext, toHeroContext) {
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
                              context
                                  .read<ArticleBloc>()
                                  .add(ParsingArticle(article: e.value));
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 12.0),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12.0),
                                  child: Container(
                                      padding: const EdgeInsets.all(12.0),
                                      height:
                                          MediaQuery.of(context).size.height /
                                              3.5,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  e.value.urlToImage ?? ''))),
                                      foregroundDecoration: const BoxDecoration(
                                          gradient: LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: [
                                                Colors.transparent,
                                                Colors.black54
                                              ]),
                                          backgroundBlendMode:
                                              BlendMode.colorBurn),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Align(
                                            alignment: Alignment.topRight,
                                            child: Text(
                                              e.value.author ?? '',
                                              maxLines: 2,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall
                                                  ?.copyWith(
                                                      color: Colors.white),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.bottomLeft,
                                            child: Text(
                                              e.value.title ?? '',
                                              maxLines: 2,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge
                                                  ?.copyWith(
                                                      color: Colors.white),
                                            ),
                                          ),
                                        ],
                                      ))),
                            ),
                          ),
                        ))
                  ]);
                }

                if (state.status == GlobalStateStatus.error) {
                  return Center(child: Text(state.message ?? ''));
                }

                return Container();
              }),
            )),
      ),
    );
  }
}
