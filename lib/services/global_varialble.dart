// ignore_for_file: public_member_api_docs, sort_constructors_first
class GlobalVarialble {
  bool isActiveManual1 = false;
  GlobalVarialble();

  setIsActive(bool isActive) {
    isActiveManual1 = isActive;
  }

  getIsActive() {
    return isActiveManual1;
  }
}
