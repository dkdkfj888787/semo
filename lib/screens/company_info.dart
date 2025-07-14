import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CompanyInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.aboutCompany),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  l10n.companyName,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),
            SizedBox(height: 30),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.developmentDate,
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    SizedBox(height: 10),
                    Text(
                      l10n.releaseDate,
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.aboutCompany,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    SizedBox(height: 10),
                    Text(
                      l10n.companyDescription,
                      style: Theme.of(context).textTheme.displayMedium,
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'المزيد من المعلومات',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'شركة فوكسين هي شركة رائدة في مجال تطوير تطبيقات الترفيه والبث المباشر. نحن نسعى لتقديم أفضل تجربة مشاهدة للمستخدمين من خلال التقنيات الحديثة والتصميم المبتكر.',
                      style: Theme.of(context).textTheme.displayMedium,
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(height: 15),
                    Text(
                      'رؤيتنا: أن نكون الخيار الأول للمستخدمين في عالم الترفيه الرقمي.',
                      style: Theme.of(context).textTheme.displayMedium,
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'مهمتنا: تطوير حلول تقنية متقدمة تلبي احتياجات المستخدمين وتوفر لهم تجربة استثنائية.',
                      style: Theme.of(context).textTheme.displayMedium,
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}