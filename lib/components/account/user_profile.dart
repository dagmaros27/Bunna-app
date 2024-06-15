import 'package:flutter/material.dart';

class UserProfilePage extends StatelessWidget {
  final User user;

  const UserProfilePage({required this.user});

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
            // Order History
            Text(
              'Order History',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16.0),
            _buildOrderHistory(context),
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

        Center(
          child: CircleAvatar(
            radius: 40.0,
            backgroundImage: AssetImage('assets/images/user.jpg'),
          ),
        ),

        ListTile(
          leading:
              Icon(Icons.person, color: Theme.of(context).colorScheme.primary),
          title: Text(user.name, style: Theme.of(context).textTheme.bodyLarge),
          subtitle: Text('Name', style: Theme.of(context).textTheme.bodySmall),
        ),
        ListTile(
          leading:
              Icon(Icons.email, color: Theme.of(context).colorScheme.primary),
          title: Text(user.email, style: Theme.of(context).textTheme.bodyLarge),
          subtitle: Text('Email', style: Theme.of(context).textTheme.bodySmall),
        ),
        ListTile(
          leading:
              Icon(Icons.phone, color: Theme.of(context).colorScheme.primary),
          title: Text(user.phone, style: Theme.of(context).textTheme.bodyLarge),
          subtitle: Text('Phone', style: Theme.of(context).textTheme.bodySmall),
        ),
        ListTile(
          leading: Icon(Icons.location_on,
              color: Theme.of(context).colorScheme.primary),
          title:
              Text(user.address, style: Theme.of(context).textTheme.bodyLarge),
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
            child: Text('Edit Profile'),
            style: ElevatedButton.styleFrom(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOrderHistory(BuildContext context) {
    // Placeholder for order history
    // You would typically fetch this data from your backend
    final List<Order> orders = [
      Order(id: '123', date: '2023-06-01', total: 150.00, status: 'Delivered'),
      Order(id: '124', date: '2023-05-15', total: 85.00, status: 'Shipped'),
      Order(id: '125', date: '2023-04-22', total: 45.00, status: 'Processing'),
    ];

    return Column(
      children: orders.map((order) {
        return Card(
          child: ListTile(
            title: Text('Order #${order.id}',
                style: Theme.of(context).textTheme.bodyLarge),
            subtitle: Text(
              '${order.date} - \$${order.total}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            trailing: Text(order.status,
                style: Theme.of(context).textTheme.bodyMedium),
            onTap: () {
              // Navigate to Order Details Page
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => OrderDetailsPage(order: order)),
              );
            },
          ),
        );
      }).toList(),
    );
  }

  Widget _buildAccountSettings(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          leading:
              Icon(Icons.lock, color: Theme.of(context).colorScheme.primary),
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
          leading: Icon(Icons.exit_to_app,
              color: Theme.of(context).colorScheme.primary),
          title: Text('Log Out', style: Theme.of(context).textTheme.bodyLarge),
          onTap: () {
            // Handle user logout
            // Navigate to Login Page
            Navigator.pushReplacementNamed(context, '/login');
          },
        ),
      ],
    );
  }
}

class EditProfilePage extends StatelessWidget {
  final User user;

  EditProfilePage({required this.user});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    String _name = user.name;
    String _email = user.email;
    String _phone = user.phone;
    String _address = user.address;

    return Scaffold(
      appBar: AppBar(
        title:
            Text('Edit Profile', style: Theme.of(context).textTheme.titleLarge),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                initialValue: _name,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                onSaved: (value) => _name = value!,
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
                onSaved: (value) => _email = value!,
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                initialValue: _phone,
                decoration: InputDecoration(labelText: 'Phone'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
                onSaved: (value) => _phone = value!,
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                initialValue: _address,
                decoration: InputDecoration(labelText: 'Address'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your address';
                  }
                  return null;
                },
                onSaved: (value) => _address = value!,
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
                            name: _name,
                            email: _email,
                            phone: _phone,
                            address: _address,
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

// Models for User and Order
class User {
  String name;
  String email;
  String phone;
  String address;

  User({
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
  });
}

class Order {
  String id;
  String date;
  double total;
  String status;

  Order({
    required this.id,
    required this.date,
    required this.total,
    required this.status,
  });
}

// OrderDetailsPage is a placeholder for the order details page.
class OrderDetailsPage extends StatelessWidget {
  final Order order;

  OrderDetailsPage({required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details',
            style: Theme.of(context).textTheme.titleLarge),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Order ID: ${order.id}',
                style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 8.0),
            Text('Order Date: ${order.date}',
                style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 8.0),
            Text('Total Amount: \$${order.total}',
                style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 8.0),
            Text('Order Status: ${order.status}',
                style: Theme.of(context).textTheme.bodyLarge),
            // Add more details as needed
          ],
        ),
      ),
    );
  }
}
