//
//  GOTCharacter.m
//  GoTDemoApp
//
//  Created by Matthew Ledwon on 8/21/18.
//  Copyright © 2018 Vaporstream. All rights reserved.
//

#import "GOTCharacter.h"

@implementation GOTCharacter

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.name = @"";
        self.titles = @[];
    }
    return self;
}

- (instancetype)initWithDict:(NSDictionary *)inputDict {
    self = [super init];

    if (self) {
        if (inputDict[@"name"]) {
            self.name = inputDict[@"name"];
        }

        if (inputDict[@"titles"]) {
            self.titles = inputDict[@"titles"];
        }
    }
    return self;
}

@end
