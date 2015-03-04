//
//  FTTextTableViewCell.m
//  FuzzTest
//
//  Created by Ravi Vooda on 3/4/15.
//  Copyright (c) 2015 Ravi Vooda. All rights reserved.
//

#import "FTTextTableViewCell.h"

@implementation FTTextTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    [self.textLabel setNumberOfLines:0];
    [self.textLabel setLineBreakMode:NSLineBreakByWordWrapping];
    
    [self.textLabel setFont:[UIFont systemFontOfSize:[UIFont systemFontSize]]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) setItem:(FTObject *)item {
    _item = item;
    [self.textLabel setText:item.data];
    
    if (!item.data || [item.data isEqualToString:@""]) {
        [self.textLabel setText:@"Empty text"];
    }
}

@end
