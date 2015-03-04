//
//  FTTabBarViewController.h
//  FuzzTest
//
//  Created by Ravi Vooda on 3/4/15.
//  Copyright (c) 2015 Ravi Vooda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FTTabBarViewController : UITabBarController

@property (strong, nonatomic) NSArray *allObjects;

@end

@protocol dataSetChangedListner <NSObject>

-(void) reloadWithData:(NSArray*) objects;

@end
