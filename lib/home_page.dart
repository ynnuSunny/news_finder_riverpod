import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_finder_riverpod/providers/news_provider.dart';
import 'package:news_finder_riverpod/widgets/news_card.dart';
import 'package:news_finder_riverpod/widgets/search_field.dart';

import 'models/news_model.dart';
import 'news_details.dart';


class HomePage extends ConsumerWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {

    NewsModel news = ref.watch(newsProvider).newsModel;
    bool isLoading = ref.watch(newsProvider).isLoading;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child:
          Column(
              children: [
                const SearchField(),
                isLoading ?
                SizedBox(
                  height: MediaQuery.of(context).size.height/2,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ): Expanded(
                  child: ListView.builder(
                    itemCount: news.articles!.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          // Navigate to the detail screen when an item is tapped
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NewsDetailScreen(
                                article: news.articles![index],
                              ),
                            ),
                          );
                        },
                        child: NewsCard(article: news.articles![index]),
                      );
                    },
                  ),
                )
              ]
          )
      ),
    );
  }
}