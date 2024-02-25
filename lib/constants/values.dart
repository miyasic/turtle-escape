const issureId = '3388000000022312255';
const imageUrl = 'https://picsum.photos/600/200';
const siteUrl = 'https://www.unicef.or.jp/kodomo/sdgs/17goals/14-sea/';
const className = 'codelab_class2';

const subHeader = '🌏地球を守ろう！';

const thresholdB = 5;
const thresholdA = 10;

const headerC = '🌊海に出たプラスチックが海洋生物🐬を苦しめているよ。';
const headerB = '🌊海洋プラスチックは年間800万トンとも言われているよ。😵‍💫';
const headerA = '💪まずはできることから始めよう。♻️';

const imageUrlC =
    'https://fastly.picsum.photos/id/187/600/200.jpg?hmac=5aQBl6z0Z9YzxBHYLumsMfRYbT0Ab9WTDZA6fbHLIc4';
const imageUrlB =
    'https://fastly.picsum.photos/id/973/600/200.jpg?hmac=ywarOimYsWmbBq4HZPR_ymF8ZmL_zW-taSjiU3VcTcc';
const imageUrlA =
    'https://fastly.picsum.photos/id/916/600/200.jpg?hmac=Exv25WeLqenCN92BRQxhVWp4o5Seyaojtd2EuQWflKo';

const colorC = '#607B8B';
const colorB = '#4682B4';
const colorA = '#1E90F0';

enum ScoreClass {
  a,
  b,
  c;

  // intからenumへの変換
  static ScoreClass fromInt(int value) {
    if (value > thresholdA) {
      return ScoreClass.a;
    }
    if (value > thresholdB) {
      return ScoreClass.b;
    }
    return ScoreClass.c;
  }
}
