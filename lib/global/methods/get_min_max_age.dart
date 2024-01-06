class Age{
  int minAge;
  int maxAge;
  Age({required this.maxAge, required this.minAge});
}

Age getMinMaxAgeFromIndex(int index) {
  switch(index) {
    case 0: return Age(minAge: 0, maxAge: 0);
    case 1: return Age(minAge: 18, maxAge: 30);
    case 2: return Age(minAge: 30, maxAge: 40);
    case 3: return Age(minAge: 40, maxAge: 50);
    case 4: return Age(minAge: 50, maxAge: 60);
    case 5: return Age(minAge: 60, maxAge: 70);
    case 6: return Age(minAge: 70, maxAge: 80);
    case 7: return Age(minAge: 80, maxAge: 90);
    case 8: return Age(minAge: 90, maxAge: 100);
  }
  return Age(minAge: -1, maxAge: -1);
}