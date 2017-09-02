# Congress-Lookup-Website-And-App
Website and iOS App which provide detailed lookup of people and work of Congress

## Notes
Due to the closure of Sunlight Labs, [Sunlight foundation](https://sunlightfoundation.com/api/) no longer provides API service, which is taken over to other organizations. And because of I haven't been maintaining the web and app since January 2017, the information is not shown up now in the web and app.

Since January 2017, the website is simply serviced by University of Southern California host service, which is free instead of using AWS.

## Website

![Homepage](http://i.imgur.com/S1paRWt.png) 
![Details](https://i.imgur.com/WiMsEsw.png)

## iOS App 
Dynamic activity indicator | Homepage | Search | Details | Menu
--- | --- | ---
![Homepage of App](https://i.imgur.com/SWgrA9t.png) | ![Search](https://i.imgur.com/jUnxu3I.png) | ![Details](https://i.imgur.com/qjxpizj.png) | ![Menu](https://i.imgur.com/MR32645.png) | ![Dynamic activity indicator](https://i.imgur.com/SE1Haa3.png)




### Installation
After clone to your local directory,
1. open terminal and cd into project home directory
2. if cocopods not installed, use command 'sudo gem install cocoapods'
3. type in 'pod install' to install following dependencies according to the Podfile:
	* Alamofire (4.2)
	* AlamofireImage (3.2)
	* SlideMenuControllerSwift (3.0)
	* SwiftSpinner (1.1)
	* SwiftyJSON
4. 'open Congress2.xcworkspace' through terminal and run the project
