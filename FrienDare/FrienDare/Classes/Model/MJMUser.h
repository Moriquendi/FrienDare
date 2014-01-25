//
//  MJMUser.h
//  FrienDare
//
//  Created by Michal Smialko on 1/25/14.
//
//

#import <Foundation/Foundation.h>

@interface MJMUser : NSObject

@property (nonatomic, strong) NSNumber *ID;

+ (instancetype)currentUser;

@end
