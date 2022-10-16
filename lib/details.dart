import 'package:contacts/contacts.dart';
import 'package:contacts/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  Contacts number;

  Details(this.number, {super.key});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameinput.text = widget.number.name;
    numberinput.text = widget.number.number;
    urlinput.text = widget.number.image;
  }

  TextEditingController numberinput = TextEditingController();
  TextEditingController nameinput = TextEditingController();
  TextEditingController urlinput = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Contact Details',
          style: TextStyle(
              color: Colors.blueAccent,
              fontSize: 25,
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                  widget.number.image,
                ),
                radius: 150,
              ),
              TextField(
                controller: nameinput,
                decoration: const InputDecoration(label: Text('Contact name')),
              ),
              TextField(
                controller: numberinput,
                decoration: const InputDecoration(label: Text('Contact number')),
              ),
              TextField(
                controller: urlinput,
                decoration:
                    const InputDecoration(label: Text('Contact URL')),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(500, 50),
                  backgroundColor: Colors.blueAccent,
                ),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text(
                            'Save Contact',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          content: const Text(
                              'Are you sure you want to save this contact?'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  "Cancel",
                                  style: TextStyle(color: Colors.black45),
                                )),
                            TextButton(
                              onPressed: () {
                                var updatecontact = Contacts(
                                  //  id: widget.number.id,
                                    name: widget.number.name,
                                    number: widget.number.number,
                                    image: widget.number.image);
                                ContactsProvider.instance
                                    .contactUpdate(updatecontact);
                                setState(() {});
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                              },
                              child: const Text("Yes",
                                  style: TextStyle(
                                    color: Colors.red,
                                  )),
                            )
                          ],
                        );
                      });
                },
                child: const Text(
                  'Save',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(500, 50),
                  backgroundColor: Colors.white,
                ),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text(
                            'Delete Contact',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          content: const Text(
                              'Are you sure you want to delete this contact?'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  "Cancel",
                                  style: TextStyle(color: Colors.black45),
                                )),
                            TextButton(
                              onPressed: () {
                                if (widget.number.id != null) {
                                  ContactsProvider.instance
                                      .deleteContact(widget.number.id!);
                                }
                                // print(books);
                                //  setState(() {});
                                // Navigator.pop(context);
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                              },
                              child: const Text("Yes",
                                  style: TextStyle(
                                    color: Colors.red,
                                  )),
                            )
                          ],
                        );
                      });
                },
                child: const Text(
                  'Delete',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
