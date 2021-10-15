//
//  HouseTableViewCell.m
//  GoTDemoApp
//
//  Created by Matthew Ledwon on 8/22/18.
//  Copyright © 2018 Vaporstream. All rights reserved.
//

#import "HouseTableViewCell.h"

@interface HouseTableViewCell ()

@property (nonatomic, retain) IBOutlet UILabel *houseName;
@property (nonatomic, retain) IBOutlet UILabel *houseWords;

@end

@implementation HouseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

    self.houseName.text = self.house.name;
    self.houseWords.text = self.house.words;
}

- (void)drawCell {
    self.houseName.text = self.house.name;
    self.houseWords.text = self.house.words;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)prepareForReuse {
    [super prepareForReuse];

    self.house = nil;

    self.houseName.text = @"";
    self.houseWords.text = @"";
}

@end
