import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as url;



class home extends StatefulWidget {
  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {

  String possibilities = "C del % / 7 8 9 x 4 5 6 - 1 2 3 + dev 0 . =";
  List sresult=[];
  String operation ='';
  double firstnumber=0.0;
  double secondnumber=0.0;
  double thirdnumber=0.0;
  String display='';

  void updateScreen(){
    setState(() {
      display=sresult.join('');
    });
  }

  void calculate(String data){
    double result = 0;
    int temp=0;
    var numbers = [for(var i=0; i<10; i+=1) i.toString()];
    if(numbers.contains(data)){
      sresult.add(data);
      updateScreen();
    }
    else if(sresult.join('')!='.'&&sresult.join('')!=''){
      //print("operation before number?");
      switch(data){
        case '.':
          if(!sresult.contains(data)){
            sresult.add(data);
            updateScreen();
          }
          break;
        case 'C':
          display='';
          sresult=[];
          operation='';
          updateScreen();
          print("clear");
          break;
        case 'del':
          //pop an element
        sresult.removeLast();
        updateScreen();
          break;
        case '%':
          //10%of100
          operation='%';
          firstnumber=double.parse(sresult.join(''));
          firstnumber/=100;
          sresult=[];
          updateScreen();
          break;
        case '/':
          operation='/';
          firstnumber=double.parse(sresult.join(''));
          sresult=[];
          updateScreen();
          break;
        case 'x':
          operation='x';
          firstnumber=double.parse(sresult.join(''));
          sresult=[];
          updateScreen();
          break;
        case '+':
          operation='+';
          firstnumber=double.parse(sresult.join(''));
          sresult=[];
          print("im here");
          updateScreen();
          break;
        case '-':
          operation='-';
          firstnumber=double.parse(sresult.join(''));
          sresult=[];
          updateScreen();
          break;
        case '=':
          if(firstnumber!=0.0&&operation.isNotEmpty){
            secondnumber=double.parse(sresult.join(''));
            print("calculating $operation");
            switch(operation){
              case '%':
                thirdnumber=firstnumber*secondnumber;
                print(thirdnumber);
                break;
              case '+':
                thirdnumber=firstnumber+secondnumber;
                break;
              case '-':
                thirdnumber=firstnumber-secondnumber;
                break;
              case 'x':
                thirdnumber=firstnumber*secondnumber;
                break;
              case '/':
                thirdnumber=firstnumber/secondnumber;
                break;


            }
            operation='';
            sresult.clear();
            sresult=thirdnumber.toString().split('');
            updateScreen();
          }
          else if(operation.isEmpty&&firstnumber!=0.0){
            updateScreen();
          }
          break; //end of case =
      }
    }
    print(sresult);
  }

  Future<void> _launchURL() async {
    const myurl = 'https://raggyie.github.io/cv/';
    if (await url.canLaunch(myurl)) {
      await url.launch(myurl);
    } else {
      throw 'could not launch $myurl';
    }
  }

  Material makeMyButton(data) {
    return new Material(
      color: Colors.transparent,
      child: new Ink(
        width: 70,
        height: 70,
        decoration: new BoxDecoration(
            border: Border.all(color: Colors.blueAccent),
            color: Colors.black12,
            borderRadius: BorderRadius.circular(20.0)),

        child: new InkWell(
          splashColor: Colors.blueAccent,
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          onTap: (){if(data=='dev'){_launchURL();}else{calculate(data);}},
          child: new Center(
            child: new Text(data,style: new TextStyle(color: Colors.blueAccent,fontSize: 20.0),),),
        ),
      ),
    );
  }

  Expanded rowGenerator(itemlist) {
    itemlist = itemlist.split(' ');
    List<Widget> rowbuttons = [
      makeMyButton(itemlist[0]),
      makeMyButton(itemlist[1]),
      makeMyButton(itemlist[2]),
      makeMyButton(itemlist[3]),
    ];
    return new Expanded(
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: rowbuttons,
        ));
  }






  @override
  Widget build(BuildContext context) {
    return  new Scaffold(
        appBar: new AppBar(
          title: new Text("CALCULATOR"),
          centerTitle: true,
          backgroundColor: Colors.black12,
        ),
        backgroundColor: Colors.black12,
        body: new Container(
          alignment: Alignment.topCenter,
          child: new Column(
            children: [
              new Container(
                decoration: new BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: Colors.black12,
                    border: Border.all(color: Colors.redAccent)
                ),
                height: 90,
                margin: new EdgeInsets.all(20.0),


                child: new Center(


                  //display
                  child: new Text(display,style: new TextStyle(color: Colors.white,fontSize: 30.0)),





                ),
              ),
              new Expanded(
                child: new Container(
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    color: Colors.black.withOpacity(0.3),
                  ),
                  margin: new EdgeInsets.all(20.0),
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      rowGenerator("C del % /"),
                      rowGenerator("7 8 9 x"),
                      rowGenerator("4 5 6 -"),
                      rowGenerator("1 2 3 +"),
                      rowGenerator("dev 0 . ="),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
