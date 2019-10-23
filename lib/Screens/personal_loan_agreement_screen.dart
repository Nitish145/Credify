import 'package:flutter/material.dart';

class PersonalLoanAgreementScreen extends StatefulWidget {
  @override
  _PersonalLoanAgreementScreenState createState() =>
      _PersonalLoanAgreementScreenState();
}

class _PersonalLoanAgreementScreenState
    extends State<PersonalLoanAgreementScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 120),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Text(
                      "Reprehenderit exercitation duis officia minim est eiusmod dolor ex laboris sint. Ut et laborum exercitation Lorem. Aliqua nulla minim irure aliquip adipisicing in. Exercitation ex cillum deserunt fugiat cupidatat minim qui eiusmod. Exercitation sunt est esse laboris proident amet cillum laborum. Deserunt nulla tempor aliquip consequat magna. Minim aliqua culpa qui enim irure quis cupidatat cillum sunt fugiat magna. Deserunt dolore exercitation laboris do ad aliquip nisi nostrud nostrud nisi est minim. Quis cillum incididunt eiusmod est exercitation ea esse ad. Ex fugiat elit minim ex deserunt adipisicing proident dolor. Tempor Lorem qui deserunt eiusmod laboris in non duis occaecat eiusmod do. Aliquip voluptate quis Lorem cupidatat. Duis enim cupidatat ullamco nostrud aliquip incididunt tempor enim aliquip veniam tempor et. Aliqua adipisicing sint incididunt commodo non ea esse amet aliquip proident anim eiusmod nulla dolor. Elit laborum aute velit veniam ullamco quis sint ut cupidatat. Nostrud reprehenderit culpa proident aute est. Reprehenderit",
                      style: Theme.of(context).accentTextTheme.display4,
                    ),
                  ),
                  RaisedButton(
                    elevation: 5.0,
                    color: Color.fromRGBO(242, 153, 74, 1),
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(5)),
                    child: Padding(
                      padding:
                          const EdgeInsets.fromLTRB(60.0, 15.0, 60.0, 15.0),
                      child: new Text('I Agree',
                          style: new TextStyle(
                              fontSize: 18.0, color: Colors.white)),
                    ),
                    onPressed: () async {},
                  )
                ],
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Loan Agreement",
                              style:
                                  Theme.of(context).primaryTextTheme.display2,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
