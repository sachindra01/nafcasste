import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nafcassete/src/helpers/styles.dart';
import 'package:nafcassete/src/views/collection/collection_listPage.dart';
import 'package:nafcassete/src/views/collection/mycollection_list_page.dart';


class CollectionPage extends StatefulWidget {
  final int ?index;
  const CollectionPage({super.key, this.index});

  @override
  State<CollectionPage> createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> with SingleTickerProviderStateMixin {
 late TabController _tabController ;

 @override
void initState() {
  super.initState();
  _tabController = TabController(vsync: this, length: 2);
}

@override
void dispose() {
  _tabController.dispose();
  super.dispose();
}


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex:widget.index?? 0,
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            elevation: 0.0,
            leading:widget.index==1
            ? IconButton(
              onPressed: () => Get.back(), 
              icon: const Icon(
                Icons.arrow_back_ios,
                color: black,
              )
            )
            :const SizedBox(),
            title: Center(
                child: Text('コレクション',style: w7f14(black),
              ),
            ),
            actions:const [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.more_horiz,color: black,),
              )
            ],
            backgroundColor: white,
            bottom:  TabBar(
            indicatorColor: redCol,
            indicatorWeight: 2.0,
            labelColor: redCol,
            labelPadding: const EdgeInsets.only(top: 10.0),
            unselectedLabelColor: black,
            labelStyle: w7f14(
              black
            ),
            tabs: const [
              Tab(
                text: 'お気に入り',
              ),
              Tab(
                text: 'Myカセット',
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Center(
              child: CollectionListPage()
            ),
            Center(  
              child: MyCollectionListPage(),
            )
          ],
        ),
      ),
    );
  }
}