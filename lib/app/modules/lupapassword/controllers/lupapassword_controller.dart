import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LupapasswordController extends GetxController {
  TextEditingController emailController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;

  void resetPassword(String email) async {
    final String email = emailController.text.trim();
    if (email.isEmpty) {
      Get.snackbar("Error", "Masukan email anda");
      return;
    }
    try {
      await auth.sendPasswordResetEmail(email: email);
      Get.snackbar('Sukses', 'Pengaturan ulang password telah dikirim');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar('Gagal', 'Tidak ditemukan untuk email tersebut');
      } else {
        Get.snackbar('Gagal', 'Gagal mengirim pengaturan ulang password');
      }
    } catch (e) {
      Get.snackbar('Gagal', 'terjadi kesalahan, ulangi kembali');
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
