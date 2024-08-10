import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/jadwalpraktik_controller.dart';

class JadwalPraktikView extends GetView<JadwalpraktikController> {
  const JadwalPraktikView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF01CBEF),
        title: const Text(
          'Jadwal Praktik',
          style: TextStyle(
            fontFamily: 'Poppins-Medium',
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Doctor Info Widget
            Obx(
              () => Container(
                margin: const EdgeInsets.fromLTRB(1, 0, 0, 29),
                decoration: BoxDecoration(
                  color: const Color(0xFFC4C4C4),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 13, 0),
                      decoration: BoxDecoration(
                        color: const Color(0xFF807D7D),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: controller.profileImageUrl.value.isNotEmpty
                            ? Image.network(
                                controller.profileImageUrl.value,
                                width: 104,
                                height: 113,
                                fit: BoxFit.cover,
                              )
                            : Container(
                                width: 104,
                                height: 113,
                                color: Colors.grey,
                                child: Image.asset(
                                  'assets/images/Vector.png',
                                  width: 20,
                                  height: 20,
                                ),
                              ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 18, 0, 47),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            controller.name.value,
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Color(0xFF000000),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Header
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: const Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Jadwal Praktik',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // List of Schedules
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: controller.jadwalPraktik.length,
                  itemBuilder: (context, hariIndex) {
                    var jadwal = controller.jadwalPraktik[hariIndex];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xFF01CBEF),
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: jadwal.waktuPraktik
                                .asMap()
                                .entries
                                .map((entry) {
                              int waktuIndex = entry.key;
                              var waktu = entry.value;
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    jadwal.hari,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(waktu.jamPraktik),
                                      IconButton(
                                        icon: const Icon(Icons.edit_outlined),
                                        onPressed: () {
                                          _showEditDialog(context, hariIndex,
                                              waktuIndex, waktu.jamPraktik);
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditDialog(
      BuildContext context, int hariIndex, int waktuIndex, String jamPraktik) {
    TextEditingController jamController = TextEditingController();
    jamController.text = jamPraktik;

    Get.defaultDialog(
      title: 'Edit Jam Praktik',
      content: Column(
        children: [
          TextField(
            controller: jamController,
            decoration: const InputDecoration(labelText: 'Jam Praktik'),
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Color(0xFF01CBEF)),
              fixedSize: MaterialStatePropertyAll(Size(100, 10))),
          onPressed: () {
            if (jamController.text.isNotEmpty) {
              controller.updateJamPraktik(
                  hariIndex, waktuIndex, jamController.text);
              Get.back();
            }
          },
          child: const Text(
            'Simpan',
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
            'Batal',
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
