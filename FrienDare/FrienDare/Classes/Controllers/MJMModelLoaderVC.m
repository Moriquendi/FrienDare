//
//  MJMModelLoaderVC.m
//  FrienDare
//
//  Created by Michal Smialko on 1/25/14.
//
//

#import "MJMModelLoaderVC.h"
#import "MJMCoreDataManager.h"
#import <Firebase/Firebase.h>

@interface MJMModelLoaderVC ()

@end

@implementation MJMModelLoaderVC

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    [[MJMCoreDataManager sharedInstance] initModelWithCompletionHandler:^{
       
        Firebase* f = [[Firebase alloc] initWithUrl:@"https://friendare.firebaseio.com/dares"];
        //    Firebase* daresRef = [f childByAppendingPath:title];

        
        [f observeEventType:FEventTypeChildAdded withBlock:^(FDataSnapshot *snapshot) {
            NSDictionary* msgData = snapshot.value;
            NSLog(@"%@ says %@", msgData[@"user_id"], msgData[@"text"]);
        }];
        
        
        //MJMChallenge *challenge = [MJMChallenge createOrUpdate:@{@"objID": @5}];
        
        
        [self performSegueWithIdentifier:@"showFirstVC"
                                  sender:self];
    }];
}

@end
