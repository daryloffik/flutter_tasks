import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}
int _selectedIndex = 0;
final _nameController = TextEditingController();
String? _sexe;
bool? _football = false;
bool? _music = false;
bool? _mangas = false;
final formKey = new GlobalKey<FormState>();

String _name = "John Doe";
bool _loading = true;
bool _displayinfo = false;
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  _displayDialog(BuildContext context) async {
    return showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text('Alert Dialog'),
        content: Text("Etes-vous sûr de vouloir soumettre le formulaire"),
        actions: <Widget>[
          TextButton(onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(onPressed: ()  {
            Navigator.pop(context, 'Ok');
            setState((){
              _loading = true;
            });
            Future.delayed(const Duration(seconds: 5),() {
              setState(() {
                _loading = false;
                _name = _nameController.text;
                _displayinfo = true;
              });
            });
          },child: const Text('Ok'))
          ,

        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
        title:Text("Titre de la page",style:TextStyle(color: Colors.white),),
      backgroundColor: Colors.blue,
      actions: const [
        IconButton(onPressed: null, icon: Icon(Icons.add_alert, color:Colors.white)),
        IconButton(onPressed: null, icon: Icon(Icons.search,color:Colors.white)),
      ],
    ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(decoration: BoxDecoration(color:Colors.blue,
            ),
            child: Text(_name,style:TextStyle(color: Colors.white,fontSize: 20,
            ),
            ),
            ),
            ListTile(leading: Icon(Icons.message),
            title: Text('Messages'),
            ),
            ListTile(leading: Icon(Icons.person),
              title: Text('Profile'),
            ),

                ListTile(leading: Icon(Icons.settings),
                  title: Text('Settings'),
                ),
          ],

        )

      ),
      bottomNavigationBar: BottomNavigationBar(
      currentIndex: _selectedIndex,onTap:(int index){
        setState((){
          _selectedIndex = index;
    });
    },
    items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(icon: Icon(Icons.person),
    label: 'Inscription',
    ),
    BottomNavigationBarItem(icon: Icon(Icons.info),
    label: 'Information',
    ),
    BottomNavigationBarItem(icon: Icon(Icons.settings),
    label: 'Paramètres',
    ),
    ]
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Float action button pressed'))
          );
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
      body: Container(padding:EdgeInsets.all(10.0),
          child: SingleChildScrollView(child: Column(
            children: [
              Text("Information de l'utilisateur", style:TextStyle(fontSize:18, fontWeight: FontWeight.bold, color:Colors.blue),),
              SizedBox(height: 15.0,),
              Center(child:Image.asset("assets/images/Zom.png", scale: 2,),),
              SizedBox(height: 20.0,),
              Form(
                key:formKey,
                child: Column(
                  children: [TextFormField(
                    keyboardType: TextInputType.name,
                    controller: _nameController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.person),
                      hintText: 'Quel est votre nom',labelText: 'Nom & Prénom *'
                    ),
                      validator: (String? value){
                      return (value == null || value == "") ?
                       "Ce champ est obligatoire": null;
               },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    controller: null,
                    decoration: InputDecoration(
                        icon: Icon(Icons.lock),
                        hintText: 'Définir votre mot de passe',labelText: 'Mot de passe *'
                    ),
                    validator: (String? value){
                      return (value == null || value == "") ?
                      "Ce champ est obligatoire": null;
                    },
                  ),
                    DropdownButtonFormField(style :TextStyle(color: Colors.white
                    ),decoration: new InputDecoration(icon: Icon(Icons.transgender),
                    hintText: 'Quel est votre sexe',
                    labelText: "Sexe *",),
                        value: _sexe,
                        onChanged: (String? v)async{
                      setState(() {
                        _sexe = v;
                      });
                        },
                    items: <String>['Masculin','Féminin','Autre'].map<DropdownMenuItem<String>>((String value) {
    return DropdownMenuItem<String>(
    value: value,
    child: Text(value, style:TextStyle(color: Colors.black),),
    );
    }).toList(),
    validator: (str) => str == null ? "Ce champ est obligatoire" : null,
                      ),
                  ]
                )
              ),
              SizedBox(height: 10.0,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Quels sont vos passe temps?", style: TextStyle(fontSize: 16.0),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children:  <Widget>[
                        Checkbox(
                          value: _football,
                          checkColor: Colors.white,
                          onChanged: (bool? b){
                            setState(() {
                              _football = b;
                            });
                          },
                        ),
                        Text("Football", style: TextStyle(
                            color: Colors.black),)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children:  <Widget>[
                        Checkbox(
                          value: _music,
                          checkColor: Colors.white,
                          onChanged: (bool? b){
                            setState(() {
                              _music = b;
                            });
                          },
                        ),
                        Text("Musique", style: TextStyle(
                            color: Colors.black),)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children:  <Widget>[
                        Checkbox(
                          value: _mangas,
                          checkColor: Colors.white,
                          onChanged: (bool? b){
                            setState(() {
                              _mangas = b;
                            });
                          },
                        ),
                        Text("Mangas", style: TextStyle(
                            color: Colors.black),)
                      ],
                    ),
                  ],
                ),
              ),

              Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed:()
                {
                  if(formKey.currentState!.validate()){
                    _displayDialog(context);
                  }
                }, child: Text("Valider"),),
                SizedBox(width: 5.0,),
                _loading ? CircularProgressIndicator(
                  color:Colors.red,):SizedBox(
                ),
              ]),
              SizedBox(height: 10.0,),
              _displayinfo ? Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.person),
                      title:RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(text: "Je m'appelle",style: TextStyle(color: Colors.black)),
                            TextSpan(text: _name,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black)),
                          ],
                        ),
                      ),
                      subtitle: Text("Voici mes passions"),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        TextButton(
                          child: const Text('AJOUTER'),
                          onPressed: (){/* . . .*/},
                        ),
                        const SizedBox(width: 8),
                        TextButton(
                          child: const Text('RETIRER'),
                          onPressed: (){/* . . .*/},
                        ),
                        const SizedBox(width: 8),

      ]),
                  ]

                ),
              ): SizedBox(),
            ]

          )))
    ,
    );
  }
}

