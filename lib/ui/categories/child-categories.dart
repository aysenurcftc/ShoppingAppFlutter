import 'package:flutter/material.dart';

class ChildCategories extends StatelessWidget {
  const ChildCategories({Key? key}) : super(key: key);

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
                leading: Icon(Icons.child_care),
                title: Row(
                  children: [
                    Text("Kız Çocuk",
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
                leading: Icon(Icons.child_care),
                title: Row(
                  children: [
                    Text("Erkek Çoçuk",
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
                leading: Icon(Icons.toys),
                title: Row(
                  children: [
                    Text("Oyuncak",
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
                leading: Icon(Icons.child_friendly_outlined),
                title: Row(
                  children: [
                    Text("Bebek",
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
