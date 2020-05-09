import 'package:flutter/material.dart';

import '../core/consts.dart';
import '../core/consts.dart';
import '../core/consts.dart';
import '../models/plant_model.dart';
import '../models/plant_model.dart';
import '../models/plant_type_model.dart';
import '../models/plant_type_model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<PlantModel> _plants;

  @override
  void initState() {
    _plants = PlantModel.plants;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: DefaultTabController(
        length: PlantTypeModel.values.length,
        child: NestedScrollView(
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
                    start: 12,
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
                child: ListView(
                      children: <Widget>[
                        SizedBox(
                          height: 300,
                          child: ListView.builder(
                            itemCount: _plants.length,
                            scrollDirection: Axis.horizontal, 
                            itemBuilder: (BuildContext context, int index) { 
                              return _buildItemSlider(index);
                             },
                          ),
                        ),
                        Text(
                          'Lastest favorites',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: _plants.length,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return _buildItemLast(index);
                          },
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
    return Container(
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
    );
  }

  Widget _buildItemLast(int index) {
    return Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12))
        ),
        child: Stack(
          children: <Widget>[
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                   Image.asset(
                     'assets/${_plants[index].id}.png',
                     height: 60,
                    ),
                    Column(
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
                        Text(
                          '2',
                          style: TextStyle(
                            fontWeight: FontWeight.bold
                          ),
                        )
                      ],
                    )
                ],
              ),
            )
          ],
        ),
    );
  }
}
