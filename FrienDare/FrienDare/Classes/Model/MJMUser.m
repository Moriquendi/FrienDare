//
//  MJMUser.m
//  FrienDare
//
//  Created by Michal Smialko on 1/25/14.
//
//

#import "MJMUser.h"

@implementation MJMUser

+ (instancetype)currentUser
{
    static MJMUser *myUser;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        myUser = [[self alloc] init];
        myUser.ID = @(1);
    });
    
    return myUser;
}

@end
