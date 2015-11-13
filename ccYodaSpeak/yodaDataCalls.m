//
//  yodaDataCalls.m
//  culosYodaSpeak
//
//  Created by Chris Culos on 11/12/15.
//  Copyright © 2015 Chris Culos. All rights reserved.
//

#import "yodaDataCalls.h"

@implementation yodaDataCalls

+ (void)yodafyString:(NSString *)baseString andReturnYodaString:(void (^)(NSString *))yodaFiedString
{
    UNIUrlConnection *asyncConnection = [[UNIRest get:^(UNISimpleRequest *request)
    {
        NSString *urlString = [NSString stringWithFormat:@"%@%@", kYodaBaseURL, [baseString stringByReplacingOccurrencesOfString:@" " withString:@"+"]];
        NSLog(@"url String: %@", urlString);
        [request setUrl:urlString];
        [request setHeaders:kYodaHeader];
    }] asStringAsync:^(UNIHTTPStringResponse *stringResponse, NSError *error)
    {
        if (!error)
        {
            NSInteger code = stringResponse.code;
            
            if (code != 200)
            {
                [self dismissGlobalHUD];
                NSLog(@"Request Failed, Code: %lu", code);
            }
            else
            {
                [self dismissGlobalHUD];
                yodaFiedString([NSString stringWithFormat:@"%@", stringResponse.body]);
            }
        }
        else
        {
            [self dismissGlobalHUD];
            NSLog(@"Request Failed: %@", error);
            yodaFiedString(nil);
        }
    }];
}

+ (MBProgressHUD *)showGlobalProgressHUDWithTitle:(NSString *)title
{
    UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
    [MBProgressHUD hideAllHUDsForView:window animated:YES];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
    hud.labelText = title;
    hud.dimBackground = YES;
    return hud;
}

+ (void)dismissGlobalHUD
{
    UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
    [MBProgressHUD hideAllHUDsForView:window animated:YES];
}

@end
