//
//  MJMChallenge.h
//  FrienDare
//
//  Created by Michal Smialko on 1/25/14.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface MJMChallenge : NSManagedObject

+ (instancetype)createOrUpdate:(NSDictionary *)info;

@property (nonatomic, retain) NSNumber *objID;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *challengeDescription;

@end
