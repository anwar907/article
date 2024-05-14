import 'package:article/modules/details_pages/view/details_pages_view.dart';
import 'package:article/modules/home_pages/bloc/article_bloc.dart';
import 'package:article/modules/home_pages/view/widgets/carad_article.dart';
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
                        settings: RouteSettings(
                          arguments: state.article,
                        ),
                        builder: (context) => const DetailsPagesView()));
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
                    ...listArticle.asMap().entries.map(
                        (e) => CardArticle(dataKey: e.key, dataValue: e.value))
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
