//
//  MJMNavigationController.m
//  FrienDare
//
//  Created by Maciej Lobodzinski on 25/01/14.
//
//

#import "MJMNavigationController.h"
#import "MJMStyleSheet.h"

@interface MJMNavigationController ()

@end

@implementation MJMNavigationController

- (id)init
{
    if (self = [super init]) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:28./255.
                                            green:36./255.
                                             blue:43./255.
                                            alpha:1.]];

    self.navigationBar.translucent = YES;
    self.navigationBar.tintColor = [UIColor colorWithWhite:190./255. alpha:1.];
    
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
