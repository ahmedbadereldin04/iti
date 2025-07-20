import 'package:flutter/material.dart';
void main() {
  runApp(MyApp());
}

String firstName = '';
String lastName = '';
String email = '';
String job = '';
String address = '';
String gender = 'Male';
String fullName = '';
List<String> tasks = [];
List<String> completedTasks = [];

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller =
    AnimationController(duration: Duration(seconds: 2), vsync: this)
      ..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.7, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void navigateToAccountPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => AccountPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          FadeTransition(
            opacity: _animation,
            child: Text(
              'Welcome to My App',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 30),
          ElevatedButton(
              onPressed: navigateToAccountPage,
              child: Text('Create an Account')),
        ]),
      ),
    );
  }
}

class AccountPage extends StatefulWidget {
  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final _formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final jobController = TextEditingController();
  final addressController = TextEditingController();
  String selectedGender = 'Male';

  void saveAccount() {
    firstName = firstNameController.text;
    lastName = lastNameController.text;
    email = emailController.text;
    job = jobController.text;
    address = addressController.text;
    gender = selectedGender;
    fullName = "$firstName $lastName";

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Account')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(children: [
            TextFormField(controller: firstNameController, decoration: InputDecoration(labelText: 'First Name')),
            TextFormField(controller: lastNameController, decoration: InputDecoration(labelText: 'Last Name')),
            TextFormField(controller: emailController, decoration: InputDecoration(labelText: 'Email')),
            TextFormField(controller: jobController, decoration: InputDecoration(labelText: 'Job Title')),
            TextFormField(controller: addressController, decoration: InputDecoration(labelText: 'Address')),
            DropdownButtonFormField(
              value: selectedGender,
              items: ['Male', 'Female']
                  .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                  .toList(),
              onChanged: (val) {
                setState(() {
                  selectedGender = val.toString();
                });
              },
              decoration: InputDecoration(labelText: 'Gender'),
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: saveAccount, child: Text('Save Account')),
          ]),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  int currentIndex = 0;
  final taskController = TextEditingController();

  void logout() {
    firstName = '';
    lastName = '';
    email = '';
    job = '';
    address = '';
    gender = '';
    fullName = '';
    tasks.clear();
    completedTasks.clear();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SplashScreen()),
    );
  }

  Widget buildHomeTab() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            'Welcome, $firstName $lastName!',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Card(
            child: Image.network(
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQRucYthBYLKn6nv-iTAhMsJJKEt8s1XoJULw&s',
              fit: BoxFit.cover,
            ),
          )
        ],
      ),
    );
  }

  Widget buildTasksTab() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: taskController,
            decoration: InputDecoration(labelText: 'New Task'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                tasks.add(taskController.text);
                taskController.clear();
              });
            },
            child: Text('Add Task'),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                final isCompleted = completedTasks.contains(task);
                return ListTile(
                  title: Text(
                    task,
                    style: TextStyle(
                      decoration: isCompleted ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  subtitle: Text('Created By: $fullName'),
                  trailing: Wrap(
                    children: [
                      IconButton(
                        icon: Icon(Icons.check, color: Colors.green),
                        onPressed: () {
                          setState(() {
                            completedTasks.add(task);
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          setState(() {
                            tasks.removeAt(index);
                            completedTasks.remove(task);
                          });
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget buildProfileTab() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: AnimatedOpacity(
        opacity: 1.0,
        duration: Duration(seconds: 1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('First Name: $firstName'),
            Text('Last Name: $lastName'),
            Text('Email: $email'),
            Text('Job: $job'),
            Text('Address: $address'),
            Text('Gender: $gender'),
            SizedBox(height: 20),
            Text('Completed Tasks:', style: TextStyle(fontWeight: FontWeight.bold)),
            ...completedTasks.map((task) => Text('- $task')).toList(),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tabs = [buildHomeTab(), buildTasksTab(), buildProfileTab()];
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(child: Text('Menu')),
            ListTile(
              leading: Icon(Icons.task),
              title: Text('Tasks'),
              onTap: () => setState(() => currentIndex = 1),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () => setState(() => currentIndex = 2),
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: logout,
            ),
          ],
        ),
      ),
      body: tabs[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (val) => setState(() => currentIndex = val),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.task), label: 'Tasks'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}