import 'package:flutter/material.dart';
import 'package:truck_mandi/ui/core/theme/color.dart';

import 'package:truck_mandi/configs/routing/my_navigation_service.dart';
import 'package:truck_mandi/ui/features/home/view/truck_details_screen.dart';

class TruckListScreen extends StatelessWidget {
  final String category;

  const TruckListScreen({super.key, required this.category});

  // Realistic truck data based on category
  List<Map<String, String>> _getTrucksByCategory(String category) {
    switch (category.toLowerCase()) {
      case 'automatic':
        return [
          {
            'id': '1',
            'image': 'assets/images/Automatic Truck.png',
            'title': 'Hino 300 Series',
            'price': 'PKR. 4,500,000',
            'location': 'Islamabad',
            'year': '2020',
            'mileage': '45,000 km',
            'condition': 'Excellent',
            'transmission': 'Automatic',
          },
          {
            'id': '2',
            'image': 'assets/images/Automatic Truck.png',
            'title': 'Isuzu Forward',
            'price': 'PKR. 5,200,000',
            'location': 'Lahore',
            'year': '2021',
            'mileage': '32,000 km',
            'condition': 'Like New',
            'transmission': 'Automatic',
          },
          {
            'id': '3',
            'image': 'assets/images/Automatic Truck.png',
            'title': 'Fuso Canter',
            'price': 'PKR. 3,800,000',
            'location': 'Karachi',
            'year': '2019',
            'mileage': '68,000 km',
            'condition': 'Good',
            'transmission': 'Automatic',
          },
          {
            'id': '4',
            'image': 'assets/images/Automatic Truck.png',
            'title': 'Mercedes-Benz Atego',
            'price': 'PKR. 7,500,000',
            'location': 'Rawalpindi',
            'year': '2022',
            'mileage': '28,000 km',
            'condition': 'Excellent',
            'transmission': 'Automatic',
          },
        ];

      case 'dumper truck':
        return [
          {
            'id': '5',
            'image': 'assets/images/Dumper Truck.png',
            'title': 'Shacman F3000',
            'price': 'PKR. 6,200,000',
            'location': 'Faisalabad',
            'year': '2020',
            'mileage': '85,000 km',
            'condition': 'Good',
            'transmission': 'Manual',
          },
          {
            'id': '6',
            'image': 'assets/images/Dumper Truck.png',
            'title': 'FAW J6P Dumper',
            'price': 'PKR. 5,800,000',
            'location': 'Multan',
            'year': '2019',
            'mileage': '95,000 km',
            'condition': 'Fair',
            'transmission': 'Manual',
          },
          {
            'id': '7',
            'image': 'assets/images/Dumper Truck.png',
            'title': 'Howo Sinotruk',
            'price': 'PKR. 6,500,000',
            'location': 'Peshawar',
            'year': '2021',
            'mileage': '52,000 km',
            'condition': 'Excellent',
            'transmission': 'Manual',
          },
          {
            'id': '8',
            'image': 'assets/images/Dumper Truck.png',
            'title': 'JAC Heavy Duty',
            'price': 'PKR. 5,500,000',
            'location': 'Sialkot',
            'year': '2018',
            'mileage': '120,000 km',
            'condition': 'Good',
            'transmission': 'Manual',
          },
        ];

      case 'flatbed truck':
        return [
          {
            'id': '9',
            'image': 'assets/images/Flatted.png',
            'title': 'Isuzu NPR Flatbed',
            'price': 'PKR. 4,200,000',
            'location': 'Gujranwala',
            'year': '2020',
            'mileage': '55,000 km',
            'condition': 'Very Good',
            'transmission': 'Manual',
          },
          {
            'id': '10',
            'image': 'assets/images/Flatted.png',
            'title': 'Hino 500 Flatbed',
            'price': 'PKR. 4,800,000',
            'location': 'Islamabad',
            'year': '2021',
            'mileage': '38,000 km',
            'condition': 'Excellent',
            'transmission': 'Manual',
          },
          {
            'id': '11',
            'image': 'assets/images/Flatted.png',
            'title': 'Master K-2700',
            'price': 'PKR. 3,200,000',
            'location': 'Lahore',
            'year': '2019',
            'mileage': '72,000 km',
            'condition': 'Good',
            'transmission': 'Manual',
          },
        ];

      case 'tailer truck':
      case 'trailer truck':
        return [
          {
            'id': '12',
            'image': 'assets/images/Tailer Truck.png',
            'title': 'Volvo FH16 Trailer',
            'price': 'PKR. 12,500,000',
            'location': 'Karachi',
            'year': '2021',
            'mileage': '145,000 km',
            'condition': 'Excellent',
            'transmission': 'Automatic',
          },
          {
            'id': '13',
            'image': 'assets/images/Tailer Truck.png',
            'title': 'Scania R450 Trailer',
            'price': 'PKR. 15,000,000',
            'location': 'Lahore',
            'year': '2022',
            'mileage': '98,000 km',
            'condition': 'Like New',
            'transmission': 'Automatic',
          },
          {
            'id': '14',
            'image': 'assets/images/Tailer Truck.png',
            'title': 'Mercedes Actros',
            'price': 'PKR. 13,800,000',
            'location': 'Islamabad',
            'year': '2020',
            'mileage': '165,000 km',
            'condition': 'Good',
            'transmission': 'Automatic',
          },
        ];

      case 'container carrier':
        return [
          {
            'id': '15',
            'image': 'assets/images/Container.png',
            'title': 'Hino 700 Container',
            'price': 'PKR. 8,500,000',
            'location': 'Karachi Port',
            'year': '2020',
            'mileage': '125,000 km',
            'condition': 'Good',
            'transmission': 'Manual',
          },
          {
            'id': '16',
            'image': 'assets/images/Container.png',
            'title': 'FAW J7 Container',
            'price': 'PKR. 7,800,000',
            'location': 'Port Qasim',
            'year': '2019',
            'mileage': '158,000 km',
            'condition': 'Fair',
            'transmission': 'Manual',
          },
        ];

      case 'box truck':
        return [
          {
            'id': '17',
            'image': 'assets/images/Box Truck.png',
            'title': 'Isuzu NQR Box',
            'price': 'PKR. 4,500,000',
            'location': 'Lahore',
            'year': '2021',
            'mileage': '42,000 km',
            'condition': 'Excellent',
            'transmission': 'Manual',
          },
          {
            'id': '18',
            'image': 'assets/images/Box Truck.png',
            'title': 'Fuso Fighter Box',
            'price': 'PKR. 5,200,000',
            'location': 'Faisalabad',
            'year': '2020',
            'mileage': '65,000 km',
            'condition': 'Very Good',
            'transmission': 'Manual',
          },
        ];

      case 'freezer truck':
        return [
          {
            'id': '19',
            'image': 'assets/images/Freezer Truck.png',
            'title': 'Isuzu Reefer',
            'price': 'PKR. 6,500,000',
            'location': 'Lahore',
            'year': '2021',
            'mileage': '38,000 km',
            'condition': 'Excellent',
            'transmission': 'Automatic',
          },
          {
            'id': '20',
            'image': 'assets/images/Freezer Truck.png',
            'title': 'Hino Cold Chain',
            'price': 'PKR. 7,200,000',
            'location': 'Karachi',
            'year': '2022',
            'mileage': '25,000 km',
            'condition': 'Like New',
            'transmission': 'Automatic',
          },
        ];

      case 'tanker truck':
        return [
          {
            'id': '21',
            'image': 'assets/images/Tanker Truck.png',
            'title': 'Hino Water Tanker',
            'price': 'PKR. 5,800,000',
            'location': 'Rawalpindi',
            'year': '2020',
            'mileage': '78,000 km',
            'condition': 'Good',
            'transmission': 'Manual',
          },
          {
            'id': '22',
            'image': 'assets/images/Tanker Truck.png',
            'title': 'Isuzu Fuel Tanker',
            'price': 'PKR. 7,500,000',
            'location': 'Islamabad',
            'year': '2021',
            'mileage': '52,000 km',
            'condition': 'Excellent',
            'transmission': 'Manual',
          },
        ];

      default:
        return [
          {
            'id': '23',
            'image': 'assets/images/remove_me1.png',
            'title': 'Hino Ranger',
            'price': 'PKR. 4,200,000',
            'location': 'Lahore',
            'year': '2020',
            'mileage': '55,000 km',
            'condition': 'Good',
            'transmission': 'Manual',
          },
          {
            'id': '24',
            'image': 'assets/remove/truck_1.png',
            'title': 'Isuzu Giga',
            'price': 'PKR. 5,500,000',
            'location': 'Karachi',
            'year': '2021',
            'mileage': '42,000 km',
            'condition': 'Excellent',
            'transmission': 'Manual',
          },
        ];
    }
  }

  @override
  Widget build(BuildContext context) {
    final trucks = _getTrucksByCategory(category);

    return Scaffold(
      appBar: AppBar(
        title: Text(category),
        backgroundColor: AppColors.whiteColor,
      ),
      body: trucks.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.local_shipping_outlined,
                    size: 80,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'No trucks available',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: trucks.length,
              itemBuilder: (context, index) {
                final truck = trucks[index];
                return GestureDetector(
                  onTap: () {
                    MyNavigationService.push(TruckDetailsScreen(truck: truck));
                  },
                  child: Card(
                    color: AppColors.whiteColor,
                    margin: const EdgeInsets.only(bottom: 16),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(12),
                              ),
                              child: Image.asset(
                                truck['image']!,
                                height: 200,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              top: 12,
                              right: 12,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: _getConditionColor(
                                    truck['condition']!,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  truck['condition']!,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                truck['title']!,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                truck['price']!,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.primary,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  _buildInfoChip(
                                    Icons.calendar_today,
                                    truck['year']!,
                                  ),
                                  SizedBox(width: 8),
                                  _buildInfoChip(
                                    Icons.speed,
                                    truck['mileage']!,
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  _buildInfoChip(
                                    Icons.settings,
                                    truck['transmission']!,
                                  ),
                                  SizedBox(width: 8),
                                  _buildInfoChip(
                                    Icons.location_on,
                                    truck['location']!,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  Widget _buildInfoChip(IconData icon, String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: Colors.grey.shade700),
          SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
          ),
        ],
      ),
    );
  }

  Color _getConditionColor(String condition) {
    switch (condition.toLowerCase()) {
      case 'excellent':
      case 'like new':
        return Colors.green;
      case 'very good':
        return Colors.lightGreen;
      case 'good':
        return Colors.blue;
      case 'fair':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
}
