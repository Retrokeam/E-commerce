import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
      children: [
          SizedBox(
            height: 100,
          ),
          Row(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 80),
                    child: Text(
                      "Our",
                      style: TextStyle(fontFamily: "sans-serif-medium", fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    "Products",
                    style: TextStyle(fontFamily: "sans-serif-medium",fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 80.0),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
                labelText: 'Search Products',
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                horizontalItems(
                    Colors.blueAccent.withOpacity(0.8), "A32.jpeg", "Phones"),
                horizontalItems(
                    Colors.amber.withOpacity(0.8), "boots.jpeg", "Shoes"),
                horizontalItems(
                    Colors.red.withOpacity(0.5), "puffer.jpeg", "Jackets"),
                horizontalItems(
                    Colors.greenAccent.withOpacity(0.5), "casio1.jpg", 'Watches'),
              ],
            ),
          ),
          SizedBox(
            height: 40,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                products("A12.jpeg", "Samsung A12", "Quick Sale", "Dawn Blue", 12000.00),
                products("iPhone x.jpeg", "iPhone X", "Quick Sale", "Dawn Blue", 120000.00),
                products("official.jpeg", "Men Official", "Limited offer", "Black Leather", 4500.00),
                products("boots.jpeg", "Men Boots", "50% off",  "Polo Silk Leather",3000.00),
                products("airforce.jpeg", "Nike Airforce", "In Stock", "Tripple white", 3500.00),
                products("sneaker.jpeg", "Sneaker", "Out of stock", "Breathable", 2500.00),
                products('sports.jpg', 'Adidas sports', "Out of Stock", "Running shoes", 1000.00),
                products('puffer.jpeg', 'Puffer', "Out of Stock",  "Night Jacket",1500.00),
                products('leather.jpeg', 'Leather', "Out of Stock",  "Genuine leather",2000.00),
                products('bomper.jpeg', 'Bomper', "Out of Stock",  "Water proof",1500.00),
                products("Gshock.jpeg", "Casio Enticer", "In stock", "Dual purpose", 800.00),
                products("casio.jpg", "Digital Casio", "In stock", "Water resistant", 500.0),
                products("ice.jpeg", "Magistrate watch", "In stock", "Iced body", 4500.00),
                products("watch.jpeg", "Casio", "In stock",  "Leather straps",500.0),
              ],
            ),
          )
      ],
    ),
        ));
  }

  Widget horizontalItems(Color color, String asset, String itemName) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.only(left: 20),
        height: 80,
        width: 150,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/$asset",
                        width: 40,
                      ),
                      Text(
                        "$itemName",
                        style: TextStyle(fontFamily: "sans-serif", fontWeight: FontWeight.bold,fontSize: 18),
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget products(String asset, String itemName, String status, String description, double price) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.only(left: 20),
        height: 280,
        width: 200,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [Icon(Icons.favorite_border)],
                  ),
                  Image.asset(
                    "assets/$asset",
                    width: 90,
                  ),
                  Text(
                    "$itemName",
                    style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "$status",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.deepOrange),
                  ),
                  Text(
                    "$description",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.deepOrange),
                  ),
                  Text(
                    "Kes:${price.toString()}",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.deepOrange),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
