import 'package:flutter/material.dart';

class ThemeOption{
  final String title;
  final String imagePath;
  final String route;

  ThemeOption({
    required this.title,
    required this.imagePath,
    required this.route,
  });
}

class OtherThemesPage extends StatelessWidget {
  OtherThemesPage({super.key});

  final List<ThemeOption> themes = [ // THeme list

    ThemeOption(
      title: 'Sunrise Minimal',
      imagePath: 'assets/themeprev/theme1.png',
      route: '/Theme1'),

    ThemeOption(
      title: 'Black Gradient',
      imagePath: 'assets/themeprev/theme2.png',
      route: '/Theme2'
    ),

    ThemeOption(
      title: 'Purple Theme', 
      imagePath: 'assets/themeprev/theme3.png', 
      route: '/Theme3'
    ),

        ThemeOption(
      title: 'Yellow Theme',
      imagePath: 'assets/themeprev/theme4.png',
      route: '/Theme4',
    ),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Other Themes'),
      ),

      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.85,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16
          ),
        itemCount: themes.length,
        itemBuilder: (context,index){
          return ThemeCard(theme : themes[index]);
        }
      )
    );
  }
}

class ThemeCard extends StatelessWidget {
  final ThemeOption theme;

  const ThemeCard({super.key, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () => _showFullScreen(context),
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Hero(
                tag: theme.title, 
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                  child: Image.asset(
                    theme.imagePath,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                )
              )
            ),

            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                theme.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  void _showFullScreen(BuildContext context){
  Navigator.of(context).pushNamed(theme.route);
}
}