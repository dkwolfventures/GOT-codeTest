//
//  GOTHouse.m
//  GoTDemoApp
//
//  Created by Matthew Ledwon on 8/21/18.
//  Copyright © 2018 Vaporstream. All rights reserved.
//

#import "GOTHouse.h"

@implementation GOTHouse

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.name = @"";
        self.words = @"";
        self.currentLord = @"";
    }
    return self;
}

- (instancetype)initWithDict:(NSDictionary *)inputDict {
    self = [super init];

    if (self) {
        if (inputDict[@"name"]) {
            self.name = inputDict[@"name"];
        }

        if (inputDict[@"words"]) {
            self.words = inputDict[@"words"];
        }

        if (inputDict[@"currentLord"]) {
            self.currentLord = inputDict[@"currentLord"];
        }
    }
    return self;
}

@end
