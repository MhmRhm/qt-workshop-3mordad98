# qt-workshop-3mordad98
Complete and empty projects of workshop

## Getting Started
Five different projects have been prepared for the class. The following explains each project outcome and prerequisite. 
I’m opinionated about the developing environment which is Linux. However some of these projects may run without any complication on windows or macOS.

## Prerequisites
For installing Qt in Linux you need no preinstalled software. In windows Qt comes with an included MinGW compiler and Visual Studio compilers are detected at installation too. For using VS compilers you also need Windows SDK. This SDK is possibly provided with VS2017 installation files. It must be downloaded for other VS installation files. Installation on Windows is quite straightforward.


## Projects
1. **BasicsComplete**
This project is developed in QML descriptive language. Here we get to know how to position different elements in a document and become familiar with some properties of `QML types`.

	>This project needs no dependencies and can be built in windows or macOS too.

2. **NewsReader**
This project is developed in QML descriptive language. Here we use NYTimes `RESTful API` to fetch Recent articles and show them. In addition articles can be saved and SQLite `database` connection and `Model-View` mechanism are explained.
	
	>This project can also be built in windows however it requires Visual Studio compilers for its web engine and also you need to install openssl on windows in order to connect to API.

3. **GFLocator/BadBF**
This project is developed in QML descriptive language and C++ for back-end. Here we use a map service (`GIS`) and `GPS` to show our current location on map. The C++ back-end code sends our location to some IP address over the Internet. The BadBF program receives this location and show on the map. Here our spying program runs on an Android device and our locator runs on raspberry pi. `Cross-compiling` and `networking` is explained in this project.

	>This project can also be built in windows with MinGW.

4. **MusicPlayer**
This project is developed in QML descriptive language and C++ for back-end. Here we access `file system` to add songs in a playlist and also we use a third party library to extract cover-arts from .mp3 files. This one is the biggest one since we need to `cross-compile` and include taglib for android and use `C++ Objects as QML types`. 
	
	>This project depends on taglib, which we compile for android and linux. Due to complications of building a third-party library under windows, successful compilation of this project is not guaranteed in non linux OSs.

5. **MultiTread**
This project is developed in C++. Here we take a deeper look into `multi-threading`, `signal-slot` mechanism and `Qt ecosystem`.
	
	>This project like the first one is pure Qt and can compile in all OSs.
