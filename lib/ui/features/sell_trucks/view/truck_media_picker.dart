import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:truck_mandi/ui/core/theme/color.dart';
import 'package:truck_mandi/ui/features/sell_trucks/view_model/truck_view_model.dart';

Widget truckMediaPicker(
  BuildContext context,
  String label,
  TruckViewModel viewModel,
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
                title: const Text("Choose from gallery"),
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

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Consumer<TruckViewModel>(
        builder: (_, vm, __) {
          final media = vm.media;

          // 0 OR 1 ITEM → FULL WIDTH
          if (media.length <= 1) {
            return GestureDetector(
              onTap: showMediaSourceActionSheet,
              child: Stack(
                children: [
                  Container(
                    height: 140, // 👈 THIS is the key change
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: media.isEmpty
                          ? Border.all(color: Colors.black26)
                          : null,
                      color: media.isEmpty ? Colors.white : null,
                      image: media.isNotEmpty
                          ? DecorationImage(
                              image: FileImage(media.first['file']),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: media.isEmpty
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
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

                  // ➕ overlay when single image exists
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
                          child: Icon(
                            Icons.close,
                            size: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            );
          }

          // 2+ ITEMS → GRID
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
      ),
    ],
  );
}

class MediaTile extends StatelessWidget {
  final File file;
  final VoidCallback onRemove;

  const MediaTile({super.key, required this.file, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(image: FileImage(file), fit: BoxFit.cover),
          ),
        ),
        Positioned(
          top: -6,
          right: -6,
          child: GestureDetector(
            onTap: onRemove,
            child: const CircleAvatar(
              radius: 12,
              backgroundColor: Colors.red,
              child: Icon(Icons.close, size: 14, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}

class AddMediaTile extends StatelessWidget {
  final VoidCallback onTap;

  const AddMediaTile({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.black26),
          color: const Color(0xfff3faf6),
        ),
        child: Center(
          child: Icon(Icons.add, size: 36, color: AppColors.primary),
        ),
      ),
    );
  }
}
