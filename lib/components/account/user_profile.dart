import 'package:bunnaapp/components/signin/sign_in.dart';
import 'package:flutter/material.dart';
import '../../models/models.dart';
import '../../data/regions.dart';

class UserProfilePage extends StatelessWidget {
  final user = User.dummyUser;

  UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('My Profile', style: Theme.of(context).textTheme.titleLarge),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Profile Information
            Text(
              'Profile Information',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16.0),
            _buildProfileInfo(context),
            const SizedBox(height: 32.0),
            // Account Settings
            Text(
              'Account Settings',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16.0),
            _buildAccountSettings(context),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Profile photo aligned to the center
        const Center(
          child: CircleAvatar(
            radius: 40.0,
            backgroundImage: AssetImage('assets/images/user.png'),
          ),
        ),

        ListTile(
          leading: Icon(Icons.person, color: Theme.of(context).primaryColor),
          title: Text("${user.firstName!} ${user.lastName!}",
              style: Theme.of(context).textTheme.bodyLarge),
          subtitle: Text('Name', style: Theme.of(context).textTheme.bodySmall),
        ),
        ListTile(
          leading: Icon(Icons.email, color: Theme.of(context).primaryColor),
          title:
              Text(user.email!, style: Theme.of(context).textTheme.bodyLarge),
          subtitle: Text('Email', style: Theme.of(context).textTheme.bodySmall),
        ),
        ListTile(
          leading: Icon(Icons.phone, color: Theme.of(context).primaryColor),
          title: Text(user.phoneNumber!,
              style: Theme.of(context).textTheme.bodyLarge),
          subtitle: Text('Phone', style: Theme.of(context).textTheme.bodySmall),
        ),
        ListTile(
          leading: Icon(Icons.work, color: Theme.of(context).primaryColor),
          title: Text(user.occupationType!,
              style: Theme.of(context).textTheme.bodyLarge),
          subtitle:
              Text('Occupation', style: Theme.of(context).textTheme.bodySmall),
        ),
        ListTile(
          leading:
              Icon(Icons.location_on, color: Theme.of(context).primaryColor),
          title: Text("${user.zone!} ${user.region!}",
              style: Theme.of(context).textTheme.bodyLarge),
          subtitle:
              Text('Address', style: Theme.of(context).textTheme.bodySmall),
        ),
        const SizedBox(height: 16.0),
        Center(
          child: ElevatedButton(
            onPressed: () {
              // Navigate to Edit Profile Page
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EditProfilePage(user: user)),
              );
            },
            style: ElevatedButton.styleFrom(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
            ),
            child: const Text('Edit Profile',
                style: TextStyle(color: Colors.green)),
          ),
        ),
      ],
    );
  }

  Widget _buildAccountSettings(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.lock, color: Theme.of(context).primaryColor),
          title: Text('Change Password',
              style: Theme.of(context).textTheme.bodyLarge),
          onTap: () {
            // Navigate to Change Password Page
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChangePasswordPage(user: user)),
            );
          },
        ),
        ListTile(
          leading:
              Icon(Icons.exit_to_app, color: Theme.of(context).primaryColor),
          title: Text('Log Out', style: Theme.of(context).textTheme.bodyLarge),
          onTap: () {
            // Handle user logout
            // Navigate to Login Page
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const SignIn()));
          },
        ),
      ],
    );
  }
}

class EditProfilePage extends StatefulWidget {
  final User user;

  EditProfilePage({required this.user});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  String? _firstName;
  String? _lastName;
  String? _email;
  String? _phoneNumber;
  String? _region;
  String? _zone;
  String? _occupationType;

  final Map<String, List<String>> regionZones = Region_Zones;

  final List<String> occupations = ['Researcher', 'Farmer'];

  List<String> _zones = [];

  @override
  void initState() {
    super.initState();
    _firstName = widget.user.firstName;
    _lastName = widget.user.lastName;
    _email = widget.user.email;
    _phoneNumber = widget.user.phoneNumber;
    _region = widget.user.region;
    _zone = widget.user.zone;
    _occupationType = widget.user.occupationType;
    if (_region != null && regionZones.containsKey(_region)) {
      _zones = regionZones[_region]!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Profile',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                initialValue: _firstName,
                decoration: InputDecoration(labelText: 'First Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your first name';
                  }
                  return null;
                },
                onSaved: (value) => _firstName = value,
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                initialValue: _lastName,
                decoration: InputDecoration(labelText: 'Last Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your last name';
                  }
                  return null;
                },
                onSaved: (value) => _lastName = value,
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                initialValue: _email,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
                onSaved: (value) => _email = value,
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                initialValue: _phoneNumber,
                decoration: InputDecoration(labelText: 'Phone Number'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
                onSaved: (value) => _phoneNumber = value,
              ),
              const SizedBox(height: 16.0),
              DropdownButtonFormField<String>(
                value: _region,
                decoration: InputDecoration(labelText: 'Region'),
                items: regionZones.keys.map((String region) {
                  return DropdownMenuItem<String>(
                    value: region,
                    child: Text(region),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _region = value;
                    _zones = regionZones[value] ?? [];
                    _zone = null; // Reset zone value
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select your region';
                  }
                  return null;
                },
                onSaved: (value) => _region = value,
              ),
              const SizedBox(height: 16.0),
              DropdownButtonFormField<String>(
                value: _zone,
                decoration: InputDecoration(labelText: 'Zone'),
                items: _zones.map((String zone) {
                  return DropdownMenuItem<String>(
                    value: zone,
                    child: Text(zone),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _zone = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select your zone';
                  }
                  return null;
                },
                onSaved: (value) => _zone = value,
              ),
              const SizedBox(height: 16.0),
              DropdownButtonFormField<String>(
                value: _occupationType,
                decoration: InputDecoration(labelText: 'Occupation Type'),
                items: occupations.map((String occupation) {
                  return DropdownMenuItem<String>(
                    value: occupation,
                    child: Text(occupation),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _occupationType = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select your occupation type';
                  }
                  return null;
                },
                onSaved: (value) => _occupationType = value,
              ),
              const SizedBox(height: 32.0),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // Save profile information
                      // Navigate back to Profile Page with updated user info
                      Navigator.pop(
                          context,
                          User(
                            firstName: _firstName,
                            lastName: _lastName,
                            email: _email,
                            phoneNumber: _phoneNumber,
                            region: _region,
                            zone: _zone,
                            occupationType: _occupationType,
                          ));
                    }
                  },
                  child: Text('Save'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 32.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChangePasswordPage extends StatelessWidget {
  final User user;

  ChangePasswordPage({required this.user});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    String _oldPassword = '';
    String _newPassword = '';
    String _confirmPassword = '';

    return Scaffold(
      appBar: AppBar(
        title: Text('Change Password',
            style: Theme.of(context).textTheme.titleLarge),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Old Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your old password';
                  }
                  return null;
                },
                onSaved: (value) => _oldPassword = value!,
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(labelText: 'New Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your new password';
                  }
                  return null;
                },
                onSaved: (value) => _newPassword = value!,
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(labelText: 'Confirm New Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your new password';
                  }
                  if (value != _newPassword) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
                onSaved: (value) => _confirmPassword = value!,
              ),
              const SizedBox(height: 32.0),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // Change password logic
                      // Navigate back to Profile Page
                      Navigator.pop(context);
                    }
                  },
                  child: Text('Change Password'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 32.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
