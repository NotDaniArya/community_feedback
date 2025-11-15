import 'package:community_feedback/features/our%20developer/presentation/widgets/developer_container.dart';
import 'package:community_feedback/utils/constant/colors.dart';
import 'package:community_feedback/utils/constant/sizes.dart';
import 'package:community_feedback/utils/constant/texts.dart';
import 'package:flutter/material.dart';

class OurDeveloperScreen extends StatelessWidget {
  const OurDeveloperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    const devIdentity = TTexts.devIdentity;

    return Scaffold(
      backgroundColor: TColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: TColors.backgroundColor,
        centerTitle: true,
        title: _appBarTitle(textTheme),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(TSizes.scaffoldPadding),
          child: Column(
            children: [
              Text(
                'Tim yang membangun Feedback Wall — dari riset, desain, sampai deploy.',
                textAlign: TextAlign.center,
                style: textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: devIdentity.length,
                itemBuilder: (context, index) {
                  final developer = devIdentity[index];

                  return DeveloperContainer(
                    textTheme: textTheme,
                    profileImage: developer['image'],
                    name: developer['name'],
                    position: developer['position'],
                    description: developer['description'],
                    tools: developer['tools'] as List<Map<String, String>>,
                    linkedinUrl: developer['linkedin'],
                    email: developer['email'],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _appBarTitle(TextTheme textTheme) {
    return ShaderMask(
      shaderCallback: (bounds) {
        final gradient = LinearGradient(
          colors: [
            Colors.black,
            TColors.secondaryText,
            TColors.secondaryText.withOpacity(0.8),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );

        return gradient.createShader(bounds);
      },
      blendMode: BlendMode.srcIn,
      child: Text(
        'Our Developer',
        style: textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
}
