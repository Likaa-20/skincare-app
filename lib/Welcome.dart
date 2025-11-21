import 'package:flutter/material.dart';
import 'User.dart';
import 'Page2.dart';
class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);
  @override
  State<Welcome> createState() => _WelcomeState();
}
class _WelcomeState extends State<Welcome> {
  bool showregister=false;
  bool showlogin=false;
  String _name='';
  String _password='';
  String _phone='';
  String gender='';
  String selectedGender='female';

  void updateName(String name) {
    setState(() {
      _name = name;
    });
  }
  void updatePass(String password) {
    setState(() {
      _password = password;
    });
  }

  void updatePhone(String phone) {
    setState(() {
      _phone= phone;
    });
  }
  void _onSavePressed() {
    String name = _name.trim();
    String password = _password.trim();
    String phone = _phone.trim();

    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Name cannot be empty", style: TextStyle(color: Colors.red),), ),
      );
      return;
    }

    if (password.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Password must be at least 6 characters", style: TextStyle(color: Colors.red),)),
      );
      return;
    }

    if (phone.isEmpty || phone.length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Enter a valid phone number", style: TextStyle(color: Colors.red),)),
      );
      return;
    }
    User newUser = User(
      name: name,
      password: password,
      phone: phone,
      gender: selectedGender,
    );
    UserRepository.users.add(newUser);


    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Page2(user : newUser)),
    );
  }
  void _onLoginPressed() {
    String name = _name.trim();
    String password = _password.trim();

    User? foundUser;
    try {
      foundUser = UserRepository.users.firstWhere(
            (user) => user.name == name && user.password == password,
      );
    } catch (e) {
      foundUser = null;
    }


    if (foundUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Invalid name or password"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Page2(user: foundUser!)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Skin_care Application",
              style:TextStyle(
                  color: Colors.white70,
                  fontSize: 30
              )
          ),
          backgroundColor: Colors.pink,
          centerTitle: true,
        ),
        body: SingleChildScrollView(  // ADD THIS
            child:Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                const SizedBox(height: 10.0),

                Image.asset('assets/skin.jpg',height:200,width:2000),
                const SizedBox(height: 40.0),

                Text(
                  'Welcome to our application, your destination to let your face glow up!',
                  style: TextStyle(fontSize: 24, color: Colors.deepPurple),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10.0),
                Text(
                  'If this is the first time you use our application please click on "Register" button,'
                      ' if not please click on "Login" button',
                  style: TextStyle(fontSize: 20, color: Colors.deepPurple),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20.0),


                showregister
                    ?Column(
                    children: [

                      const SizedBox(height: 20.0,),
                      Row(
                          children: [
                            const SizedBox(height: 20.0),
                            Text('Enter your name:', style: const TextStyle(fontSize: 18.0),textAlign: TextAlign.center,),
                            const SizedBox(width: 9.0,),
                            SizedBox(width: 300.0, height: 50.0,
                              child: TextField(
                                style: const TextStyle(fontSize: 18.0),
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(), hintText: 'name',
                                  hintStyle: TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey,
                                  ),
                                ),

                                onChanged: (name) { updateName(name);},
                              ),
                            ),
                          ]
                      ),
                      const SizedBox(height: 15.0,),
                      Row(
                          children: [
                            const SizedBox(height: 20.0),
                            Text('Enter password:', style: const TextStyle(fontSize: 18.0),textAlign: TextAlign.center,),
                            const SizedBox(width: 9.0,),
                            SizedBox(width: 300.0, height: 50.0,
                              child: TextField(
                                style: const TextStyle(fontSize: 18.0),
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(), hintText: 'password',
                                  hintStyle: TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey,
                                  ),
                                ),
                                onChanged: (password) { updatePass(password);},
                              ),
                            ),
                          ]
                      ),
                      const SizedBox(height: 15.0,),
                      Row(
                          children: [
                            const SizedBox(height: 20.0),
                            Text('Enter your number:', style: const TextStyle(fontSize: 18.0),textAlign: TextAlign.center,),
                            const SizedBox(width: 9.0,),
                            SizedBox(width: 300.0, height: 50.0,
                              child: TextField(
                                style: const TextStyle(fontSize: 18.0),
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(), hintText: 'Phone number',
                                  hintStyle: TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey,
                                  ),
                                ),
                                onChanged: (phone) { updatePhone(phone);},
                              ),
                            ),
                          ]
                      ),
                      const SizedBox(height: 15.0,),
                      Row(
                          children: [
                            const Text('Gender', style: TextStyle(fontSize: 18.0),),
                            Radio<String>(
                              value:"female" ,
                              groupValue: selectedGender,//ignore: deprecated_member_use
                              onChanged: (value) {//ignore: deprecated_member_use
                                setState(() {
                                  selectedGender = value!;
                                });
                              },
                            ),
                            const Text('Female', style: TextStyle(fontSize: 18.0),),
                            Radio<String>(
                              value: "male",
                              groupValue: selectedGender,//ignore: deprecated_member_use
                              onChanged: (value) { //ignore: deprecated_member_use
                                setState(() {
                                  selectedGender = value!;
                                });
                              },
                            ),
                            const Text('Male', style: TextStyle(fontSize: 18.0),),
                          ]
                      ),


                      const SizedBox(height: 10),
                      ElevatedButton(onPressed:() {
                        _onSavePressed();
                      }, child:
                      Text("save", style: TextStyle(fontSize: 15.0))
                      )
                    ]


                )
                    :
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      showregister = true;
                      showlogin=false;
                    });
                  },
                  child: Text('Register'),
                ),
                const SizedBox(height: 20.0),

                showlogin
                    ?Column(
                  children: [
                    Row(
                        children: [
                          const SizedBox(height: 20.0),
                          Text('Enter your name', style: const TextStyle(fontSize: 18.0),textAlign: TextAlign.center,),
                          const SizedBox(width: 9.0,),
                          SizedBox(width: 300.0, height: 50.0,
                            child: TextField(
                              style: const TextStyle(fontSize: 18.0),
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(), hintText: 'name ',
                                hintStyle: TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey,
                                ),
                              ),
                              onChanged: (name) { updateName(name);},
                            ),
                          ),
                        ]
                    ),
                    const SizedBox(height: 20.0),
                    Row(
                        children: [
                          const SizedBox(height: 20.0),
                          Text('Enter password', style: const TextStyle(fontSize: 18.0),textAlign: TextAlign.center,),
                          const SizedBox(width: 9.0,),
                          SizedBox(width: 300.0, height: 50.0,
                            child: TextField(
                              style: const TextStyle(fontSize: 18.0),
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(), hintText: 'password ',
                                hintStyle: TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey,
                                ),
                              ),
                              onChanged: (password) { updatePass(password);},
                            ),
                          ),
                        ]
                    ),
                    ElevatedButton(onPressed: (){
                      _onLoginPressed();
                    }, child: Text('OK'))

                  ],
                )
                    :
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      showlogin = true;
                      showregister=false;
                    });
                  },
                  child: Text('Login', style: TextStyle(fontSize: 15.0)),
                ),
              ],
            )
        )
    )
    );
  }

}

