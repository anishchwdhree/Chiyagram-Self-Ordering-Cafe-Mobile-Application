import 'package:flutter/material.dart';
import 'package:chiyagaram/screens/widget/background_scaffold.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:chiyagaram/responsive/size_config.dart';
import 'package:chiyagaram/theme/app_colors.dart';
import 'dart:io';
import 'package:chiyagaram/theme/theme_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  bool _isLoading = false;
  File? _imageFile;
  String? _currentPhotoBase64; // Add this
  final _auth = FirebaseAuth.instance;
  final _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    final user = _auth.currentUser;
    _nameController = TextEditingController(text: user?.displayName ?? "");
    _emailController = TextEditingController(text: user?.email ?? "");
    _loadProfileImage(); // Load image
  }

  Future<void> _loadProfileImage() async {
    final user = _auth.currentUser;
    if (user != null) {
      try {
        final doc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        if (doc.exists &&
            doc.data() != null &&
            doc.data()!['photoBase64'] != null) {
          if (mounted) {
            setState(() {
              _currentPhotoBase64 = doc.data()!['photoBase64'];
            });
          }
        }
      } catch (e) {
        // Handle error silently or log
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error picking image: $e')));
      }
    }
  }

  Future<void> _removePhoto() async {
    final user = _auth.currentUser;
    if (user == null) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // Update Firestore to remove photo
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({
            'photoBase64': FieldValue.delete(),
            'lastUpdated': FieldValue.serverTimestamp(),
          });

      if (mounted) {
        setState(() {
          _currentPhotoBase64 = null;
          _imageFile = null;
        });
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Photo removed!')));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error removing photo: $e')));
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _showImageOptions() {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    final isDark = themeProvider.isDarkMode;
    final textColor = isDark ? Colors.white : const Color(0xFF3E2723);

    showModalBottomSheet(
      context: context,
      backgroundColor: isDark ? AppColors.igSurface : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.w)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40.w,
                height: 4.h,
                margin: EdgeInsets.symmetric(vertical: 12.h),
                decoration: BoxDecoration(
                  color: textColor.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              ListTile(
                leading: Icon(Iconsax.gallery, color: textColor),
                title: Text(
                  "Choose from Gallery",
                  style: GoogleFonts.outfit(color: textColor),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage();
                },
              ),
              if (_currentPhotoBase64 != null || _imageFile != null)
                ListTile(
                  leading: const Icon(Iconsax.trash, color: Colors.redAccent),
                  title: Text(
                    "Remove Current Photo",
                    style: GoogleFonts.outfit(color: Colors.redAccent),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    _removePhoto();
                  },
                ),
              SizedBox(height: 10.h),
            ],
          ),
        );
      },
    );
  }

  Future<void> _saveProfile() async {
    final user = _auth.currentUser;
    if (user == null) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // Update Display Name
      if (_nameController.text.trim() != user.displayName) {
        await user.updateDisplayName(_nameController.text.trim());
      }

      // Update Profile Picture in Firestore (Base64)
      if (_imageFile != null) {
        final bytes = await _imageFile!.readAsBytes();
        final String base64Image = base64Encode(bytes);

        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'photoBase64': base64Image,
          'email': user.email,
          'displayName': _nameController.text.trim(),
          'lastUpdated': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));

        // Update local state to show the new image immediately if they stay on screen
        if (mounted) {
          setState(() {
            _currentPhotoBase64 = base64Image;
            _imageFile = null; // Clear file so we use base64
          });
        }

        // We can't update using updatePhotoURL since it only takes a URL,
        // so we rely on Firestore for the image source.
      }

      // Note: Updating email usually requires re-authentication, so we skip it for now
      // unless you strictly want to allow email changes which is complex flow.
      // user.updateEmail(_emailController.text);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully!')),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error updating profile: $e')));
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;
    final textColor = isDark ? Colors.white : const Color(0xFF3E2723);
    final user = _auth.currentUser;

    return BackgroundScaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w).copyWith(
          top: MediaQuery.of(context).padding.top + 10.h,
          bottom: 30.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Custom App Bar
            Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.arrow_back_ios_new, color: textColor),
                ),
                Expanded(
                  child: Text(
                    "Edit Profile",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.philosopher(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                ),
                SizedBox(width: 40.w), // Balance back button
              ],
            ),
            SizedBox(height: 30.h),

            // Profile Image
            GestureDetector(
              onTap: _showImageOptions,
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    padding: EdgeInsets.all(4.w),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: textColor.withValues(alpha: 0.1),
                        width: 2.w,
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 60.w,
                      backgroundColor: isDark
                          ? AppColors.igSurface
                          : const Color(0xFFD7CCC8),
                      backgroundImage: _imageFile != null
                          ? FileImage(_imageFile!)
                          : (_currentPhotoBase64 != null
                                ? MemoryImage(
                                    base64Decode(_currentPhotoBase64!),
                                  )
                                : (user?.photoURL != null
                                      ? NetworkImage(user!.photoURL!)
                                      : null)),
                      child:
                          (_imageFile == null &&
                              _currentPhotoBase64 == null &&
                              user?.photoURL == null)
                          ? Text(
                              _getInitials(_nameController.text),
                              style: GoogleFonts.philosopher(
                                fontSize: 36.sp,
                                fontWeight: FontWeight.bold,
                                color: isDark
                                    ? Colors.white
                                    : const Color(0xFF3E2723),
                              ),
                            )
                          : null,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: isDark ? Colors.white : const Color(0xFF3E2723),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isDark ? Colors.black : Colors.white,
                        width: 2.w,
                      ),
                    ),
                    child: Icon(
                      Iconsax.camera,
                      color: isDark ? Colors.black : Colors.white,
                      size: 20.sp,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40.h),

            // Form Fields
            _buildTextField(
              "Full Name",
              "Enter full name",
              Iconsax.user,
              _nameController,
              isDark,
              textColor,
            ),
            SizedBox(height: 20.h),
            _buildTextField(
              "Email",
              "Enter email",
              Iconsax.sms,
              _emailController,
              isDark,
              textColor,
              enabled: false, // Email edits disabled for now
            ),

            SizedBox(height: 50.h),

            // Save Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _saveProfile,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isDark
                      ? Colors.white
                      : const Color(0xFF3E2723),
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.w),
                  ),
                  elevation: 5,
                  shadowColor: (isDark ? Colors.black : const Color(0xFF3E2723))
                      .withValues(alpha: 0.3),
                ),
                child: _isLoading
                    ? SizedBox(
                        height: 20.h,
                        width: 20.h,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: isDark ? Colors.black : Colors.white,
                        ),
                      )
                    : Text(
                        "Save Changes",
                        style: GoogleFonts.outfit(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: isDark ? Colors.black : Colors.white,
                        ),
                      ),
              ),
            ),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    String placeholder,
    IconData icon,
    TextEditingController controller,
    bool isDark,
    Color textColor, {
    bool enabled = true,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.outfit(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: textColor.withValues(alpha: 0.7),
          ),
        ),
        SizedBox(height: 8.h),
        TextField(
          controller: controller,
          enabled: enabled,
          style: GoogleFonts.outfit(
            fontSize: 16.sp,
            color: enabled ? textColor : textColor.withValues(alpha: 0.5),
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            hintText: placeholder,
            hintStyle: GoogleFonts.outfit(
              fontSize: 16.sp,
              color: textColor.withValues(alpha: 0.4),
            ),
            prefixIcon: Icon(
              icon,
              color: textColor.withValues(alpha: 0.6),
              size: 22.sp,
            ),
            filled: true,
            fillColor: isDark
                ? AppColors.igSurface
                : Colors.white.withValues(alpha: 0.6),
            contentPadding: EdgeInsets.symmetric(
              vertical: 16.h,
              horizontal: 20.w,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.w),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.w),
              borderSide: BorderSide(
                color: isDark
                    ? AppColors.igBorder
                    : Colors.white.withValues(alpha: 0.5),
                width: 1.w,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.w),
              borderSide: BorderSide(
                color: textColor.withValues(alpha: 0.2),
                width: 1.w,
              ),
            ),
          ),
        ),
      ],
    );
  }

  String _getInitials(String name) {
    if (name.isEmpty) return "";
    List<String> parts = name.trim().split(RegExp(r'\s+'));
    if (parts.length == 1) return parts[0][0].toUpperCase();
    return (parts[0][0] + parts.last[0]).toUpperCase();
  }
}
