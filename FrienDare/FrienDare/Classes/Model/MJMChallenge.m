//
//  MJMChallenge.m
//  FrienDare
//
//  Created by Michal Smialko on 1/25/14.
//
//

#import "MJMChallenge.h"
#import "MJMCoreDataManager.h"

@implementation MJMChallenge

@dynamic objID;
@dynamic title;
@dynamic prizeAmount;
@dynamic duration;
@dynamic challengeDescription;
@dynamic videoPath;

+ (instancetype)createOrUpdate:(NSDictionary *)info
{
    NSString *objectID = info[@"objID"];
    NSAssert(objectID, @"You must pass objectID");
    
    NSString *title = info[@"title"];
    NSAssert(title, @"You must pass title");
    
    NSNumber *prizeAmount = info[@"prizeAmount"];
    NSAssert(prizeAmount, @"You must pass prizeAmounts");
    
    NSNumber *duration = info[@"duration"];
    NSAssert(duration, @"You must pass duration");
    
    NSString *challengeDescription = info[@"challengeDescription"];
    NSAssert(challengeDescription, @"You must pass challengeDescription");
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"MJMChallenge"];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"objID = %@", objectID];
    NSManagedObjectContext *context = [[MJMCoreDataManager sharedInstance] mainManagedObjectContext];
    
    NSArray *results = [context executeFetchRequest:fetchRequest error:nil];
    
    MJMChallenge *object;
    if ([results firstObject]) {
        // Object already exists
        object = results[0];
    }
    else {
        // Create new
        object = [[self alloc] initWithEntity:[NSEntityDescription entityForName:NSStringFromClass([self class])
                                                          inManagedObjectContext:context]
                  insertIntoManagedObjectContext:context];

        object.objID = objectID;
        object.title = title;
        object.prizeAmount = prizeAmount;
        object.duration = duration;
        object.challengeDescription = challengeDescription;
    }

    return object;
}

@end
