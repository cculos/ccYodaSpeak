//
//  yodaResultsViewController.m
//  
//
//  Created by Chris Culos on 11/12/15.
//
//

#import "yodaResultsViewController.h"
#import "yodaConstants.h"
#import "yodaTableViewCell.h"
#import "AppDelegate.h"
//
#import <CoreData/CoreData.h>

@implementation yodaResultsViewController

@synthesize objectContext;

- (void)viewDidLoad
{
    self.title = @"Results, These Are!";
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    
    objectContext = [[NSManagedObjectContext alloc] init];
    objectContext.persistentStoreCoordinator = [delegate persistentStoreCoordinator];
    
    NSError *error;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:kYodaObject inManagedObjectContext:objectContext];
    [fetchRequest setEntity:entity];
    [fetchRequest setReturnsObjectsAsFaults:NO];
    
    NSSortDescriptor *sort = [[NSSortDescriptor alloc]
                              initWithKey:@"timeStamp" ascending:NO];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
    
    _fetchedObjects = [objectContext executeFetchRequest:fetchRequest error:&error];
    
    for (NSManagedObject *object in _fetchedObjects)
    {
        NSLog(@"Object: %@", object);
    }
    [_tableView reloadData];
    [super viewDidLoad];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    
     yodaTableViewCell *cell = (yodaTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[yodaTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    else
    {
        cell.originalLabel.text = [[_fetchedObjects objectAtIndex:indexPath.row] valueForKey:kOriginalString];
        cell.yodaLabel.text = [[_fetchedObjects objectAtIndex:indexPath.row] valueForKey:kYodaString];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _fetchedObjects.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}

@end
