enum PostType {
  news,
  ads,
  all,
}

extension PostTypeValue on PostType {
  String get value {
    switch (this) {
      case PostType.news:
        return newsCategoryId.toString();
      case PostType.ads:
        return adsCategoryId.toString();
        break;
      default:
        return '$newsCategoryId,$adsCategoryId';
        break;
    }
  }
}

const int adsCategoryId = 158;
const int newsCategoryId = 92;

const String appName = 'UOK COIS';
const String appVersion = 'اصدار: 1.0 تجريبي';
const String downloadAppLink = 'https://cois.uokerbala.edu.iq/wp/uok-cois-app';
