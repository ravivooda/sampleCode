//
//  FTBaseTableViewController.h
//  FuzzTest
//
//  Created by Ravi Vooda on 3/4/15.
//  Copyright (c) 2015 Ravi Vooda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FTTabBarViewController.h"

@interface FTBaseTableViewController : UITableViewController <dataSetChangedListner>

@property (strong, nonatomic) NSArray *itemsHolder;

@end
