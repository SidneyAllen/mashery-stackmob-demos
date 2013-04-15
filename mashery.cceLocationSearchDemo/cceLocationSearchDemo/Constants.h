//
//  Constants.h
//  activeSearchDemo
//
//  Created by Neil Mansilla on 4/15/2013
//  Copyright (c) 2013 Mashery. All rights reserved.
//

#ifndef activeSearchDemo_Constants_h
#define activeSearchDemo_Constants_h

// API constants
// Coca-Cola Enterprises API - http://developer.cokecce.com
#define CCEURI @"http://api.cokecce.com/v1/location/search/?rangeKilometers=5.0&maxLocations=30&format=json"
#define CCEAPIKEY @"YOUR_CCE_LOCATION_API_KEY"

// StackMob API - http://stackmob.com
#define STACKMOBPUBLICKEY @"YOUR_STACKMOB_PUBLIC_DEVELOPMENT_API_KEY"

#define kScreenWidth [[UIScreen mainScreen] applicationFrame].size.width
#define kScreenHeight [[UIScreen mainScreen] applicationFrame].size.height

// Autosize constants
#define MINIMUM_ZOOM_ARC 0.0035 //approximately 0.25 miles (1 degree of arc ~= 69 miles)
#define ANNOTATION_REGION_PAD_FACTOR 1.15
#define MAX_DEGREES_ARC 360

#endif
