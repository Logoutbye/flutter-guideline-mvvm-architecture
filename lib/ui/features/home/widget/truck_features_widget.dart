import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TruckFeaturesWidget extends StatelessWidget {
  final List<String> featureNames;

  TruckFeaturesWidget({super.key, required this.featureNames});

  final List<TruckFeature> allFeatures = [
    TruckFeature(name: "ABS", iconPath: "assets/svg/truck.svg"),
    TruckFeature(name: "Air Bags", iconPath: "assets/svg/air_bag.svg"),
    TruckFeature(name: "Alloy Rims", iconPath: "assets/svg/allow_rims.svg"),

    TruckFeature(name: "CD Player", iconPath: "assets/svg/cd_player.svg"),
    TruckFeature(
        name: "Immobilizer Key", iconPath: "assets/svg/keys.svg"),
    TruckFeature(
        name: "Keyless Entry", iconPath: "assets/svg/key_less.svg"),
    TruckFeature(name: "Power Locks", iconPath: "assets/svg/power_locks.svg"),
    TruckFeature(
        name: "Power Mirrors", iconPath: "assets/svg/power_mirrors.svg"),
    TruckFeature(
        name: "Power Steering", iconPath: "assets/svg/power_steering.svg"),
    TruckFeature(
        name: "Power Windows", iconPath: "assets/svg/power_windows.svg"),
    TruckFeature(
        name: "Air Conditioning", iconPath: "assets/svg/air_condition.svg"),
    TruckFeature(name: "AM/FM Radio", iconPath: "assets/svg/radio.svg"),
  ];

  @override
  Widget build(BuildContext context) {
    final availableFeatures = allFeatures
        .where(
          (feature) => featureNames.contains(feature.name),
        )
        .toList();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Truck Feature",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1,
            ),
            itemCount: availableFeatures.length,
            itemBuilder: (context, index) {
              final feature = availableFeatures[index];
              return FeatureTile(feature: feature);
            },
          ),
        ],
      ),
    );
  }
}

class FeatureTile extends StatelessWidget {
  final TruckFeature feature;

  const FeatureTile({
    super.key,
    required this.feature,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 50,
          height: 50,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          child: SvgPicture.asset(
            feature.iconPath,
            // 'assets/svg/air_bag.svg',
          ),
        ),
        const SizedBox(height: 8),
        Text(
          feature.name,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.green.shade800,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class TruckFeature {
  final String name;
  final String iconPath;

  const TruckFeature({required this.name, required this.iconPath});
}
