//
//  yodaDataCalls.h
//  culosYodaSpeak
//
//  Created by Chris Culos on 11/12/15.
//  Copyright © 2015 Chris Culos. All rights reserved.
//

#import <Foundation/Foundation.h>
//
#import "UNIRest/UNIRest.h"
#import "yodaConstants.h"
#import "MBProgressHUD.h"

@interface yodaDataCalls : NSData
{
    
}

+ (void)yodafyString:(NSString *)baseString andReturnYodaString:(void (^)(NSString *))yodaFiedString;

+ (MBProgressHUD *)showGlobalProgressHUDWithTitle:(NSString *)title;
+ (void)dismissGlobalHUD;

@property (nonatomic, retain) NSManagedObjectContext *objectContext;

@end
