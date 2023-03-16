import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  // Verileri veritabanından çekerken performanslı bir şekilde çekmemiz gerekiyor bunun için Future özelliği olan
  // async özelliği olan metodları kullanıyoruz yani Future özelliği olan metodlarla biz verilerimizi alıyoruz
  // aldıktan sonra bunu arayüzde göstermemiz gerekiyor, arayüzde Future metodunu çalıştırmak için FutureBuilder yapısını
  // kullancağız, arayüzde veri gelmiyorsa hatalardan kurtulmak için boş bir center() return edebiliriz

  Future<List<String>> verileriGetir() async{
    var ulkeListesi = ["Türkiye", "Almanya", "İtalya", "Rusya", "Çin"];
    return ulkeListesi;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Future Builder Listeleme"),
      ),
      body: FutureBuilder<List<String>>(  // hangi türde veri döneceğini belirtmemiz gerekiyor
        future: verileriGetir(),  // metodun ismi
        builder: (context, snapshot){ // bu metodun sonucunu alacağımız yer, snapshot nesnesi ile verilerimizi alabileceğiz,
          // veri gelip gelmediğini kontrol edeceğiz
          if(snapshot.hasData){ // veri varsa burası çalışacak
            var ulkeListesi = snapshot.data;  //veri varsa önce gelen veri kümesini alıyoruz
            return ListView.builder( // arayüzde listeleme işlemi yapacağız
              itemCount: ulkeListesi!.length,
              itemBuilder: (context, indeks){ //sırayla indeksleri verecek ve dinamik bir şekilde tasarımda göstereceğiz
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0), // yazının sol tarafınad boşluk oluşturmak için
                    child: SizedBox(
                      height: 50,
                      child: Row(
                        children: [
                          Text(ulkeListesi[indeks]),
                        ],
                      ),
                    ),
                  ),
                );
              }
            );
          } else{ // veri yoksa/gelmiyorsa burası çalışacak
            return Center();  // veri yoksa boş bir tasarım göstermek istiyoruz
          }
      }
      ),

    );
  }
}
