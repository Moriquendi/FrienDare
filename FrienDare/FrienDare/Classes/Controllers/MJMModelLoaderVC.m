//
//  MJMModelLoaderVC.m
//  FrienDare
//
//  Created by Michal Smialko on 1/25/14.
//
//

#import "MJMModelLoaderVC.h"
#import "MJMCoreDataManager.h"

@interface MJMModelLoaderVC ()

@end

@implementation MJMModelLoaderVC

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    [[MJMCoreDataManager sharedInstance] initModelWithCompletionHandler:^{
        [self performSegueWithIdentifier:@"showFirstVC"
                                  sender:self];
    }];
}

@end
