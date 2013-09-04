//
//  Constants.h
//  edmundsDealerSearchDemo
//
//  Created by Neil Mansilla on 3/31/13.
//  Copyright (c) 2013 Mashery. All rights reserved.
//

#ifndef edmundsDealerSearchDemo_Constants_h
#define edmundsDealerSearchDemo_Constants_h

// API constants
// Edmunds.com Dealer API - http://developer.edmunds.com
#define EDMUNDSURI @"http://api.edmunds.com/v1/api/dealer?radius=3&fmt=json"
#define EDMUNDSAPIKEY @"u3fh5a66n9t7xjmv7ec8ek5u"

// StackMob API - http://stackmob.com
#define STACKMOBPUBLICKEY @"df72827d-fee6-4640-a9ee-06eb532ac318"

#define kScreenWidth [[UIScreen mainScreen] applicationFrame].size.width
#define kScreenHeight [[UIScreen mainScreen] applicationFrame].size.height

// Autosize constants
#define MINIMUM_ZOOM_ARC 0.0035 //approximately 0.25 miles (1 degree of arc ~= 69 miles)
#define ANNOTATION_REGION_PAD_FACTOR 1.15
#define MAX_DEGREES_ARC 360

#endif
