//
//  CustomSearchBar.m
//  activeSearchDemo
//
//  Created by Sidney Maestre on 2/13/13.
//  Copyright (c) 2013 Mashery. All rights reserved.
//

#import "CustomSearchBar.h"


@implementation CustomSearchBar

    //@synthesize delegate;
-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        

        //Set other button states (hightlight, select, etc) here
    }
    return self;
}



-(void)drawRect:(CGRect)rect {
    
    [[[self subviews] objectAtIndex:0] setAlpha:0.0];
  
    //UIImage *image = [UIImage imageNamed: @"nav_bar.png"];
    //[image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
}

@end
