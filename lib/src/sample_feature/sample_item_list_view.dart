// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pyme_app/src/sample_feature/cubit/list_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pyme_app/src/sample_feature/sample_item.dart';

import '../settings/settings_view.dart';
// import 'sample_item.dart';
import 'sample_item_details_view.dart';

// class ListBloc {
//   final RealmResults<SampleItem> items;
//   final Realm _realm;

//   ListBloc({required this.items}) : _realm = items.realm;

//   void addNewItem() {
//     _realm.write(() => _realm.add(SampleItem(1 + (items.lastOrNull?.id ?? 0))));
//   }
// }

// class ListCubit {
//   final RealmResults<SampleItem> items;
//   final Realm _realm;

//   ListCubit({required this.items}) : _realm = items.realm;

//   void addNewItem() {
//     _realm.write(() => _realm.add(SampleItem(1 + (items.lastOrNull?.id ?? 0))));
//   }
// }

class SampleItemListView extends StatelessWidget {
  const SampleItemListView({
    super.key,
    required this.bloc,
  });

  static const routeName = '/';

  final ListCubit bloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample Items'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to the settings page. If the user leaves and returns
              // to the app after it has been killed while running in the
              // background, the navigation stack is restored.
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          bloc.addNewItem();
        },
        child: const Icon(Icons.add),
      ),

      // To work with lists that may contain a large number of items, it’s best
      // to use the ListView.builder constructor.
      //
      // In contrast to the default ListView constructor, which requires
      // building all Widgets up front, the ListView.builder constructor lazily
      // builds Widgets as they’re scrolled into view.

      body: BlocProvider<ListCubit>.value(
        value: bloc,
        child: BlocBuilder<ListCubit, List<SampleItem>>(
          builder: (context, state) {
            return ListView.builder(
              // Providing a restorationId allows the ListView to restore the
              // scroll position when a user leaves and returns to the app after it
              // has been killed while running in the background.
              restorationId: 'sampleItemListView',
              itemCount: bloc.items.length,
              itemBuilder: (BuildContext context, int index) {
                final item = bloc.items[index];

                return Dismissible(
                  key: Key(item.id.toString()),
                  onDismissed: (_) => bloc.deleteItem(item),
                  child: ListTile(
                    title: Text('SampleItem ${item.id}'),
                    leading: const CircleAvatar(
                      // Display the Flutter Logo image asset.
                      foregroundImage:
                          AssetImage('assets/images/flutter_logo.png'),
                    ),
                    onTap: () {
                      // Navigate to the details page. If the user leaves and returns to
                      // the app after it has been killed while running in the
                      // background, the navigation stack is restored.
                      Navigator.restorablePushNamed(
                        context,
                        SampleItemDetailsView.routeName,
                      );
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
