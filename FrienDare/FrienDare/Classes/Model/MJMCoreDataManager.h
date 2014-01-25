//
//  MJMCoreDataManager.h
//  FrienDare
//
//  Created by Michal Smialko on 1/25/14.
//
//

#import <Foundation/Foundation.h>

@interface MJMCoreDataManager : NSObject

+ (instancetype)sharedInstance;

- (void)initModelWithCompletionHandler:(void (^)(void))completionHandler;

@end
