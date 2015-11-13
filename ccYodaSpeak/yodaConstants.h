//
//  yodaConstants.h
//  culosYodaSpeak
//
//  Created by Chris Culos on 11/12/15.
//  Copyright © 2015 Chris Culos. All rights reserved.
//

#ifndef yodaConstants_h
#define yodaConstants_h

// Define the Base URL for the YodaCalls API
#define kYodaBaseURL @"https://yoda.p.mashape.com/yoda?sentence="

// Define the header and request for YodaCalls API
#define kYodaHeader @{@"X-Mashape-Key": @"ZPOQZjl6UYmshPf3h75Qj8cbLbyVp1wCg4ljsncCyrDP5kzkZl", @"Accept": @"application/json"}

// Set name for properties in Yoda Object in CoreData
#define kYodaObject @"Yoda"
#define kOriginalString @"originalString"
#define kYodaString @"yodaString"
#define kYodaTime @"timeStamp"

#endif /* yodaConstants_h */
