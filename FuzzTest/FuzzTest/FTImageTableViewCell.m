//
//  FTImageTableViewCell.m
//  FuzzTest
//
//  Created by Ravi Vooda on 3/4/15.
//  Copyright (c) 2015 Ravi Vooda. All rights reserved.
//

#import "FTImageTableViewCell.h"
#import "FTImageView.h"

@interface FTImageTableViewCell ()

@property (weak, nonatomic) IBOutlet FTImageView *cellImageView;

@end

@implementation FTImageTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) setItem:(FTObject *)item {
    _item = item;
    [_cellImageView setFrame:self.frame];
    [_cellImageView setUrl:item.data];
}

@end
