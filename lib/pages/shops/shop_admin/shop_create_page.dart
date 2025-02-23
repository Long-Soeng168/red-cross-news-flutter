import 'dart:io';
import 'package:red_cross_news_app/components/buttons/my_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:red_cross_news_app/services/shop_service.dart';

class ShopCreatePage extends StatefulWidget {
  const ShopCreatePage({super.key});

  @override
  _ShopCreatePageState createState() => _ShopCreatePageState();
}

class _ShopCreatePageState extends State<ShopCreatePage> {
  final _shopService = ShopService();
  final _shopFormKey = GlobalKey<FormState>();

  // Controllers for shop fields
  final _shopNameController = TextEditingController();
  final _shopDescriptionController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();

  // Variables for logo and banner images
  XFile? _logoImage;
  XFile? _bannerImage;
  final ImagePicker _picker = ImagePicker();

  bool _isLoading = false;

  // Function to pick image for logo or banner
  Future<void> _pickImage(bool isLogo) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        if (isLogo) {
          _logoImage = pickedFile;
        } else {
          _bannerImage = pickedFile;
        }
      });
    }
  }

  // Function to handle shop creation
  Future<void> _createShop() async {
    if (_shopFormKey.currentState!.validate() &&
        _logoImage != null &&
        _bannerImage != null) {
      setState(() {
        _isLoading = true; // Show loading indicator
      });

      // Call the shop creation service
      final response = await _shopService.createShop(
        context: context,
        name: _shopNameController.text,
        description: _shopDescriptionController.text,
        address: _addressController.text,
        phone: _phoneController.text,
        logoImage: _logoImage!,
        bannerImage: _bannerImage!,
      );

      setState(() {
        _isLoading = false; // Hide loading indicator
      });

      if (response['success']) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Shop created successfully")));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(response['message'])));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Please complete all fields and upload images")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Shop"),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _shopFormKey,
          child: ListView(
            children: [
              const SizedBox(
                height: 20,
              ),
              // Shop name input
              TextFormField(
                controller: _shopNameController,
                decoration: InputDecoration(
                  labelText: "Name",
                  border: const OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade400, // Border color when enabled
                    ),
                  ),
                  hintText: 'Shop Name',
                ),
                validator: (value) => value!.isEmpty ? "Enter Shop name" : null,
              ),
              const SizedBox(height: 12),

              // Phone number input
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: "Phone",
                  border: const OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade400, // Border color when enabled
                    ),
                  ),
                  hintText: 'Shop Phone',
                ),
                validator: (value) =>
                    value!.isEmpty ? "Enter Shop Phone" : null,
              ),
              const SizedBox(height: 12),

              // Address input
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(
                  labelText: "Address",
                  hintText: 'Shop Address',
                  alignLabelWithHint: true,
                  border: const OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade400, // Border color when enabled
                    ),
                  ),
                ),
                maxLines:
                    4, // Set maxLines to allow multiple lines, adjust as needed
                validator: (value) =>
                    value!.isEmpty ? "Enter Shop Address" : null,
              ),
              const SizedBox(height: 12),

              // Shop description input
              TextFormField(
                controller: _shopDescriptionController,
                decoration: InputDecoration(
                  labelText: "Description",
                  hintText: 'Shop Description',
                  alignLabelWithHint: true,
                  border: const OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade400, // Border color when enabled
                    ),
                  ),
                ),
                maxLines:
                    4, // Set maxLines to allow multiple lines, adjust as needed
                validator: (value) =>
                    value!.isEmpty ? "Enter Shop description" : null,
              ),
              const SizedBox(height: 12),

              const SizedBox(height: 16),

              // Logo image picker with preview
              GestureDetector(
                onTap: () => _pickImage(true),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("Logo Image",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    _logoImage == null
                        ? Icon(Icons.image,
                            size: 100, color: Colors.grey.shade400)
                        : Image.file(File(_logoImage!.path), height: 100),
                    TextButton(
                      onPressed: () => _pickImage(true),
                      child: Text(
                          _logoImage == null ? "Upload Logo" : "Change Logo"),
                    ),
                  ],
                ),
              ),

              // Banner image picker with preview
              GestureDetector(
                onTap: () => _pickImage(false),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("Banner Image",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    _bannerImage == null
                        ? Icon(Icons.image,
                            size: 100, color: Colors.grey.shade400)
                        : Image.file(File(_bannerImage!.path), height: 100),
                    TextButton(
                      onPressed: () => _pickImage(false),
                      child: Text(_bannerImage == null
                          ? "Upload Banner"
                          : "Change Banner"),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Submit button with loading indicator
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : MyElevatedButton(
                      onPressed: _createShop, title: "Create Shop"),
            ],
          ),
        ),
      ),
    );
  }
}
