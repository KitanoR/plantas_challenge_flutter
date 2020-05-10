import 'package:flutter/material.dart';

import '../core/consts.dart';
import '../core/consts.dart';
import '../core/consts.dart';
import '../core/consts.dart';
import '../models/plant_model.dart';
import '../models/plant_model.dart';
import '../models/plant_model.dart';
import '../models/plant_type_model.dart';
import '../models/plant_type_model.dart';
import '../models/plant_type_model.dart';
import 'plant_add_page.dart';
import 'plant_add_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<PlantModel> _plants;
  ScrollController _scrollController;
  double _offset;
  bool _isStrink;


  @override
  void initState() {
    _offset = 0.0;
    _scrollController = new ScrollController();
    _scrollController.addListener(_scrollListener);
    _plants = PlantModel.plants;
    super.initState();
  }

  @override
  void dispose() {
    _scrollController?.dispose();
    super.dispose();
  }

  _scrollListener() {
    setState(() {
      if(_scrollController.offset < 75) {
        _offset = _scrollController.offset;
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: DefaultTabController(
        length: PlantTypeModel.values.length,
        child: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (context, index) {
            return <Widget> [
              SliverAppBar(
                expandedHeight: 125,
                backgroundColor: Colors.white,
                pinned: true,
                floating: false,
                elevation: 0,
                actions: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.menu,
                      color: Colors.black,
                    ),
                    onPressed: (){},
                  )
                ],
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  ),
                  onPressed: (){},
                ),
                flexibleSpace: FlexibleSpaceBar(
                  titlePadding: EdgeInsetsDirectional.only(
                    start: 12 + ((_offset / 100) * 60),
                    bottom: 16
                  ),
                  centerTitle: false,
                  title: Text(
                    'New plants',
                    style: TextStyle(
                      color: Colors.black
                    ),
                  ),
                ),
              )
            
            ];
          },
          body: Column(
            children: <Widget>[
              _searchBar(),
              _tabBar(),
              Expanded(
                child: TabBarView(
                   children: <Widget>[
                     ...PlantTypeModel.values.map((data){
                       return ListView(
                        padding: EdgeInsets.all(0),
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: SizedBox(
                              height: 300,
                              child: ListView.builder(
                                itemCount: _plants.length,
                                scrollDirection: Axis.horizontal, 
                                itemBuilder: (BuildContext context, int index) { 
                                  return _buildItemSlider(index);
                                 },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              'Lastest favorites',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: ListView.builder(
                              padding: EdgeInsets.all(0),
                              shrinkWrap: true,
                              itemCount: _plants.length,
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return _buildItemLast(index);
                              },
                            ),
                          )
                        ],
                      );
                
                     })
                   ],
                ),
              )
            
            ],
          ),
        ),
      ),
    );
  }

  TabBar _tabBar() {
    return TabBar(
              isScrollable: true,
              indicatorColor: Colors.white,
              labelColor: AppColors.mainColor,
              unselectedLabelColor: Colors.black,
              unselectedLabelStyle: TextStyle(
                fontWeight: FontWeight.normal
              ),
              labelStyle: TextStyle(fontWeight: FontWeight.bold),
              tabs: <Widget>[
                ...PlantTypeModel.values.map((data){
                  return Tab(
                    text: data.toString().replaceFirst("PlantTypeModel.", ""),
                  );
                })
              ],
            );
  }

  Widget _searchBar() {
    return Padding(
      padding:  EdgeInsets.all(12.0),
      child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(
                      Radius.circular(12.0)
                    )
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  hintText: "Buscar...",
                  suffixIcon: Container(
                    child: Icon(
                      Icons.filter_list,
                      color: Colors.white,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius: BorderRadius.all(Radius.circular(12.0))
                    ),
                  )
                ),
              ),
    );
  }

  Widget _buildItemSlider(int index) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) 
         => PlantAddPage(plantModel: _plants[index],)));
      },
      child: Container(
        width: 200,
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12))
          ),
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  _plants[index].type.toString().replaceFirst('PlantTypeModel.', ''),
                  style: TextStyle(
                    color: Colors.black38
                  ),
                ),
                Text(
                  _plants[index].name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold
                  ),
                ),
                Spacer(),
                Image.asset('assets/${_plants[index].id}.png'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'From',
                          style: TextStyle(
                            color: Colors.black38
                          ),
                        ),
                        Text(
                          '${_plants[index].price.toString()} \$',
                          style: TextStyle(
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                    Container(
                      child: Icon(Icons.add, color: Colors.white,),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        color: AppColors.mainColor
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildItemLast(int index) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)
        => PlantAddPage(plantModel: _plants[index])));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16))
            ),
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    width: 100,
                    height: 70,
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius: BorderRadius.all(Radius.circular(16))
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        _buildFavoriteButton(Icons.add, (){}),
                        Spacer(),
                        Container(height: .5, width: 40, color: Colors.black38,),
                        Spacer(),
                        _buildFavoriteButton(Icons.remove, (){}),
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(16))
                  ),
                  height: 70,
                  margin: EdgeInsets.only(right: 50,),
                  padding: EdgeInsets.all(4),
                  child: Row(
                    children: <Widget>[
                       Padding(
                         padding: const EdgeInsets.symmetric(horizontal: 12.0),
                         child: Image.asset(
                           'assets/${_plants[index].id}.png',
                           height: 60,
                          ),
                       ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              _plants[index].type.toString().replaceFirst('PlantTypeModel.', ''),
                              style: TextStyle(
                                color: Colors.black38
                              ),
                            ),
                            Text(
                              '${_plants[index].price.toString()} \$',
                              style: TextStyle(
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            '2',
                            style: TextStyle(
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        )
                    ],
                  ),
                )
              ],
            ),
        ),
      ),
    );
  }

  Widget _buildFavoriteButton(IconData add, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 40,
        child: Icon(add, color: Colors.white,),
      ),
    );
  }
}
