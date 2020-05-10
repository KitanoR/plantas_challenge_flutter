import 'package:app_plant_shop/widgets/clipper_widget.dart';
import 'package:flutter/material.dart';

import '../core/consts.dart';
import '../core/consts.dart';
import '../core/consts.dart';
import '../core/consts.dart';
import '../models/plant_model.dart';

class PlantAddPage extends StatefulWidget {
  final PlantModel plantModel;
  PlantAddPage({
    @required this.plantModel
  });
  @override
  _PlantAddPageState createState() => _PlantAddPageState();
}

class _PlantAddPageState extends State<PlantAddPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.mainColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          IconButton( 
            icon: Icon(Icons.list, color: Colors.white,),
            onPressed: (){},
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          buildBackgroundGradient(),
          ClipPath(
            clipper: ClipperWidget(),
            child: Container(
              color: AppColors.mainColor,
              width: size.width,
              height: size.height / 2,
            
            ),
          ),
          buildBottomDetail(),
          

        ],
      ),
    );
  }

  Container buildBackgroundGradient() {
    return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color> [
                AppColors.lightMainColor,
                AppColors.mainColor,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter
            )
          ),
        );
  }

  Align buildBottomDetail() {
    return Align(
          alignment: Alignment.bottomCenter,
          child: SafeArea(
            child: Container(
              height: 90,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12))
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 10
                  ),
                  child: Row(
                    children: <Widget>[
                      Image.asset('assets/${widget.plantModel.id}.png'),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                             Text(
                              widget.plantModel.type.toString().replaceFirst('PlantTypeModel.', ''),
                              style: TextStyle(
                                color: Colors.black38
                              ),
                            ),
                            Text(
                              widget.plantModel.name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold
                              ),
                            )
                          ],
                        ),
                      ),
                      Spacer(),
                      Container(
                        child: Icon(Icons.add, color: Colors.white,),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          color: AppColors.mainColor
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
  }
}
