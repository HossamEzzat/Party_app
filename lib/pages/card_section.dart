import 'package:flutter/material.dart';
import 'package:wedding/main.dart';
import 'package:wedding/pages/home_section.dart';

class card_section extends StatefulWidget {
  const card_section({super.key});

  @override
  State<card_section> createState() => _card_sectionState();
}

class _card_sectionState extends State<card_section> {
  List carditem = [
    {
      "name" : "birthday",
      "image": 'assets/5760.webp',
      "title": "اعياد الميلاد",
    },
    {
      "name": "hall",
      "image": 'assets/image.jpg',
      "title": "حفلات ومناسبات",
    },
    {
      "name": "wedding",
      "image": 'assets/download.jpeg',
      "title": "حفلات الزواج",
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
              children: [
                 Container(
            height: 120.0,
            decoration: BoxDecoration(
              color: Colors.blueGrey[900],
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24.0),
                bottomRight: Radius.circular(24.0),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(top: 40.0, left: 16.0, right: 16.0),
              child:
                  Container(
                    width: double.infinity,
                    
                    child: Center(
                      child: Text(
                        '!إختر مناسبتك',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              
            ),
          ),
                const SizedBox(
                  height: 10,
                ),
              
                Expanded(
                  child: ListView.builder(
                      itemCount: carditem.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding:
                              const EdgeInsets.only(left: 15, right: 15, top: 20),
                          child: InkWell(
                            onTap: (){
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (BuildContext context) => home_section(
      indexSearch: carditem[index]["name"]
    ),
  ),
);                            },
                            child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: AssetImage(carditem[index]["image"]),
                                fit: BoxFit.fill,
                              ),
                            ),
                            child: Stack(
                              children: [
                                Container(
                                  height: 170,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.4),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Text(
                                      carditem[index]["title"],
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),),
                          )
                        );
                      }),
                ),
              ],
            ));
  }
}
