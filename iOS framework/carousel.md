
# carousel
* 수직 또는 수평으로 스크롤 가능한 뷰를 만들고자 한다.
* 외국에서는 회전목마, carousel이라고들 부르나보다.
* 콜렉션뷰와 레이아웃 객체에 대해서 먼저 스터디한다.

## UICollectionView
### 정의
> An object that manages an ordered collection of data items and presents them using customizable layouts.

>> 정렬된 데이터아이템의 콜렉션을 관리하는 객체이고, 커스터마이징할 수 있는 레이아웃을 사용하여 나타낸다.

* UICollectionViewCell 을 이용하여 데이터 객체를 표시한다.
* UICollectionViewDataSource Protocol을 이용하여 콜렉션뷰와 데이터를 관리한다. 등등..

## Collection Views and Layout Objects
* CollectionView의 서브클래스로서, UICollectionViewLayout가 있다.
>A very important object associated with a collection view is the layout object, which is a subclass of the UICollectionViewLayout class. The layout object is responsible for defining the organization and location of all cells and supplementary views inside the collection view. Although it defines their locations, the layout object does not actually apply that information to the corresponding views. Because the creation of cells and supplementary views involves coordination between the collection view and your data source object, the collection view actually applies layout information to the views. Thus, in a sense, the layout object is like another data source, only providing visual information instead of item data.


* 이 레이아웃 오브젝트는 콜렉션뷰 내부에 있는 모든 셀과 뷰들의 위치나 등등을 관리한다.
...
* 외적인 것에 영향을 미치는 오브젝트...

---
### 참고사이트

[UICollectionView with Swift: Build Carousel Like Home Screen - iOS Development Tutorial Pt 1
](https://www.youtube.com/watch?v=vB-HKnhOgl8)

[Build Carousel Effect in iOS with Swift
](https://www.youtube.com/watch?v=XKXFRHctC6o)
