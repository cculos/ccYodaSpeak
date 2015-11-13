//
//  ViewController.m
//  ccYodaSpeak
//
//  Created by Chris Culos on 11/12/15.
//  Copyright © 2015 Chris Culos. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "Unirest/UNIRest.h"
#import "AFNetworking/AFNetworking.h"
#import "AFNetworking/AFURLRequestSerialization.h"
//
#import "yodaConstants.h"
#import "yodaDataCalls.h"
#import "yodaResultsViewController.h"


@interface ViewController ()

@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UIButton *yodafyButton;

@end

@implementation ViewController

@synthesize objectContext;

- (void)viewDidLoad {
    
    [_yodafyButton addTarget:self action:@selector(yodafyString:) forControlEvents:UIControlEventTouchUpInside];
    
    self.title = @"Yodafy Me!";
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillAppear:(BOOL)animated
{
    _textField.text = @"";
    [super viewWillAppear:animated];
}

- (void)yodafyString:(id)sender
{
    if (_textField.text.length != 0)
    {
        [yodaDataCalls showGlobalProgressHUDWithTitle:@"Waiting on API"];
        [yodaDataCalls yodafyString:_textField.text andReturnYodaString:^(NSString *yodafiedString)
         {
             if (yodafiedString == nil)
             {
                 [self showAlertWithTitle:@"API Call Erorr" andMessage:@"The API goes down a lot.  Sorry abou that"];
             }
             else
             {
                 NSLog(@"Finished String: %@", yodafiedString);
                 
                 AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
                 
                 objectContext = [[NSManagedObjectContext alloc] init];
                 objectContext.persistentStoreCoordinator = [delegate persistentStoreCoordinator];
                 
                 NSManagedObject *yodaObject = [NSEntityDescription insertNewObjectForEntityForName:kYodaObject inManagedObjectContext:objectContext];
                 [yodaObject setValue:_textField.text forKey:kOriginalString];
                 [yodaObject setValue:yodafiedString forKey:kYodaString];
                 [yodaObject setValue:[NSDate date] forKey:kYodaTime];
                 
                 NSError *error;
                 
                 if (![objectContext save:&error])
                 {
                     [self showAlertWithTitle:@"Couldn't Save" andMessage:@"Error Saving Yoda Object"];
                     NSLog(@"Couldn't Save");
                 }
                 else
                 {
                     [self toResultsView];
                     NSLog(@"Saved");
                 }
             }
         }];
    }
    else
    {
        [self showAlertWithTitle:@"Enter a string." andMessage:@"Blank the text field cannot be"];
        nil;
    }
}

- (void)showAlertWithTitle:(NSString *)titleString andMessage:(NSString *)message
{
    UIAlertController *alert = [UIAlertController
                                alertControllerWithTitle:titleString
                                message:message
                                preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *dismissButton = [UIAlertAction
                                    actionWithTitle:@"Okay"
                                    style:UIAlertActionStyleCancel
                                    handler:^(UIAlertAction * _Nonnull action)
                                    {
                                        dispatch_async(dispatch_get_main_queue(), ^{
                                            [self dismissViewControllerAnimated:YES completion:nil];
                                        });
                                    }];
    
    [alert addAction:dismissButton];
    [self presentViewController:alert animated:YES completion:nil];
}



- (void)toResultsView
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [yodaDataCalls dismissGlobalHUD];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        yodaResultsViewController *tableController = [storyboard instantiateViewControllerWithIdentifier:@"yodaResults"];
        [self.navigationController pushViewController:tableController animated:YES];
    });
}

- (void)showAlertWithTitleString:(NSString *)string
{
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Yodafied"
                                 message:string preferredStyle:UIAlertControllerStyleAlert];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
