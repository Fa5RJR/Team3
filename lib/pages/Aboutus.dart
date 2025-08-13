import 'package:flutter/material.dart';

class about extends StatelessWidget {
  const about({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(color: Colors.white),
            child:ListView(
              children: [
                Container(
                  margin: EdgeInsets.all(15),
                  child: AnimatedOpacity(
                      opacity: 1.0,
                      duration:Duration(seconds: 2),
                      child: Image.asset("assets/images/sanad logo.jpg",height: 150,width: 150,)),
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(margin:EdgeInsets.all(15), child: Text(" Advantages of 3D Printing in Prosthetic Manufacturing",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold, color: Color(0xFF0A2152),),)),
                      Container(margin:EdgeInsets.all(10), child:Text("* Fast manufacturing",style: TextStyle(fontSize: 20,color: Colors.white,),)),
                      Container(margin:EdgeInsets.all(10), child:Text("* Full customization",style: TextStyle(fontSize: 20,color: Colors.white,),)),
                      Container(margin:EdgeInsets.all(10), child:Text("* Easy maintenance and replacement",style: TextStyle(fontSize: 20,color: Colors.white,),)),
                      Container(margin:EdgeInsets.all(10), child:Text("* Lightweight",style: TextStyle(fontSize: 20,color: Colors.white,),)),
                      Container(margin:EdgeInsets.all(10), child:Text("* Comfort",style: TextStyle(fontSize: 20,color: Colors.white,),)),
                      Container(margin:EdgeInsets.all(10), child:Text("* Accessibility",style: TextStyle(fontSize: 20,color: Colors.white,),)),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(margin:EdgeInsets.all(15), child: Text(" Process of manufacturing",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color:Color(0xFF0A2152) ,),)),
                      Container(margin:EdgeInsets.all(10), child:Text("* Diagnosis and scanning",style: TextStyle(fontSize: 20,color: Colors.white,),)),
                      Container(margin:EdgeInsets.all(10), child:Text("* 3D model design",style: TextStyle(fontSize: 20,color: Colors.white,),)),
                      Container(margin:EdgeInsets.all(10), child:Text("* Resource selection",style: TextStyle(fontSize: 20,color: Colors.white,),)),
                      Container(margin:EdgeInsets.all(10), child:Text("* Printing",style: TextStyle(fontSize: 20,color: Colors.white,),)),
                      Container(margin:EdgeInsets.all(10), child:Text("* Finishing and assembly",style: TextStyle(fontSize: 20,color: Colors.white,),)),
                      Container(margin:EdgeInsets.all(10), child:Text("* Trial and modification",style: TextStyle(fontSize: 20,color: Colors.white,),)),
                      Container(margin:EdgeInsets.all(10), child:Text("* Final testing",style: TextStyle(fontSize: 20,color: Colors.white,),)),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(15),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset("assets/images/IMG-20250805-WA0070.jpg"),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(margin:EdgeInsets.all(15), child: Text(" Smart gloves with 3D printing technology",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),)),
                      Container(margin:EdgeInsets.all(10), child:Text("* The smart glove uses high-speed gyroscope technology and motion sensors to reduce hand tremors and stabilize movement. Gyroscopes generate angular momentum that resists sudden direction changes, while sensors detect motion and activate small motors to counteract vibrations. This allows patients to perform daily activities like writing and eating more naturally.",style: TextStyle(fontSize: 20,color: Colors.white,),)),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(15),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset("assets/images/gloves3.jpg"),
                  ),
                ),
                Image.asset("assets/images/team3.jpg"),
                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/Sign in'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:  Colors.teal,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child:  Text(
                    "Read",
                    style: TextStyle(fontSize: 20, color: Color(0xFF0A2152)),
                  ),
                ),




              ],
            ),),
        )

    );
  }
}