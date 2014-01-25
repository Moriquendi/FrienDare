//
//  MJMCoreDataManager.m
//  FrienDare
//
//  Created by Michal Smialko on 1/25/14.
//
//

#import "MJMCoreDataManager.h"

@interface MJMCoreDataManager ()
@property (nonatomic, strong) UIManagedDocument *databaseDocument;
@end

@implementation MJMCoreDataManager

#pragma mark - + MJMCoreDataManager

+ (instancetype)sharedInstance
{
    static id manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    
    return manager;
}

#pragma mark - MJMCoreDataManager


- (void)initModelWithCompletionHandler:(void (^)(void))completionHandler
{
    // Set up CoreData database
    NSURL *databaseURL  = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory
                                                                  inDomains:NSUserDomainMask] lastObject];
    databaseURL = [databaseURL URLByAppendingPathComponent:@"FrienDare.momd"];
    self.databaseDocument = [[UIManagedDocument alloc] initWithFileURL:databaseURL];
    if ([[NSFileManager defaultManager] fileExistsAtPath:[databaseURL path]]) {
        [self.databaseDocument openWithCompletionHandler:^(BOOL success) {
            if (success) {
                [self _databaseDocumentDidLoad];
                if (completionHandler) {
                    completionHandler();
                }
            }
            else {
                NSLog(@"Could not open database file");
            }
        }];
    }
    else {
        [self.databaseDocument saveToURL:databaseURL
                        forSaveOperation:UIDocumentSaveForCreating
                       completionHandler:^(BOOL success) {
                           if (success) {
                               [self _databaseDocumentDidLoad];
                               if (completionHandler) {
                                   completionHandler();
                               }
                           }
                           else {
                               NSLog(@"Could not create database file");
                           }
                       }];
    }
    
}

- (void)_databaseDocumentDidLoad
{
    if (self.databaseDocument.documentState == UIDocumentStateNormal) {
    }
}

- (NSManagedObjectContext *)mainManagedObjectContext
{
    return self.databaseDocument.managedObjectContext;
}


@end
