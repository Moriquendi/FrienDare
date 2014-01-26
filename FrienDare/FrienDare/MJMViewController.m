//
//  MJMViewController.m
//  FrienDare
//
//  Created by Michal Smialko on 1/25/14.
//
//

#import "MJMViewController.h"
#import "MJMDareCardView.h"
#import "MJMStyleSheet.h"
#import "MJMChallenge.h"
#import "MJMUser.h"
#import "MJMCoreDataManager.h"
#import "MBProgressHUD.h"

#import <MobileCoreServices/MobileCoreServices.h>
#import <Firebase/Firebase.h>
#import "UIView+JMNoise.h"

@interface MJMViewController () <
UINavigationControllerDelegate,
UIImagePickerControllerDelegate,
UIActionSheetDelegate>

@property (nonatomic, strong) UIScrollView *contentScrollView;

@property (nonatomic, strong) NSArray *challenges;
@property (nonatomic, strong) NSArray *dareCardViews;
@property (nonatomic) NSUInteger selectedChallange;

@end

@implementation MJMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"Dares!";
    self.view.backgroundColor = [[MJMStyleSheet sharedInstance] backgroundColor];
    [self.view applyNoiseWithOpacity:0.1];
    //
    // Load challenges
    
    NSFetchRequest *allChallengesRequest = [NSFetchRequest fetchRequestWithEntityName:@"MJMChallenge"];
    NSManagedObjectContext *context = [[MJMCoreDataManager sharedInstance] mainManagedObjectContext];
    NSError *err;
    NSArray *results = [context executeFetchRequest:allChallengesRequest error:&err];
    if (results) {
        self.challenges = results;
    }
    else {
        NSLog(@"Fetch Error: %@", err);
    }

    // Content scroll view
    self.contentScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.contentScrollView.pagingEnabled = YES;
    self.contentScrollView.contentSize = CGSizeMake([self.challenges count] * self.view.bounds.size.width, self.view.bounds.size.height);
    [self.view addSubview:self.contentScrollView];
    
    // Add card views
    NSMutableArray *allDareCards = [[NSMutableArray alloc] initWithCapacity:[self.challenges count]];
    for (NSInteger i=0; i<[self.challenges count]; i++) {
        MJMChallenge *challenge = self.challenges[i];
        MJMDareCardView *dareCard = [[MJMDareCardView alloc] initWithFrame:CGRectMake(0, 0, 250, 360)];
        dareCard.center = CGPointMake(self.view.bounds.size.width/2.f,
                                      self.view.bounds.size.height/2.f);
        dareCard.frame = CGRectOffset(dareCard.frame, self.view.bounds.size.width * i, 0);
        dareCard.proveButton.tag = i;
        [dareCard.proveButton addTarget:self
                                 action:@selector(_takeProvePicture:)
                       forControlEvents:UIControlEventTouchUpInside];
        
        dareCard.titleLabel.text = challenge.title;
//        dareCard.descriptionLabel.text = challenge.challengeDescription;

        [allDareCards addObject:dareCard];
        [self.contentScrollView addSubview:dareCard];
    }
    self.dareCardViews = [NSArray arrayWithArray:allDareCards];
}

#pragma mark - MJMViewController

- (void)_takeProvePicture:(UIButton *)sender
{
    self.selectedChallange = sender.tag;
    
    [self _addProveImage:[UIImage imageNamed:@"doge"]
             toChallange:self.challenges[self.selectedChallange]
                  byUser:[MJMUser currentUser]];
    return;
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Take Photo", @"Choose From Library", nil];
    [actionSheet showInView:self.view];
}

#pragma mark - <UIActionSheetDelegate>

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIImagePickerControllerSourceType sourceType;
    switch (buttonIndex) {
        case 0:
            sourceType = UIImagePickerControllerSourceTypeCamera;
            break;
        case 1:
            sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            break;
        default:
            return;
    }

    UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
    cameraUI.sourceType = sourceType;
    
    // Displays a control that allows the user to choose picture or
    // movie capture, if both are available:
    cameraUI.mediaTypes =
    [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
    
    // Hides the controls for moving & scaling pictures, or for
    // trimming movies. To instead show the controls, use YES.
    cameraUI.allowsEditing = NO;
    cameraUI.delegate = self;
    
    [self presentViewController:cameraUI
                       animated:YES
                     completion:nil];
}

#pragma mark - <UIImagePickerControllerDelegate>

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    UIImage *originalImage, *editedImage, *imageToUse;
    
    // Handle a still image picked from a photo album
    if (CFStringCompare ((CFStringRef) mediaType, kUTTypeImage, 0)
        == kCFCompareEqualTo) {
        
        editedImage = (UIImage *) [info objectForKey:
                                   UIImagePickerControllerEditedImage];
        originalImage = (UIImage *) [info objectForKey:
                                     UIImagePickerControllerOriginalImage];
        
        if (editedImage) {
            imageToUse = editedImage;
        } else {
            imageToUse = originalImage;
        }
        
        
    [self _addProveImage:editedImage
             toChallange:self.challenges[self.selectedChallange]
                  byUser:[MJMUser currentUser]];
    }
    
    // Handle a movied picked from a photo album
    if (CFStringCompare ((CFStringRef) mediaType, kUTTypeMovie, 0)
        == kCFCompareEqualTo) {
        
        NSURL *movieURL = [info objectForKey:
                                UIImagePickerControllerMediaURL];
        [self _addProveVideo:[NSData dataWithContentsOfURL:movieURL]
                 toChallange:self.challenges[self.selectedChallange]
                      byUser:[MJMUser currentUser]];
    }

    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)_addProveImage:(UIImage *)proveImage
           toChallange:(MJMChallenge *)challange
                byUser:(MJMUser *)user
{
    // Called when user picked an image
    [self _showCompletedPopup];
}
- (void)_addProveVideo:(NSData *)proveImage
           toChallange:(MJMChallenge *)challange
                byUser:(MJMUser *)user
{
    // Called when user picked a video
    [self _showCompletedPopup];
}

- (void)_showCompletedPopup
{
	MBProgressHUD  *HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
	[self.navigationController.view addSubview:HUD];
	HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
	
	// Set custom view mode
	HUD.mode = MBProgressHUDModeCustomView;
	HUD.labelText = @"Completed";
	[HUD show:YES];
	[HUD hide:YES afterDelay:2];
}

@end
