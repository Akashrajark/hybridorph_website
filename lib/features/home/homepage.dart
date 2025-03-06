import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../common_widget/custom_alert_dialog.dart';

class AmalaBhavanHomePage extends StatefulWidget {
  const AmalaBhavanHomePage({super.key});

  @override
  State<AmalaBhavanHomePage> createState() => _AmalaBhavanHomePageState();
}

class _AmalaBhavanHomePageState extends State<AmalaBhavanHomePage> {
  final List<String> _imageUrls = [];

  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() {
    Supabase.instance.client.from('gallerys').select('*').then((response) {
      final data = response;
      final images = data.map((image) {
        return image['image'] as String;
      }).toList();

      setState(() {
        _imageUrls.clear();
        _imageUrls.addAll(images);
      });
    }).onError((e, s) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error fetching users: ${e!.toString()}")));
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isDesktop = screenSize.width > 900;

    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            const Text(
              'Hybridorph',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          if (isDesktop)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  NavItem('HOME'),
                  NavItem('ABOUT'),
                  NavItem('ACTIVITIES'),
                  NavItem('GALLERY'),
                  NavItem(
                    'DONATE',
                    onTap: () {
                      launchUrl(Uri.parse(
                          'https://razorpay.com/payment-link/plink_Q2vaArhY1M9pAn/test'));
                    },
                  ),
                  NavItem('CONTACT'),
                ],
              ),
            ),
          if (!isDesktop)
            IconButton(
              icon: const Icon(Icons.menu, color: Colors.black),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
            ),
        ],
      ),
      endDrawer: !isDesktop
          ? Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  const DrawerHeader(
                    decoration: BoxDecoration(
                      color: Color(0xFF4CAF50),
                    ),
                    child: Text(
                      'Hybridorph',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  ListTile(title: const Text('HOME'), onTap: () {}),
                  ListTile(title: const Text('ABOUT'), onTap: () {}),
                  ListTile(title: const Text('ACTIVITIES'), onTap: () {}),
                  ListTile(title: const Text('GALLERY'), onTap: () {}),
                  ListTile(
                      title: const Text('DONATE'),
                      onTap: () {
                        launchUrl(Uri.parse(
                            'https://razorpay.com/payment-link/plink_Q2vaArhY1M9pAn/test'));
                      }),
                  ListTile(title: const Text('CONTACT'), onTap: () {}),
                ],
              ),
            )
          : null,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Hero Section
            Container(
              height: MediaQuery.sizeOf(context).height,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage('assets/images/group of kids.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.6),
                      Colors.black.withOpacity(0.4)
                    ],
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'WELCOME TO HYBRIDORPH',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'A Home for Children in Need',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 32),
                      ElevatedButton(
                        onPressed: () {
                          launchUrl(Uri.parse(
                              'https://razorpay.com/payment-link/plink_Q2vaArhY1M9pAn/test'));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4CAF50),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 16),
                        ),
                        child: const Text(
                          'DONATE NOW',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // About Section
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                children: [
                  const Text(
                    'ABOUT US',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4CAF50),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Hybridorph is a registered charitable organization dedicated to serving the poorest of the poor in India.',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  Wrap(
                    spacing: 24,
                    runSpacing: 24,
                    alignment: WrapAlignment.center,
                    children: [
                      FeatureCard(
                        icon: Icons.child_care,
                        title: 'Child Care',
                        description:
                            'Providing care and education to underprivileged children',
                      ),
                      FeatureCard(
                        icon: Icons.home,
                        title: 'Shelter',
                        description:
                            'Safe home for children without families or support',
                      ),
                      FeatureCard(
                        icon: Icons.school,
                        title: 'Education',
                        description:
                            'Quality education and learning opportunities',
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Impact Section
            Container(
              padding: const EdgeInsets.all(32.0),
              color: const Color(0xFFF5F5F5),
              child: Column(
                children: [
                  const Text(
                    'OUR IMPACT',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4CAF50),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Wrap(
                    spacing: 32,
                    runSpacing: 32,
                    alignment: WrapAlignment.center,
                    children: [
                      ImpactCounter(count: '100+', label: 'Children Supported'),
                      ImpactCounter(count: '20+', label: 'Years of Service'),
                      ImpactCounter(count: '50+', label: 'Volunteers'),
                    ],
                  ),
                ],
              ),
            ),

            // Gallery Section
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                children: [
                  const Text(
                    'GALLERY',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4CAF50),
                    ),
                  ),
                  if (_imageUrls.isEmpty)
                    Center(
                      child: Text("No images found"),
                    )
                  else
                    GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding:
                          EdgeInsets.symmetric(horizontal: 100, vertical: 10),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: _imageUrls.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => CustomAlertDialog(
                                title: 'Remove Image',
                                description:
                                    'Are you sure you want to remove this image?',
                                primaryButton: 'Remove',
                                onPrimaryPressed: () async {
                                  await Supabase.instance.client
                                      .from('gallerys')
                                      .delete()
                                      .eq('image', _imageUrls[index]);
                                  Navigator.pop(context);
                                  getData();
                                },
                                secondaryButton: 'Cancel',
                                onSecondaryPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            );
                          },
                          child: Image.network(
                            _imageUrls[index],
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    ),
                ],
              ),
            ),

            // Call to Action
            Container(
              padding: const EdgeInsets.all(32.0),
              color: const Color(0xFF4CAF50),
              child: Column(
                children: [
                  const Text(
                    'MAKE A DIFFERENCE TODAY',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Your support can change the lives of children in need',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () {
                      launchUrl(Uri.parse(
                          'https://razorpay.com/payment-link/plink_Q2vaArhY1M9pAn/test'));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 16),
                    ),
                    child: const Text(
                      'DONATE NOW',
                      style: TextStyle(fontSize: 16, color: Color(0xFF4CAF50)),
                    ),
                  ),
                ],
              ),
            ),

            // Footer
            Container(
              padding: const EdgeInsets.all(32.0),
              color: Colors.black87,
              child: Column(
                children: [
                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    alignment: WrapAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: const Text('Home',
                            style: TextStyle(color: Colors.white)),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text('About',
                            style: TextStyle(color: Colors.white)),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text('Activities',
                            style: TextStyle(color: Colors.white)),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text('Gallery',
                            style: TextStyle(color: Colors.white)),
                      ),
                      TextButton(
                        onPressed: () {
                          launchUrl(Uri.parse(
                              'https://razorpay.com/payment-link/plink_Q2vaArhY1M9pAn/test'));
                        },
                        child: const Text('Donate',
                            style: TextStyle(color: Colors.white)),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text('Contact',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    '© 2025 Hybridorph. All Rights Reserved.',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NavItem extends StatelessWidget {
  final String title;
  final Function()? onTap;

  const NavItem(this.title, {super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
          backgroundColor: Colors.white.withAlpha(150),
        ),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const FeatureCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 48,
            color: const Color(0xFF4CAF50),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class ImpactCounter extends StatelessWidget {
  final String count;
  final String label;

  const ImpactCounter({
    super.key,
    required this.count,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Column(
        children: [
          Text(
            count,
            style: const TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: Color(0xFF4CAF50),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
