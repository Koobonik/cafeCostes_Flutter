
import 'package:costes/find_OR_change.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

void main() => runApp(Agree());
class Agree extends StatefulWidget{
  @override
  AgreeScreen createState() => new AgreeScreen();
}

class AgreeScreen extends State<Agree>{
  
  @override
  Widget build(BuildContext context) {  
    return MaterialApp(
      title: "회원 약관",
      theme: ThemeData(
        //primaryColor: Colors.brown,
        primaryColor: const Color.fromRGBO(238, 232, 198, 1.0),
      ),
      home: Scaffold(
          appBar: AppBar(
            title: Text('회원 약관'),
            centerTitle: true,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () { 
              print("회원 약관 뷰 나가기");
              Navigator.of(context).pop();
            },
          ), 
          ),
          body: new Container(
            margin: const EdgeInsets.only(left: 8.0, right: 8.0, top: 5, bottom: 30),
            child: ListView(
              children: <Widget>[
                new Column(
                children: <Widget>[
                  Text("이용 약관",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),),
                  Text("\n제 1조(목적)",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),),
                  Text("\n 본약관은 카페코스테스(이하 회사)가 제공하는 서비스 이용(이하 서비스)과 관련, 회원과 회사와의 중요 사항을 정하는 것을 목적으로 한다.",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),),
                  Text("\n제 2조(정의)",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),),
                  Text(""" (1)회원이란 회사와 서비스 이용계약을 체결(회원 가입)한 자를 뜻한다.
 (2) 회원 ID란 회원 식별 및 서비스 이용 등을 위해 이용자가 직접 설정, 입력하며 문자와 숫자로 이뤄진 조합을 뜻한다.
 (3) 패스워드란 회원 정보 보호 및 회원 별 정보 제공 서비스 등을 위해 이용자가 직접 설정, 입력하며 문자와 숫자로 이뤄진 조합을 뜻한다.
 (4) 운영자란 서비스의 전반적 관리 및 운영을 담당하는 회사의 직원을 뜻한다.""",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),),
                  Text("\n제 3조(회원가입 신청 및 허가)",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),),
                  Text("\n 회원가입은 회사가 제시하는 양식에 자기 정보를 입력, 신청하고 회사는 이를 허가함으로써 서비스를 제공한다.",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),),

                  Text("\n제 4조(회원가입 신청시 기재 항목)",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),),

                  Text("""회원가입 신청 시 다음 항목은 필수적으로 입력해야 한다.
 (1) 닉네임
 (2) 아이디/패스워드
 (3) e-mail 주소
 (4) 생년월일
 (5) 기타 회원의 권익 증진을 위해 회사가 제공할 필요가 있다고 판단되는 정보를 서비스하기 위해 필요한 항목""",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),),

                  Text("\n제 5조(서비스 이용에 대한 회원의 의무)",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),),

                  Text("""\n (1) 회원의 관리 소홀로 인한 ID 및 패스워드 노출과 이에 따른 피해는 전적으로 회원이 책임지도록 한다.
 (2) 회사에서 제공하는 서비스에 대한 회원의 이용권한은 회원 개인에 한정된 것이며, 제 3자에 양도나 대여할 경우 회사에서 임의로 해당 회원의 ID를 삭제할 수 있다. 특히 무단 양도나 대여에 대한 책임은 전적으로 회원이 책임지도록 한다.
 (3) 회원은 회사에서 제공하는 서비스를 이용할 때 다음 각 호를 해서는 안된다.
  1. 다른 사람의 e-mail address, ID를 무단 사용하는 행위
  2. 서비스 이용 중 습득한 정보를 상업적 목적으로 이용하거나 올린 이 또는 회사의 허가 없이 출판, 방송등 제 3자에게 노출시키는 행위
  3. 저작권 등 제 3자의 권리를 침해하는 게시 행위
  4. 회사의 사이트 운영을 방해하는 행위
  5. 사회 공공질서에 위배되거나 건전한 미풍양속을 저해하는 정보나 문자, 그림 등을 타인에게 유포하는 행위""",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),),

                  Text("\n제 6조 (환불 규정)",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),),


                   Text("""\n(1) 구매한 상품(음료)는 상품 제조 특성상 고객의 단순 변심에 의한 환불 및 구매취소가 되지 않는 것을 원칙으로 한다.
 (2) 상품에 오류가 있을 시 동일상품을 다시 제조하여 주는 것을 원칙으로 하며, 고객이 그럼에도 원하지 않을 시 회사에서 발급하는 바우처(쿠폰)으로 대체하는 것을 원칙으로 한다.""",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),),

                  Text("\n제 7조(바우처 사용)",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),),

                  Text("""\n(1) 코스테스에서 발급하는 바우처(음료쿠폰)는 코스테스 프로모션 내용에 따라 발급일정 및 구성이 상이하며, 자세한 내용은 때마다 올라오는 공지사항을 확인한다.""",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),),




                  ButtonTheme(
                    minWidth: double.infinity,
                    child: new RaisedButton(
                      child: Text("동의 합니다."),
                    color: const Color.fromRGBO(238, 232, 198, 1.0),
                    onPressed: () async {
                      Navigator.push(context,
                      MaterialPageRoute<void>(builder: (BuildContext context) {
                          return EmailAuth();
                      })
                    );
                    }
                  ),
                  )
                ],
            ),
              ],
            )
            
          )
        ),
    );
  }
  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity);
  }
}


class Agree2 extends StatefulWidget{
  @override
  AgreeScreen2 createState() => new AgreeScreen2();
}

class AgreeScreen2 extends State<Agree2>{
  
  @override
  Widget build(BuildContext context) {  
    return MaterialApp(
      title: "회원 약관",
      theme: ThemeData(
        //primaryColor: Colors.brown,
        primaryColor: const Color.fromRGBO(238, 232, 198, 1.0),
      ),
      home: Scaffold(
          appBar: AppBar(
            title: Text('회원 약관'),
            centerTitle: true,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () { 
              print("회원 약관 뷰 나가기");
              Navigator.of(context).pop();
            },
          ), 
          ),
          body: new Container(
            margin: const EdgeInsets.only(left: 8.0, right: 8.0, top: 5, bottom: 30),
            child: ListView(
              children: <Widget>[
                new Column(
                children: <Widget>[
                  Text("이용 약관",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),),
                  Text("\n제 1조(목적)",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),),
                  Text("\n 본약관은 카페코스테스(이하 회사)가 제공하는 서비스 이용(이하 서비스)과 관련, 회원과 회사와의 중요 사항을 정하는 것을 목적으로 한다.",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),),
                  Text("\n제 2조(정의)",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),),
                  Text(""" (1)회원이란 회사와 서비스 이용계약을 체결(회원 가입)한 자를 뜻한다.
 (2) 회원 ID란 회원 식별 및 서비스 이용 등을 위해 이용자가 직접 설정, 입력하며 문자와 숫자로 이뤄진 조합을 뜻한다.
 (3) 패스워드란 회원 정보 보호 및 회원 별 정보 제공 서비스 등을 위해 이용자가 직접 설정, 입력하며 문자와 숫자로 이뤄진 조합을 뜻한다.
 (4) 운영자란 서비스의 전반적 관리 및 운영을 담당하는 회사의 직원을 뜻한다.""",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),),
                  Text("\n제 3조(회원가입 신청 및 허가)",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),),
                  Text("\n 회원가입은 회사가 제시하는 양식에 자기 정보를 입력, 신청하고 회사는 이를 허가함으로써 서비스를 제공한다.",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),),

                  Text("\n제 4조(회원가입 신청시 기재 항목)",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),),

                  Text("""회원가입 신청 시 다음 항목은 필수적으로 입력해야 한다.
 (1) 닉네임
 (2) 아이디/패스워드
 (3) e-mail 주소
 (4) 생년월일
 (5) 기타 회원의 권익 증진을 위해 회사가 제공할 필요가 있다고 판단되는 정보를 서비스하기 위해 필요한 항목""",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),),

                  Text("\n제 5조(서비스 이용에 대한 회원의 의무)",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),),

                  Text("""\n (1) 회원의 관리 소홀로 인한 ID 및 패스워드 노출과 이에 따른 피해는 전적으로 회원이 책임지도록 한다.
 (2) 회사에서 제공하는 서비스에 대한 회원의 이용권한은 회원 개인에 한정된 것이며, 제 3자에 양도나 대여할 경우 회사에서 임의로 해당 회원의 ID를 삭제할 수 있다. 특히 무단 양도나 대여에 대한 책임은 전적으로 회원이 책임지도록 한다.
 (3) 회원은 회사에서 제공하는 서비스를 이용할 때 다음 각 호를 해서는 안된다.
  1. 다른 사람의 e-mail address, ID를 무단 사용하는 행위
  2. 서비스 이용 중 습득한 정보를 상업적 목적으로 이용하거나 올린 이 또는 회사의 허가 없이 출판, 방송등 제 3자에게 노출시키는 행위
  3. 저작권 등 제 3자의 권리를 침해하는 게시 행위
  4. 회사의 사이트 운영을 방해하는 행위
  5. 사회 공공질서에 위배되거나 건전한 미풍양속을 저해하는 정보나 문자, 그림 등을 타인에게 유포하는 행위""",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),),

                  Text("\n제 6조 (환불 규정)",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),),


                   Text("""\n(1) 구매한 상품(음료)는 상품 제조 특성상 고객의 단순 변심에 의한 환불 및 구매취소가 되지 않는 것을 원칙으로 한다.
 (2) 상품에 오류가 있을 시 동일상품을 다시 제조하여 주는 것을 원칙으로 하며, 고객이 그럼에도 원하지 않을 시 회사에서 발급하는 바우처(쿠폰)으로 대체하는 것을 원칙으로 한다.""",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),),

                  Text("\n제 7조(바우처 사용)",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),),

                  Text("""\n(1) 코스테스에서 발급하는 바우처(음료쿠폰)는 코스테스 프로모션 내용에 따라 발급일정 및 구성이 상이하며, 자세한 내용은 때마다 올라오는 공지사항을 확인한다.""",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),),
                ],
            ),
              ],
            )
            
          )
        ),
    );
  }
  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity);
  }
}