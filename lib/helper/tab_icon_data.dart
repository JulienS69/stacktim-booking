class TabIconData {
  String imagePath;
  String selectedImagePath;
  bool isSelected;
  int index;
  int currentIndex;

  TabIconData({
    this.imagePath = '',
    this.index = 0,
    this.selectedImagePath = '',
    this.isSelected = false,
    required this.currentIndex,
  });

  List<TabIconData> get tabIconsList {
    List<TabIconData> list = <TabIconData>[
      TabIconData(
        imagePath: 'assets/bottom/tab_1.png',
        selectedImagePath: 'assets/bottom/tab_1s.png',
        index: 0,
        currentIndex: currentIndex,
        isSelected: currentIndex == 0,
      ),
      TabIconData(
        imagePath: 'assets/bottom/tab_2.png',
        selectedImagePath: 'assets/bottom/tab_2s.png',
        index: 1,
        currentIndex: currentIndex,
        isSelected: currentIndex == 1,
      ),
      TabIconData(
        imagePath: 'assets/bottom/tab_3.png',
        selectedImagePath: 'assets/bottom/tab_3s.png',
        index: 2,
        currentIndex: currentIndex,
        isSelected: currentIndex == 2,
      ),
      TabIconData(
        imagePath: 'assets/bottom/tab_4.png',
        selectedImagePath: 'assets/bottom/tab_4s.png',
        index: 3,
        currentIndex: currentIndex,
        isSelected: currentIndex == 3,
      ),
    ];

    return list;
  }
}
