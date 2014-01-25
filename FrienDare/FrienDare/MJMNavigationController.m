//
//  MJMNavigationController.m
//  FrienDare
//
//  Created by Maciej Lobodzinski on 25/01/14.
//
//

#import "MJMNavigationController.h"

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
    
    [self.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationBar.shadowImage = [UIImage new];
    self.navigationBar.translucent = YES;
    self.navigationBar.backgroundColor = [UIColor colorWithRed:28./255.
                                                         green:36./255.
                                                          blue:43./255.
                                                         alpha:1.];
    
    self.navigationBar.tintColor = [UIColor lightGrayColor];

	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
