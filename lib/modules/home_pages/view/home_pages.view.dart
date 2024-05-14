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
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
          child:
              BlocBuilder<ArticleBloc, ArticleState>(builder: (context, state) {
            final listArticle = state.articleModels?.articles ?? [];
            if (state.status == GlobalStateStatus.loading) {
              return const Center(
                  heightFactor: 2, child: CircularProgressIndicator());
            }

            if (state.status == GlobalStateStatus.success) {
              return Column(children: [
                ...listArticle.map((e) => Padding(
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
                                      image: NetworkImage(e.urlToImage ?? ''))),
                              foregroundDecoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.transparent,
                                        Colors.black54
                                      ]),
                                  backgroundBlendMode: BlendMode.colorBurn),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Text(
                                      e.author ?? '',
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
                                      e.title ?? '',
                                      maxLines: 2,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge
                                          ?.copyWith(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ))),
                    ))
              ]);
            }

            if (state.status == GlobalStateStatus.error) {
              return Center(child: Text(state.message ?? ''));
            }

            return Container();
          }),
        ),
      ),
    );
  }
}
