//
//  HouseTableViewCell.h
//  GoTDemoApp
//
//  Created by Matthew Ledwon on 8/22/18.
//  Copyright © 2018 Vaporstream. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GOTHouse.h"

@interface HouseTableViewCell : UITableViewCell

@property (nonatomic, retain) GOTHouse *house;

- (void)drawCell;

@end
