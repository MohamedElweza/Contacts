import 'package:contacts/details.dart';
import 'package:contacts/provider.dart';
import 'package:flutter/material.dart';

import 'contacts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ContactsProvider.instance.open();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List <Contacts> contacts = [];
  @override
  Widget build(BuildContext context) {
    return SafeArea(child:
    Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('My Contacts', style: TextStyle(color: Colors.blueAccent, fontSize: 25, fontWeight: FontWeight.bold),),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          TextEditingController numberinput = TextEditingController();
          TextEditingController nameinput = TextEditingController();
          TextEditingController urlinput = TextEditingController();
          await showModalBottomSheet(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(15.0),
                ),
              ),
              context: context,
              builder: (context) {
                return SizedBox(
                  height: 270,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            TextField(
                              controller: nameinput,
                              decoration: const InputDecoration(
                                  label: Text('Contact Name')),
                            ),
                            TextField(
                              controller: numberinput,
                              decoration: const InputDecoration(
                                  label: Text('Contact Number')),
                            ),
                            TextField(
                              controller: urlinput,
                              decoration: const InputDecoration(
                                  label: Text('Contact Image URL')),
                            ),
                          ],
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(500, 50),
                            backgroundColor: Colors.blueAccent,
                          ),
                          onPressed: () {
                            ContactsProvider.instance.insertContact(Contacts(
                              name: nameinput.text,
                              number: numberinput.text,
                              image: urlinput.text,
                            ));
                            print(contacts);
                            setState(() {});
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'ADD',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              });
        },
        backgroundColor: Colors.blueAccent,
        child: const Icon(
          Icons.add,
          size: 50,
        ),
      ),
      body: FutureBuilder<List<Contacts>>(
        future: ContactsProvider.instance.getAllContacts(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          if (snapshot.hasData) {
            contacts = snapshot.data!;
          }
          return GridView.builder(
              itemCount: contacts.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
              ),
              itemBuilder: (BuildContext context, int index) {
                Contacts contact = contacts[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return Details(contact);
                        },
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(contact.image),
                        radius: 70,
                      ),
                       Text(contact.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                       Text(contact.number, style: TextStyle(fontSize: 15),),
                    ],
                  ),
                );
              },);
        },
      ),
    )
    );
  }
}


