import 'package:dio/dio.dart';
import 'package:exercicio/datasource/api_datasource.dart';
import 'package:exercicio/pages/home_states.dart';
import 'package:exercicio/pages/home_store.dart';
import 'package:exercicio/repository/home_repository_impl.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final store = HomeStore(HomeRepositoryImpl(ApiDatasource(Dio())));

  var scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    store.getItems(store.page);
    store.page = 1;
    store.addListener(() {
      setState(() {
        store.state;
      });
    });

    scrollController.addListener(() {
      var nextItemsTrigger = 0.8 * scrollController.position.maxScrollExtent;

      if (scrollController.position.pixels > nextItemsTrigger) {
        setState(() {
          store.page++;
        });
        store.getItems(store.page);
      }
    });
  }

  @override
  void dispose() {
    store.removeListener(() {});
    super.dispose();
  }

  Widget body() {
    if (store.state is HomeError) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              '${(store.state as HomeError).error} \n tente novamente!',
              textAlign: TextAlign.center,
            ),
          ),
          ElevatedButton(
              onPressed: store.state is! HomeLoading
                  ? () async {
                      await store.getItems(1);
                    }
                  : null,
              child: const Text('Tentar novamente'))
        ],
      );
    }

    if (store.state is HomeLoading && store.page == 1) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return Column(
        children: [
          Expanded(
            child: ListView.builder(
                controller: scrollController,
                itemCount: store.itemList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      store.itemList[index].slug,
                    ),
                  );
                }),
          ),
          if (store.page != 1 && store.state is HomeLoading)
            const Align(
                alignment: Alignment.bottomCenter,
                child: CircularProgressIndicator()),
          Visibility(
            visible: store.page == 1,
            child: ElevatedButton(
                onPressed: store.state is! HomeLoading
                    ? () async {
                        if (store.page < 100) {
                          setState(() {
                            store.page++;
                          });
                          await store.getItems(store.page);
                        }
                      }
                    : null,
                child: const Text('Carregar mais items')),
          ),
          const SizedBox(height: 20),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          scrollController.animateTo(0,
              duration: const Duration(seconds: 1), curve: Curves.ease);
        },
        child: const Icon(Icons.arrow_upward),
      ),
      appBar: AppBar(
        title: const Text('Lista'),
      ),
      body: body(),
    );
  }
}
