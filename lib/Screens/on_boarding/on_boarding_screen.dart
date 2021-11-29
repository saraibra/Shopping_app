import 'package:flutter/material.dart';
import 'package:shopping_app/Models/boarding_model.dart';
import 'package:shopping_app/Screens/login/login.dart';
import 'package:shopping_app/shared/componnents/components.dart';
import 'package:shopping_app/shared/network/cashe_helper.dart';
import 'package:shopping_app/shared/style/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  bool isLast = false;
  PageController boardControler = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
        image: 'assets/images/onboarding1.png',
        title: 'On Board 1 Title',
        body: 'On Board 1 Body'),
    BoardingModel(
        image: 'assets/images/onboarding2.png',
        title: 'On Board 2 Title',
        body: 'On Board 2 Body'),
    BoardingModel(
        image: 'assets/images/onboarding1.png',
        title: 'On Board 3 Title',
        body: 'On Board 3 Body'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(
              function: () {
submit();
              },
              text: 'Skip')
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                onPageChanged: (index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                itemBuilder: (context, index) =>
                    buildOnBoardingItem(boarding[index],context),
                itemCount: boarding.length,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                    controller: boardControler,
                    effect: ExpandingDotsEffect(
                        dotColor: Colors.grey,
                        dotHeight: 10,
                        dotWidth: 10,
                        spacing: 5,
                        expansionFactor: 4,
                        activeDotColor: defaultColor),
                    count: boarding.length),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      submit();
                    } else {
                      boardControler.nextPage(
                          duration: Duration(milliseconds: 750),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                  child: Icon(Icons.arrow_forward_ios),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void submit() {
    CasheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if (value) {
        navigateAndFinish(context, LoginScreen());
      }
    });
  }

  Widget buildOnBoardingItem(BoardingModel model,context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height*0.4,
            child: Image(image: AssetImage('${model.image}'))),
          SizedBox(
            height: 32,
          ),
          Text(
            '${model.title}',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 32,
          ),
          Text(
            '${model.body}',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 32,
          ),
        ],
      );
}
