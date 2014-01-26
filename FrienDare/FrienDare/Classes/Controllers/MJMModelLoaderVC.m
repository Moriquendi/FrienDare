//
//  MJMModelLoaderVC.m
//  FrienDare
//
//  Created by Michal Smialko on 1/25/14.
//
//


#import "MJMModelLoaderVC.h"
#import "MJMCoreDataManager.h"
#import "MJMChallenge.h"
#import <Firebase/Firebase.h>

#import "MJMStyleSheet.h"

@interface MJMModelLoaderVC ()

@end

@implementation MJMModelLoaderVC

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    [MJMStyleSheet sharedInstance]; // just configure appearance proxies
    
    [[MJMCoreDataManager sharedInstance] initModelWithCompletionHandler:^{
       
        Firebase* f = [[Firebase alloc] initWithUrl:@"https://friendare.firebaseio.com/dares/"];
        
        [f observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
            
            //NSLog(@"%@ -> %@", snapshot.name, snapshot.value);
            
            NSDictionary *dares = snapshot.value;
            
            //NSLog(dares);
            for(id dare in dares){
                //NSLog((NSString *) dare);
            MJMChallenge *challenge = [MJMChallenge createOrUpdate:@{@"objID": (NSString *) dare,
                                                                     @"title": [dares objectForKey:dare][@"title"],
                                                                     @"prizeAmount": [dares objectForKey:dare][@"prizeAmount"],
                                                                     @"duration": [dares objectForKey:dare][@"duration"],
                                                                     @"challengeDescription": [dares objectForKey:dare][@"challengeDescription"]
                                                                     }];
                
            }
        }];
        
        [self performSegueWithIdentifier:@"showFirstVC"
                                  sender:self];
    }];
}

@end
