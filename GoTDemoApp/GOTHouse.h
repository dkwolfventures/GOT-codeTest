//
//  GOTHouse.h
//  GoTDemoApp
//
//  Created by Matthew Ledwon on 8/21/18.
//  Copyright © 2018 Vaporstream. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GOTCharacter.h"

@interface GOTHouse : NSObject

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *words;
@property (nonatomic, retain) NSString *currentLord;

- (instancetype)initWithDict:(NSDictionary *)inputDict;

@end
