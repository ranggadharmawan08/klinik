import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: controller.onWillPop,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xFF01CBEF),
          title: Row(
            children: [
              Obx(() => CircleAvatar(
                    child: controller.profileImageUrl.value.isNotEmpty
                        ? Image.network(
                            controller.profileImageUrl.value,
                          )
                        : Image.asset(
                            'assets/images/Vector.png',
                            width: 20,
                            height: 20,
                          ),
                  )),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Selamat Datang',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                  Obx(() => Text(
                        controller.name.value,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      )),
                ],
              ),
            ],
          ),
          actions: [
            PopupMenuButton(
              color: const Color(0xFF807D7D),
              iconColor: Colors.white,
              itemBuilder: (BuildContext context) {
                return [
                  const PopupMenuItem(
                    child: Text(
                      'Profil Saya',
                      style: TextStyle(color: Colors.white),
                    ),
                    value: 'Profil Saya',
                  ),
                  const PopupMenuItem(
                    child: Text(
                      'Faq',
                      style: TextStyle(color: Colors.white),
                    ),
                    value: 'Faq',
                  ),
                  const PopupMenuItem(
                    child: Text(
                      'Keluar',
                      style: TextStyle(color: Colors.white),
                    ),
                    value: 'Keluar',
                  ),
                ];
              },
              onSelected: (value) {
                // Handle ketika salah satu pilihan dipilih
                switch (value) {
                  case 'Profil Saya':
                    Navigator.pushNamed(
                        context, '/profile'); // Navigasi ke halaman Profil
                    break;
                  case 'Faq':
                    Navigator.pushNamed(
                        context, '/faq'); // Navigasi ke halaman FAQ
                    break;
                  case 'Keluar':
                    confirmLogout(
                        context); // Panggil fungsi logout di controller
                    break;
                  default:
                }
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 28),
            child: Column(
              children: [
                imageSection(),
                menuSection(context),
                patientStatusSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget imageSection() {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      margin: const EdgeInsets.fromLTRB(19, 20, 19, 22),
      height: 136,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: PageView(
          children: [
            Image.asset(
              'assets/images/ruang1.jpg',
              fit: BoxFit.cover,
            ),
            Image.asset(
              'assets/images/ruang2.jpg',
              fit: BoxFit.cover,
            ),
            Image.asset(
              'assets/images/ruang3.jpg',
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }

  Widget menuSection(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(19, 0, 19, 18),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0x9901CBEF),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  // Navigasi ke halaman pasien
                  Navigator.pushNamed(context, '/pasienlist');
                },
                child: menuItem('Pasien', 'assets/images/pasienn.png'),
              ),
              GestureDetector(
                onTap: () {
                  // Navigasi ke halaman rekam medis
                  Navigator.pushNamed(context, '/rekam_medis');
                },
                child: menuItem('Rekam Medis', 'assets/images/rekammediss.png'),
              ),
            ],
          ),
          const SizedBox(height: 22.4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  // Navigasi ke halaman jadwal praktek
                  Navigator.pushNamed(context, '/jadwalpraktik');
                },
                child: menuItem('Jadwal Praktek', 'assets/images/jadwall.png'),
              ),
              GestureDetector(
                onTap: () {
                  // Navigasi ke halaman antrian pasien
                  Navigator.pushNamed(context, '/antrianpasien');
                },
                child: menuItem('Antrian Pasien', 'assets/images/antriann.png'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget menuItem(String title, String imagePath) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 14.2),
          width: 121.4,
          height: 117.8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color(0xFFC4C4C4),
            image: DecorationImage(
              fit: BoxFit.contain,
              image: AssetImage(imagePath),
            ),
          ),
        ),
        Text(
          title,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            fontSize: 12,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget patientStatusSection() {
    return Container(
      margin: const EdgeInsets.fromLTRB(19, 0, 19, 18),
      child: Column(
        children: [
          Obx(() => patientStatusItem(
                'Sudah Terdaftar',
                controller.sudahTerdaftarCount.value,
              )),
          Obx(() => patientStatusItem(
                'Belum Dilayani',
                controller.belumDilayaniCount.value,
              )),
          Obx(() => patientStatusItem(
                'Sudah Dilayani',
                controller.sudahDilayaniCount.value,
              )),
        ],
      ),
    );
  }

  Widget patientStatusItem(
    String title,
    String count,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0x9901CBEF),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 5, 5, 5),
              shape: BoxShape.circle,
            ),
            child: Container(
              width: 24,
              height: 24,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
              Text(
                count,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void confirmLogout(BuildContext context) {
    Get.defaultDialog(
      title: 'Konfirmasi',
      titleStyle: const TextStyle(
          fontFamily: 'Poppins',
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.w700),
      middleText: 'Apakah Anda yakin ingin Keluar?',
      middleTextStyle: const TextStyle(
          fontFamily: 'Poppins',
          color: Colors.black,
          fontWeight: FontWeight.w500),
      actions: [
        ElevatedButton(
          style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Color(0xFF01CBEF)),
              fixedSize: MaterialStatePropertyAll(Size(100, 10))),
          onPressed: () {
            controller.logout();
          },
          child: const Text(
            'Keluar',
            style: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.black,
            ),
          ),
        ),
        ElevatedButton(
          style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Color(0xFF01CBEF)),
              fixedSize: MaterialStatePropertyAll(Size(100, 10))),
          onPressed: () {
            Get.back();
          },
          child: const Text(
            'Tidak',
            style: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
