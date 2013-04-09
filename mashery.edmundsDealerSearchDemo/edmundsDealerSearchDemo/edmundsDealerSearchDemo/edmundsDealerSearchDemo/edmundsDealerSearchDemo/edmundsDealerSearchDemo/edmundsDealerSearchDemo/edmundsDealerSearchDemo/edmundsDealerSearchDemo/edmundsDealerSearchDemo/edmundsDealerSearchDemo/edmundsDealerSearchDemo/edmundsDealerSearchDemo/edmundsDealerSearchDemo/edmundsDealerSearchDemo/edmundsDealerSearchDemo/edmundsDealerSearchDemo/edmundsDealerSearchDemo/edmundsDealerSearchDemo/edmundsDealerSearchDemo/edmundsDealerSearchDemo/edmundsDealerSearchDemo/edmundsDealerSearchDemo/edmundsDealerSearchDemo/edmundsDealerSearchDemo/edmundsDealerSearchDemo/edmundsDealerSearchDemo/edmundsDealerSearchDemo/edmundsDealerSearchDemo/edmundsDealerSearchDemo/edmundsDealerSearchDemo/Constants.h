//
//  Constants.h
//  activeSearchDemo
//
//  Created by Neil Mansilla on 11/12/12.
//  Copyright (c) 2012 Mashery. All rights reserved.
//

#ifndef activeSearchDemo_Constants_h
#define activeSearchDemo_Constants_h

// API constants
// Active.com API - http://developer.active.com
// r={range in miles} num={# results}  f={filter}
#define ACTIVEURI @"http://api.amp.active.com/search/?v=json&r=25&f=activities&s=relevance&num=10&page=1"
#define ACTIVEAPIKEY @"g62xtyzw7vhp22vt2pbrjfdv"

#define EDMUNDSURI @"http://api.edmunds.com/v1/api/dealer?radius=3&fmt=json"
#define EDMUNDSAPIKEY @"56kufga2sjvmgkpmhuf3x7bp"

// StackMob API - http://stackmob.com
#define STACKMOBPUBLICKEY @"48197b3a-6d49-4930-b4ad-7b632909d309"

#define kScreenWidth [[UIScreen mainScreen] applicationFrame].size.width
#define kScreenHeight [[UIScreen mainScreen] applicationFrame].size.height

// Autosize constants
#define MINIMUM_ZOOM_ARC 0.0035 //approximately 0.25 miles (1 degree of arc ~= 69 miles)
#define ANNOTATION_REGION_PAD_FACTOR 1.15
#define MAX_DEGREES_ARC 360

#endif
