//
//  CustomSearchBar.h
//  activeSearchDemo
//
//  Created by Sidney Maestre on 2/13/13.
//  Copyright (c) 2013 Mashery. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomSearchBarDelegate

-(void)customCancelButtonHit;

@end

@interface CustomSearchBar : UISearchBar {
    id<CustomSearchBarDelegate> delegate;
    UIButton *customBackButtom;
}
//@property (nonatomic, assign) id<CustomSearchBarDelegate> delegate;

-(void)cancelAction;
@end
