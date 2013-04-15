Mashery Network API Demo App for Coca-Cola Enterprises API
==================================================================
Created lovingly for the developer community by Mashery.

http://www.mashery.com

http://developer.mashery.com


SYNOPSIS
==================================================================
This native iOS demo application was built to demonstrate how to
integrate the [CCE Location API](http://developer.cokecce.com) (to find customers by location)
and StackMob (to persist data in the cloud).

This is a simple app that utilizes several native frameworks, a
couple of external libraries, and a single Storyboard view 
controller scene.

The interface contains a UISearchBar and Map View. During runtime,
the end-user supplies an address or a city and country
(e.g. London, England) and clicks Search. An API
call is made to api.cokecce.com, searching for customers within a
radius of the supplied location. The JSON results are parsed, with
each customer location pinned to the map view. Additionally, the
customer location data is persisted in the cloud using [StackMob](http://stackmob.com)
when the end-user adds the customer location as a favorite.


REQUIREMENTS
==================================================================
1. Xcode (created on 4.5.2) - https://developer.apple.com/xcode/
2. CCE Search API Key - http://developer.cokecce.com
3. StackMob Public Key - http://www.stackmob.com


GETTING STARTED
==================================================================
1. Download and install Xcode (Mac required)
2. Unpack this Git repo into a clean directory
3. Open the project in Xcode
4. After the project is opened, open the file "Constants.h" and plug in values for the constants CCEAPIKEY and STACKMOBPUBLICKEY with your own key values
5. Build and run the project in the iPhone emulator

NOTES
==================================================================
Coca-Cola Enterprises is one of the world's largest Coca-Cola 
bottlers operating in Belgium, Great Britain, France, Luxembourg,
Monaco, the Netherlands, Norway, and Sweden. The locations
returned in the Locations API are restricted to customers
located in these countries. Good sample search queries to use are:

1. London, England
2. Brussels, Belgium 


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
