//
//  GOTCharacter.h
//  GoTDemoApp
//
//  Created by Matthew Ledwon on 8/21/18.
//  Copyright © 2018 Vaporstream. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GOTCharacter : NSObject

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSArray *titles;

- (instancetype)initWithDict:(NSDictionary *)inputDict;

@end
