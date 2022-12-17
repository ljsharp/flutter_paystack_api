import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_paystack_api/views/components/custom_textbox.dart';

class CreateCustomer extends ConsumerStatefulWidget {
  const CreateCustomer({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CreateCustomerState();
}

class _CreateCustomerState extends ConsumerState<CreateCustomer> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Account",
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              const SizedBox(height: 10),
              CustomTextbox(
                controller: _firstNameController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please provide a first name";
                  }
                  return null;
                },
                labelText: "First name",
                keyboardType: TextInputType.name,
              ),
              const SizedBox(height: 10),
              CustomTextbox(
                controller: _lastNameController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please provide a last name";
                  }
                  return null;
                },
                labelText: "Last Name",
                keyboardType: TextInputType.name,
              ),
              const SizedBox(height: 10),
              CustomTextbox(
                controller: _emailController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please provide your email address";
                  }
                  if (!value.contains("@")) {
                    return "Please provide your valid email address";
                  }
                  return null;
                },
                labelText: "Email Address",
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 10),
              CustomTextbox(
                controller: _phoneController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please provide your phone number";
                  }
                  return null;
                },
                labelText: "Phone #",
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {},
                child: const Text("Sign up"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
