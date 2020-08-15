import 'package:flutter/material.dart';
import 'package:helping_hands/components/rounded_button.dart';
import 'package:helping_hands/components/rounded_input_field.dart';
import 'package:helping_hands/constants.dart';
import 'package:helping_hands/crude.dart';
import 'Screens/Login/components/background.dart';
class DonerVisitPage extends StatefulWidget {
  @override
  _DonerVisitPageState createState() => _DonerVisitPageState();
}

class _DonerVisitPageState extends State<DonerVisitPage> {
  Stream blogStream;
  CrudeMethods objCrude = CrudeMethods();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    objCrude.getData().then((value) {
      setState(() {
        blogStream=value;
      });
    });
  }

  Widget BlogsList() {
    return blogStream !=  null    ?
    ListView(

      shrinkWrap: true,
      children:<Widget>[
        StreamBuilder(
          stream: blogStream,
          builder: (context,snapshot) {
            return snapshot.data ==null?Container(
              child: CircularProgressIndicator(),
            ): ListView.builder(
              itemCount: snapshot.data.documents.length,
              shrinkWrap: true,
              controller: _controller,
              itemBuilder: (context, index) {
                //                  author:snapshot.data.documents[index].data['author'],
                return CardData(
                  name : snapshot.data.documents[index].data['user'],
                  type:snapshot.data.documents[index].data['type'] ,
                );
              },);
          },

        ),
      ],
    )

        : Container(
      alignment: Alignment.center,
      child: CircularProgressIndicator(),
    );
  }

  ScrollController _controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
   String searchString;
    return SafeArea(
      child: Scaffold(
        body:SingleChildScrollView(
          child: Background(
            child: Column(
              children: <Widget>[
                Container(
                  child: Container(
                    margin: EdgeInsets.only(top: 50),
                   height: size.height*0.1,
                    width: double.infinity,
                    child: RoundedInputField(
                      hintText: 'search',
                      icon: Icons.search,
                      onChanged: (value){
                        setState(() {
                          searchString = value;
                        });
                      },
                    ),
                  ),
                ),
                Container(
                  height: size.height * 0.8,
                  width: double.infinity,
                  child:BlogsList(),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
 class CardData extends StatelessWidget {
  final String name,number,type;

  const CardData({Key key, this.name, this.number, this.type}) : super(key: key);
   @override
   Widget build(BuildContext context) {
     Size size = MediaQuery.of(context).size;

     return Align(
       alignment: Alignment.topCenter,
       child: Container(
         margin: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
         height: size.height*0.21,
         decoration: BoxDecoration(
             color: kPrimaryLightColor,

             borderRadius: BorderRadius.circular(15),
             boxShadow: [
               BoxShadow(
                 color: Colors.black.withOpacity(0.3),
                 offset: Offset(0, 10),
                 blurRadius: 10,
               ),

             ]
         ),
         child: Column(
           mainAxisAlignment: MainAxisAlignment.spaceAround,
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: <Widget>[
             Text('$name',textAlign: TextAlign.center,
               style: TextStyle(fontSize: 30,),),
             Text('$type',textAlign: TextAlign.center ,
               style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
             GestureDetector(
               onTap: null,
               child: Align(
                 alignment: Alignment.center,
                 child: Container(
                   width: size.width * 0.3,
                   height: 45,
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(20),
                     color: kPrimaryColor,
                   ),
                   child: Align(
                     alignment: Alignment.center,
                     child: Text('Get',textAlign: TextAlign.center,
                       style: TextStyle(color: Colors.white70,fontWeight: FontWeight.bold,fontSize: 20),),
                   ),
                 ),
               ),
             ),
           ],
         ),
       ),
     );
   }
 }
