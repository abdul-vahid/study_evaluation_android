// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:study_evaluation/utils/app_utils.dart';

class TermsConditionsView extends StatefulWidget {
  const TermsConditionsView({super.key});

  @override
  State<TermsConditionsView> createState() => _TermsConditionsViewState();
}

class _TermsConditionsViewState extends State<TermsConditionsView> {
  @override
  void initState() {
    SharedPreferences.getInstance().then((prefs) {
      var userModel = AppUtils.getSessionUser(prefs);
      userModel ?? AppUtils.logout(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Terms & Condition',
          style: TextStyle(fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            getCardWhite('Terms & Condition',
                'If you do not wish to provide your information or you are not agreeable to the use of your information by us as stated in “Privacy policy”, you are requested not to use the Website, Web view or App. By accessing this Website and any of its pages, you are agreeing to the terms set out “Privacy Policy” and shall be bound by the same.Privacy Policy – Study Evaluation is committed to protecting your privacy. We have established this Privacy Policy and are providing it to you so that you can understand the manner in which we collect and use your information and the efforts we use to protect it. Please note that this policy is for Study Evaluation Website, Web view and Android App and does not apply to other 3rd party web sites linked to from our web site. Please check the privacy policies on those web sites for more information.'),
            getCardGrey('Personal Information Collected',
                'Our Web view and Android App recognizes the need for consumers to control the use and management of personal information. By personal information we mean information that can be used to identify or contact an individual. This may include, but is not limited to, a first and last name, a physical address, and email address, or a phone number. If you are visiting our site to browse or find information about our course products or services, you do not need to provide any personal information. If you decide to make a purchase, however, we may collect this information so that we can provide you with the product or service you requested.Personal Information Use – Study Evaluation uses personal information provided by you so that we can service your account. Also note we may need to transfer that information to our agents or employees of our service providers. we will not sell or trade your information to unrelated third parties. When you submit an order you will receive an SMS confirmation form our system. As your order status changes you may also receive notifications via SMS. These notifications are considered part fo our service and may not be disabled. We may also periodically send you SMS notifications concerning products or services. Any such notification will include instructions for opting out of future mailings.Third Parties – We may partner with other third parties to provide various products and services. When you sign up for these services or products we will share required personal information that is necessary for the third party to provide the product or service to you. We take reasonable steps to ensure that these third parties are obligated to protect your information on our behalf. It is also against our policy to sell or trade information collected online without consumer consent. We may, however, release personal information if we are legally required to do so. If we are legally compelled to release information to a third party, our Bookstore, may or may not notify you of this release. Notification will be at the discretion of Study Evaluation and will be based on the nature and conditions surrounding the release of information.Information Control – your customer profile is accessible from our website, web view, android app and you may update it at any time. Our web site provided you with the ability to change your phone numbers, physical addresses, and email address information stored in your profile. You may also write to us at the address listed at the bottom of this policy to request that we make the change for you. Children – Study Evaluation website is targeted to college students, faculty and alumni and as such is not meant to attract children. We do not intend to collect personal information from anyone we know to be under thirteen years of age. If you are the parent or guardian of a child under thirteen years of age and believe that your child has disclosed personally identifiable information to us, please contact us so that we may remove the child’s information.Note that the cookies we use do not place any personally identifiable information on your computer.'),
            getCardBlue('Confidentiality and Security ',
                'Study Evaluation takes reasonable steps to ensure that your information is protected. On our website we use industry standard Secure Sockets Layer (SSL) encryption when collecting your personal information. Our website is hosted in a data center which makes use of multiple levels of redundant firewalls and database encryption to protect information. Internally, we limit access to your information to those employees or agents who we believe have reasonable need to use the information to provide products or services to you, or to perform their jobs.'),
            getCardWhite('Notifications',
                'This website, web view and android app may send you notifications via SMS in order to service your Study Evaluation account. These notifications are considered part of our service and may not be disabled. We will send the SMS but we cannot guarantee delivery. You are responsible for providing a valid Mobile no. and for updating it when your Mobile no. changes.'),
            getCardBlue('History',
                'A privacy policy was established for this website, web view and android app on Jan 01, 2023. We periodically make changes to the policy to reflect additions or changes to our practices. You may review the current policy at anytime by returning to this web page. This policy was last changed on Jan 01, 2023.'),
            getCardWhite('Study Evaluation Website Terms Of Use ',
                'Use of the Study Evaluation website (the “https://StudyEvaluation.com” &https://StudyEvaluation.org) and the content contained here in (the https://StudyEvaluation.com&StudyEvaluation.org”) is governed by the terms of this agreement (the “Agreement”) between you(User) and Study Evaluation (“Online Education Coaching”). Your use of this Site constitutes your unconditional agreement to be bound by the terms of this Agreement. If you do not agree with the terms and conditions of this Agreement, you must immediately cease using Website, Android App and Web view.\n\n1. The Website, Android App and Web view is subject to protection under copyrights, trademarks and/or other intellectual property rights owned, controlled and its affiliates or by third parties These rights are protected by common law, state laws, and India and international laws. Study Evaluation expressly reserves all rights, titles, and interests in and to all copyrights, trade names, logos, patents and other intellectual property and proprietary rights in and to the Site, including but not limited to any images, photographs, animations, video, audio, music, text, the overall "look and feel" processes, software, technology, and other materials which appear on this Site, and the business processes used to market products and services. You agree that your rights are limited to those granted herein, and you will not acquire any rights except as expressly set forth in this Agreement.\n\n2. You are prohibited from violating or attempting to violate the security of the Site, including, without limitation. (a) accessing data not intended for your use or logging onto a server or an account which you are not authorized to access; (b) attempting to probe, scan or test the vulnerability of a system or network or to breach security or authentication measures without proper authorization; (c) attempting to interfere with service to any user, host or network, including without limitation, via means of submitting a virus to the Site. overloading "flooding" "spamming" "mailbombing" or "crashing" or (d) sending unsolicited email, including promotions and/or advertising of products or services. Violations of system or network security may result in civil or criminal liability.\n3. The Site may contain robot exclusion headers. Much of the information on the Site is updated on a regular basis and is proprietary or is licensed to Study Evaluation by our suppliers and other third parties. You agree not to use any device, technique, software, system or routine to interfere or attempt to interfere with, or to otherwise circumvent the proper working of this Site or any activity being conducted on this Site. You agree, further, not to use or attempt to use any engine, device, technique, software, tool, agent or other device or mechanism (including without limitation browsers, spiders, robots, scrapers, avatars or intelligent agents) to navigate, access or search this Site, other than enerally available third party web browsers such as Microsoft Internet Explorer". Google Chrome", and Mozilla Firefox Additionally, you agree that you will not take any action that imposes or may impose (in the sole discretion of us or our suppliers affected by your action) an unreasonable or disproportionately large load on our infrastructure, or the bandwidth or infrastructure of the company that hosts this Site, or bypass the robot exclusion headers or other measures on this Site or on the host servers that may be used to prevent or restrict access. \n\n4 Study Evaluation will not be liable for damages resulting from any failure caused by events beyond its control, by any act of God, such as a power failure, or by any other cause not within the control of Study Evaluation.\n\n5. if you violate any of the terms or conditions of this Agreement, this Agreement terminates immediately without notice. Study Evaluation may deny access to the Site to you and anyone claiming by or through you without liability to anyone. Study Evaluation shall have all additional rights and remedies at law and in equity arising from such violation Further, you agree to indemnify, defend and hold Study Evaluation, and its affiliates, suppliers, employees and agents harmless from all claims, actions, losses, liabilities, damages, costs and expenses (including attorneys fees) arising out of or relating to any such prohibited use of the Site. If you violate or infringe upon the rights of any third party, they have all remedies at law and in equity to enforce their rights against you to the extent applicable arising from your actions.\n\n6. Any delay or failure to act with respect to a breachof this Agreement by you or others does not constitute a waiver and shall not limit such rights with respect to such breach or any subsequent breaches. This Agreement shall be governed by and construed in accordance with the laws of the State in which Bhatia Ashram, Suratgarh resides. If any provision of this Agreement is held to be invalid or unenforceable, such invalidity or unenforceable shall not affect the remainder of this Agreement, which shall be given full effect without regard to the invalid portions\n\n7. Test Series-\n\ni. Free Daily test will be conducted everyday and will have a sum of 20 questions\n\nii. Big tests will be conducted according to the dates of the schedules given to you.\n\n8. This Agreement represents the entire agreement between you and Study Evaluation regarding the use of the Site.\n\nThanks to use our Study Evaluation Website, Web View and Android App.\n\nCancellation/Refunds\n\nStudy Evaluation is a Elearning Platform where as we provide online platform for Government Job preparation.\n\nWe provide guidance for IAS, RAS, College lecturer, First Grade Teacher, Second Grade Teacher, Patwar, REET, Rajasthan PSI and Constable etc.Our policy lasts 3 days. If 3 days have gone by since your purchase online Test Series, Online Course, Books, Notes etc.To be eligible for a Refund, your Reason must be clear condition why you want to Return.To complete your Refund, we require a receipt or proof of purchase.Cancellation/RefundsOnce your refund is received and inspected, we will send you an SMS to notify you that we have received your refund money. We will also notify you of the approval or rejection of your refund.If you are approved, then your refund will be processed, and a credit will automatically be applied to your credit card or original method of payment, within a certain amount of days.'),
            getCardBlue('Late or missing refunds',
                'If you haven’t received a refund yet, first check your bank account again.Then contact your credit card company, it may take some time before your refund is officially posted.Next contact your bank. There is often some processing time before a refund is posted.If you’ve done all of this and you still have not received your refund yet, please contact us at [Study Evaluation Contact :- +91 0987654321]'),
          ],
        ),
      ),
    );
  }
}

getCardWhite(String label, String text) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Card(
        margin: EdgeInsets.zero,
        color: Colors.white,
        child: ListTile(
          title: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(label,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black),
                textAlign: TextAlign.center),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text(text,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  // fontFamily: 'Montserrat'
                ),
                textAlign: TextAlign.justify),
          ),
        ),
      ),
    ],
  );
}

getCardGrey(String label, String text) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Card(
        margin: EdgeInsets.zero,
        color: Color.fromARGB(255, 245, 245, 245),
        child: ListTile(
          title: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(label,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black),
                textAlign: TextAlign.center),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text(text,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  //  fontFamily: 'Montserrat'
                ),
                textAlign: TextAlign.justify),
          ),
        ),
      ),
    ],
  );
}

getCardBlue(String label, String text) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Card(
        margin: EdgeInsets.zero,
        color: Colors.blue,
        child: ListTile(
          title: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(label,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white),
                textAlign: TextAlign.center),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text(text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  //   fontFamily: 'Montserrat'
                ),
                textAlign: TextAlign.justify),
          ),
        ),
      ),
    ],
  );
}
