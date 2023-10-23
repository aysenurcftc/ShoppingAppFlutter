import 'package:flutter/material.dart';

class ManCategories extends StatelessWidget {
  const ManCategories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var screenSize = MediaQuery.of(context);
    final double height = screenSize.size.height;
    final double width = screenSize.size.width;


    return Scaffold(
      body: Column(
        children: [

          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Container(
              color: Colors.white,
              width: width,
              child: ListTile(
                leading: Icon(Icons.apps_outlined),
                title: Row(
                  children: [
                    Text("Tüm Ürünler",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                      ),),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios,
                      color: Colors.grey.shade600,),
                  ],
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Container(
              color: Colors.white,
              width: width,
              child: ListTile(
                leading: Icon(Icons.checkroom_outlined),
                title: Row(
                  children: [
                    Text("Giyim",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                      ),),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios,
                      color: Colors.grey.shade600,),
                  ],
                ),
              ),
            ),
          ),


          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Container(
              color: Colors.white,
              width: width,
              child: ListTile(
                leading: Icon(Icons.shopping_bag_rounded),
                title: Row(
                  children: [
                    Text("Çanta",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                      ),),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios,
                      color: Colors.grey.shade600,),
                  ],
                ),
              ),
            ),
          ),


          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Container(
              color: Colors.white,
              width: width,
              child: ListTile(
                leading: Icon(Icons.diamond_outlined),
                title: Row(
                  children: [
                    Text("Aksesuar",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                      ),),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios,
                      color: Colors.grey.shade600,),
                  ],
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Container(
              color: Colors.white,
              width: width,
              child: ListTile(
                leading: Icon(Icons.directions_run),
                title: Row(
                  children: [
                    Text("Ayakkabı",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                      ),),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios,
                      color: Colors.grey.shade600,),
                  ],
                ),
              ),
            ),
          ),


          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Container(
              color: Colors.white,
              width: width,
              child: ListTile(
                leading: Icon(Icons.scatter_plot),
                title: Row(
                  children: [
                    Text("Kozmetik",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                      ),),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios,
                      color: Colors.grey.shade600,),
                  ],
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Container(
              color: Colors.white,
              width: width,
              child: ListTile(
                leading: Icon(Icons.apps_outlined),
                title: Row(
                  children: [
                    Text("Diğer",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                      ),),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios,
                      color: Colors.grey.shade600,),
                  ],
                ),
              ),
            ),
          ),


        ],
      ),
    );
  }
}
