import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:truck_mandi/ui/features/sell_spare_parts/view_model/auto_parts_view_model.dart';
import 'package:truck_mandi/ui/features/sell_trucks/view/truck_media_picker.dart';

Widget autoMediaPicker(
  BuildContext context,
  String label,
  AutoPartsViewModel viewModel,
) {
  Future<void> showMediaSourceActionSheet() async {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text("Take a photo"),
                onTap: () async {
                  Navigator.pop(context);
                  final picker = ImagePicker();
                  final file = await picker.pickImage(
                    source: ImageSource.camera,
                  );
                  if (file != null) {
                    viewModel.addMedia(File(file.path), 'image');
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text("Choose photos"),
                onTap: () async {
                  Navigator.pop(context);
                  final picker = ImagePicker();
                  final files = await picker.pickMultiImage();
                  for (final file in files) {
                    viewModel.addMedia(File(file.path), 'image');
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  return Consumer<AutoPartsViewModel>(
    builder: (_, vm, __) {
      final media = vm.media;

      // 🔹 0 OR 1 MEDIA → FULL WIDTH
      if (media.length <= 1) {
        return GestureDetector(
          onTap: showMediaSourceActionSheet,
          child: Stack(
            children: [
              Container(
                height: 140,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: media.isEmpty
                      ? Border.all(color: Colors.black26)
                      : null,
                  image: media.isNotEmpty
                      ? DecorationImage(
                          image: FileImage(media.first['file']),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: media.isEmpty
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/svg/uploadfile.svg",
                            height: 22,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            label,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      )
                    : null,
              ),

              // ➕ overlay
              if (media.length == 1)
                Positioned.fill(
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black54,
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                  ),
                ),

              // ❌ remove
              if (media.length == 1)
                Positioned(
                  top: 6,
                  right: 6,
                  child: GestureDetector(
                    onTap: () => vm.removeMedia(0),
                    child: const CircleAvatar(
                      radius: 12,
                      backgroundColor: Colors.red,
                      child: Icon(Icons.close, size: 14, color: Colors.white),
                    ),
                  ),
                ),
            ],
          ),
        );
      }

      // 🔹 2+ MEDIA → GRID
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: media.length + 1,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (_, index) {
          if (index == media.length) {
            return AddMediaTile(onTap: showMediaSourceActionSheet);
          }

          return MediaTile(
            file: media[index]['file'],
            onRemove: () => vm.removeMedia(index),
          );
        },
      );
    },
  );
}
