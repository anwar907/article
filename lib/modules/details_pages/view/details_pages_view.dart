import 'package:client/client.dart';
import 'package:flutter/material.dart';

class DetailsPagesView extends StatelessWidget {
  const DetailsPagesView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Article;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          args.title ?? '',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: Hero(
        tag: args.author ?? '',
        flightShuttleBuilder: (flightContext, animation, flightDirection,
            fromHeroContext, toHeroContext) {
          return Material(
              child: Image.network(
            args.urlToImage ?? '',
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
                      args.urlToImage ?? '',
                      fit: BoxFit.cover,
                    )),
              ),
              Text(
                args.author ?? '',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(args.description ?? ''),
              const SizedBox(
                height: 12,
              ),
              Text(args.content ?? ''),
              const SizedBox(
                height: 12,
              ),
              Text('Read More: ${args.url}'),
            ],
          ),
        ),
      ),
    );
  }
}
