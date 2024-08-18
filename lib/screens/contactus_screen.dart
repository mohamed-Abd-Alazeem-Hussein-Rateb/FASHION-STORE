import 'package:flutter/material.dart';
import 'package:flutter_application_1/contuc_cubit/contuctus_cubit.dart';
import 'package:flutter_application_1/contuc_cubit/contuctus_state.dart';
import 'package:flutter_application_1/widget/costant_color.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsPage extends StatelessWidget {
  void _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fourthColor,
      body: BlocBuilder<ContuctusCubit, ContuctusState>(
        builder: (context, state) {
          if (state is ContactLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ContactLoaded) {
            return ListView.builder(
              itemCount: state.contactss.length,
              itemBuilder: (context, index) {
                final contact = state.contactss[index];
                
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    color: fourthColor,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 60,
                          height: 60,
                          child: Image.network(
                            contact.image,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              } else {
                                return Center(child: CircularProgressIndicator());
                              }
                            },
                            errorBuilder: (context, error, stackTrace) {
                              // استخدم صورة افتراضية في حالة حدوث خطأ
                              return Image.asset(
                                'images/auth_background.png', // صورة افتراضية من مجلد assets
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Text(contact.value),
                        ),
                        IconButton(
                          icon: Icon(Icons.arrow_forward),
                          onPressed: () {
                            switch (contact.type) {
                              case 1: // Phone
                                _launchURL('tel:${contact.value}');
                                break;
                              case 2: // Email
                                _launchURL('mailto:${contact.value}');
                                break;
                              case 3: // Link
                                _launchURL(contact.value);
                                break;
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state is ContactError) {
            return Center(child: Text(state.message));
          }
          return Center(child: Text('Something went wrong!'));
        },
      ),
    );
  }
}
