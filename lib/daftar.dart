import 'package:flutter/material.dart';
import 'package:login/Animation/FadeAnimation.dart';
import 'services/api.dart';

class Daftar extends StatefulWidget {
  @override
  _DaftarState createState() => _DaftarState();
}

class _DaftarState extends State<Daftar> {
  ApiService apiService = ApiService();

  TextEditingController nama = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();

  bool proses = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Colors.blueGrey[900],
              Colors.blueGrey[500],
              Colors.blueGrey[300],
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeAnimation(
                    1,
                    Text(
                      "Hello!",
                      style: TextStyle(color: Colors.white, fontSize: 50),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FadeAnimation(
                      1.3,
                      Text(
                        "Silahkan Daftarkan Diri Anda untuk menjadi bagian dari aplikasi ini.",
                        style: TextStyle(color: Colors.white, fontSize: 15.0),
                      )),
                ],
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 40,
                        ),
                        FadeAnimation(
                          1.4,
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color.fromRGBO(67, 78, 137, .5),
                                      blurRadius: 20,
                                      offset: Offset(0, 10))
                                ]),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom:
                                          BorderSide(color: Colors.grey[200]),
                                    ),
                                  ),
                                  child: TextField(
                                    controller: nama,
                                    decoration: InputDecoration(
                                        hintText: "Nama",
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        border: InputBorder.none),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom:
                                          BorderSide(color: Colors.grey[200]),
                                    ),
                                  ),
                                  child: TextField(
                                    controller: email,
                                    decoration: InputDecoration(
                                        hintText: "Email",
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        border: InputBorder.none),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom:
                                          BorderSide(color: Colors.grey[200]),
                                    ),
                                  ),
                                  child: TextField(
                                    controller: pass,
                                    decoration: InputDecoration(
                                        hintText: "Password",
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        border: InputBorder.none),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        RaisedButton(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 50.0,
                                right: 50.0,
                                top: 10.0,
                                bottom: 10.0),
                            child: proses
                                ? CircularProgressIndicator(
                                    backgroundColor: Colors.white,
                                  )
                                : Text(
                                    "Daftar",
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                          ),
                          color: Colors.blueGrey,
                          splashColor: Colors.lightBlue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          onPressed: () {
                            setState(() {
                              proses = true;
                            });
                            apiService
                                .register(email.text, pass.text, nama.text)
                                .then((value) {
                              setState(() {
                                proses = false;
                              });
                              if (value["error"]) {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text("Opps"),
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children: <Widget>[
                                          Text(value["message"] +
                                              ", periksa data!"),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                Navigator.pushReplacementNamed(
                                    context, '/login');
                              }
                            });
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        FadeAnimation(
                          1.7,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Sudah Punya Akun ?",
                                style: TextStyle(color: Colors.grey),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              RaisedButton(
                                child: Text(
                                  "Masuk..",
                                  style: TextStyle(color: Colors.blue),
                                ),
                                color: Colors.white,
                                splashColor: Colors.lightBlue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                      context, '/login');
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
