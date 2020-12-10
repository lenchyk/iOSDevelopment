# iOSDevelopment
Starting iOS Development with creating this app

I am using tab bar controller with 2 tabs: **MoviesList** and **Gallery**

1) There is TableView in the first tab, which consists of cells (different movies). 
To get the data for each cell I am using function for reading data from local files.
If you tap on a movie cell - you can get additional info about this movie (new ViewController creation)
Also you can add you own movie to the collection of existing ones. Plus there is searching bar if you grag the whole table down. 
Searching is using just Title attribute of the movie.

2) About the second tab... It is UICollectionView where you can add photos from iphone gallery. 
Special layout is added (using new Custom Compositional Layout), therefore photos will have different sizes and position places.
