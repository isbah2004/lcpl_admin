import 'package:flutter/material.dart';
import 'package:lcpl_admin/provider/home_index_provider.dart';
import 'package:lcpl_admin/screens/postscreens/add_files.dart';
import 'package:lcpl_admin/theme/theme.dart';
import 'package:lcpl_admin/utils/constants.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    List<FloatingActionButton> fabOptions = <FloatingActionButton>[
      FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddFile(appBartitle: 'Add Document', collection: 'document',),),);
        },
        tooltip: 'Add Document',
        child: const Icon(Icons.add),
      ),
      FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddFile(appBartitle: 'Add Audio', collection: 'audio',),),);},
        tooltip: 'Add Audio',
        child: const Icon(Icons.add),
      ),
      FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddFile(appBartitle: 'Add Quotes', collection: 'quotes',),),);},
        tooltip: 'Add Quotes',
        child: const Icon(Icons.add),
      ),
      FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddFile(appBartitle: 'Add Video', collection: 'video',),),);},
        tooltip: 'Add Video',
        child: const Icon(Icons.add),
      ),
    ];

    final homeIndexProvider = Provider.of<HomeIndexProvider>(context);
    return Scaffold(
      backgroundColor: AppTheme.whiteColor,
      appBar: AppBar(
        title: const Text('Tab Navigation Example'),
      ),
      body: Center(
        child:
            Constants.widgetOptions.elementAt(homeIndexProvider.selectedIndex),
      ),
      bottomNavigationBar: Consumer<HomeIndexProvider>(
        builder:
            (BuildContext context, HomeIndexProvider value, Widget? child) {
          return BottomNavigationBar(
            elevation: 0,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.document_scanner),
                label: Constants.documents,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.audiotrack),
                label: Constants.audios,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.format_quote_outlined),
                label: Constants.quotes,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.video_collection),
                label: Constants.videos,
              ),
            ],
            currentIndex: value.selectedIndex,
            onTap: (index) {
              value.setIndex(index);
            },
          );
        },
      ),
      floatingActionButton:
          fabOptions.elementAt(homeIndexProvider.selectedIndex),
    );
  }
}
