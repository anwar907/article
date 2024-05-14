import 'package:client/client.dart';
import 'package:flutter/material.dart';

class DetailsPagesView extends StatelessWidget {
  const DetailsPagesView({super.key, required this.article});

  final Article article;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          article.title ?? '',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: Hero(
        tag: article.author ?? '',
        flightShuttleBuilder: (flightContext, animation, flightDirection,
            fromHeroContext, toHeroContext) {
          return Material(
              child: Image.network(
            article.urlToImage ?? '',
            width: 50,
          ));
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height / 3,
                    child: Image.network(
                      article.urlToImage ?? '',
                      fit: BoxFit.cover,
                    )),
              ),
              Text(
                article.author ?? '',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(article.description ?? ''),
              const SizedBox(
                height: 12,
              ),
              Text(article.content ?? ''),
              const SizedBox(
                height: 12,
              ),
              Text('Read More: ${article.url}'),
            ],
          ),
        ),
      ),
    );
  }
}
