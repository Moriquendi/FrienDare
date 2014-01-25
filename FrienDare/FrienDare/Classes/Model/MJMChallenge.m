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
@dynamic challengeDescription;

+ (instancetype)createOrUpdate:(NSDictionary *)info
{
    NSNumber *objectID = info[@"objID"];
    NSAssert(objectID, @"You must pass objectID");
    
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
    }

    return object;
}

@end
