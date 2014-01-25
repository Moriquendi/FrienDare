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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.navigationBar.backgroundColor = [UIColor colorWithRed:28./255.
                                                             green:36./255.
                                                              blue:43./255.
                                                             alpha:1.];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
