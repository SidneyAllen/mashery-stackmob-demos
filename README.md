Mashery Network API iOS + StackMob Demo Apps
==================================================================
Created lovingly for the developer community by Mashery.

http://www.mashery.com

http://developer.mashery.com


SYNOPSIS
==================================================================
This set of demo applications were built to demonstrate how to 
integrate various Mashery Network APIs in the native Objective-C
iOS environment, along with the StackMob backend as a service
(BaaS).

These are simple single page apps that utilizes several native
frameworks, a couple of external libraries, and a single Storyboard
view controller scene.

The demo apps utilize several interface components such as the
UISearchBar and Map View. During runtime, the end-user action will
instantiate an API call (e.g. Active.com Search API). The JSON
results are parsed, processed (e.g. pinned to the map), and then
persisted in the cloud using [StackMob](http://stackmob.com).


REQUIREMENTS
==================================================================
1. Xcode (created on 4.5.2) - https://developer.apple.com/xcode/
2. StackMob Public Key - http://www.stackmob.com
3. API Key from the corresponding Mashery customer platform  (see the README.md at the directory level of each sample app)


GETTING STARTED
==================================================================
1. Download and install Xcode (Mac required)
2. Unpack this Git repo into a clean directory
3. Open the project in Xcode
4. After the project is opened, open the file "Constants.h" and plug in values for the constants MASHERYAPIKEY and STACKMOBPUBLICKEY with your own key values (MASHERYAPIKEY constant name may vary from platform to platform -- e.g. ACTIVEAPIKEY, EDMUNDSAPIKEY, etc.)
5. Build and run the project in the iPhone emulator


ABOUT THE MASHERY API NETWORK
==================================================================
Mashery is the world's leading API management service provider, 
helping companies provide the best API experience for developers,
as well as the most advanced API management and reporting tools 
to our clients. The Mashery API Network (http://developer.mashery.com)
s an open data commons of over 50 RESTful APIs that developers can 
access with their Mashery ID.


EXPLORE MORE APIs
==================================================================
Check out Mashery's API Network at http://developer.mashery.com/apis
to explore other awesome APIs including NY Times, Klout, USA TODAY,
Rotten Tomatoes, Best Buy, Hoovers, Edmunds, Netflix, Rdio and many more. 


SUPPORT
=======
If you have any questions or need any help obtaining an API key, you can reach out to us at: developer-relations@mashery.com
