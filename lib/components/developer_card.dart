import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smartStoveApp/utilities/utils.dart';

class DeveloperCard extends StatelessWidget {
  final String developerName;
  final String developerEmail;
  final String developerImg;

  const DeveloperCard({
    super.key,
    required this.developerName,
    required this.developerEmail,
    required this.developerImg,
  });

  @override
  Widget build(BuildContext context) {
    const Color firstColor = Color.fromARGB(255, 148, 179, 174);
    const Color secondColor = Color.fromARGB(255, 8, 67, 143);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        width: 350,
        decoration: BoxDecoration(
          gradient: developerName == 'Neriya Zudi'
              ? const LinearGradient(colors: [secondColor, firstColor])
              : const LinearGradient(colors: [firstColor, secondColor]),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: developerName == 'Neriya Zudi'
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.transparent,
                            foregroundImage: AssetImage(developerImg),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            developerName,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Ubuntu',
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            developerEmail,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Ubuntu',
                            ),
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(width: 12),
                          buildSocialIcon(
                              FontAwesomeIcons.github, openGitLink, 1),
                          const SizedBox(width: 12),
                          buildSocialIcon(
                              FontAwesomeIcons.linkedin, openLinkedinLink, 1),
                          const SizedBox(width: 12),
                          buildSocialIcon(
                              FontAwesomeIcons.facebook, openFacebookLink, 1),
                        ],
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(width: 12),
                          buildSocialIcon(
                              FontAwesomeIcons.github, openGitLink, 2),
                          const SizedBox(width: 12),
                          buildSocialIcon(
                              FontAwesomeIcons.linkedin, openLinkedinLink, 2),
                          const SizedBox(width: 12),
                          buildSocialIcon(
                              FontAwesomeIcons.facebook, openFacebookLink, 2),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.transparent,
                            foregroundImage: AssetImage(developerImg),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            developerName,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Ubuntu',
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            developerEmail,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Ubuntu',
                            ),
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ],
                  )),
      ),
    );
  }

  Widget buildSocialIcon(
          IconData icon, void Function(int num) onTap, int devNum) =>
      CircleAvatar(
          radius: 25,
          child: Material(
            shape: const CircleBorder(),
            clipBehavior: Clip.hardEdge,
            color: Colors.transparent,
            child: InkWell(
              key: UniqueKey(),
              onTap: () {
                onTap(devNum);
              },
              child: Center(
                child: Icon(icon, size: 32),
              ),
            ),
          ));

  void openGitLink(int i) {
    i == 1
        ? Utils.openLink(url: 'https://github.com/NeriyaZudi')
        : Utils.openLink(url: 'https://github.com/elon11');
  }

  void openLinkedinLink(int i) {
    i == 1
        ? Utils.openLink(url: 'https://www.linkedin.com/in/neriyazudi/')
        : Utils.openLink(
            url: 'https://www.linkedin.com/in/elon-ifrach-2b5977213/');
  }

  void openFacebookLink(int i) {
    i == 1
        ? Utils.openLink(url: 'https://www.facebook.com/neriyazudi')
        : Utils.openLink(
            url: 'https://www.facebook.com/profile.php?id=100005280617101');
  }
}
