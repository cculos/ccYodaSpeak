//
//  yodaResultsViewController.h
//  
//
//  Created by Chris Culos on 11/12/15.
//
//

#import <UIKit/UIKit.h>

@interface yodaResultsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    
}

@property (nonatomic, retain) UITableView *tableView;

@property (nonatomic, retain) NSManagedObjectContext *objectContext;

@property (nonatomic, retain) NSMutableArray *cellArray;

@property (nonatomic, retain) NSArray *fetchedObjects;

@end
