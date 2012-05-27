/* Copyright (c) 2012, individual contributors
 *
 * Permission to use, copy, modify, and/or distribute this software for any
 * purpose with or without fee is hereby granted, provided that the above
 * copyright notice and this permission notice appear in all copies.
 *
 * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 */


#import "GNProjectBrowserTableViewController.h"
#import "GNAppDelegate.h"
#import "GNFileManager.h"
#import "GNTableViewCell.h"

@implementation GNProjectBrowserTableViewController

@synthesize delegate;

-(id)init
{
    self = [super init];
    {
        delegate = nil;
    }
    return self;
}

-(void)toggleEditing
{
    [self setEditing:!self.editing animated:YES];
}

#pragma mark - Table View Delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if(delegate)
    {
        GNProject* project = [[self allProjects] objectAtIndex:indexPath.row];
        [[self delegate] didSelectProject:project];
    }
}

#pragma mark - Table View Data Source

-(NSArray*)allProjects
{
    NSManagedObjectContext* managedObjectContext = [(GNAppDelegate*)[[UIApplication sharedApplication] delegate] managedObjectContext];
    NSManagedObjectModel* managedObjectModel = [(GNAppDelegate*)[[UIApplication sharedApplication] delegate] managedObjectModel];
    
    NSFetchRequest* allProjectsFetchRequest = [managedObjectModel fetchRequestTemplateForName:@"GNAllProjectsFetchRequest"];
    
    NSArray* fetchResults = [managedObjectContext executeFetchRequest:allProjectsFetchRequest error:nil];
    
    return fetchResults;
}

-(GNTableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    // Create a table view cell for this project
    GNTableViewCell* cell = [[GNTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                   reuseIdentifier:@"kGNProjectTableViewCell"];
    
    NSString* projectName = [[[self allProjects] objectAtIndex:indexPath.row] valueForKey:@"name"];
    
    [[cell textLabel] setText:projectName];
    
    return cell;
}

-(NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of projects in the managed object context
    return [[self allProjects] count];
}

-(void)tableView:(UITableView*)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath*)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete)
    {
        // They deleted a project
        
        // Find the matching project
        GNProject* project = [[self allProjects] objectAtIndex:indexPath.row];
        NSString* projectName = [project valueForKey:@"name"];
        
        // Remove folder for project
        [GNFileManager removeContentAtRelativePath:projectName];
        
        // Remove the project from the managed object context
        NSManagedObjectContext* managedObjectContext = [(GNAppDelegate*)[[UIApplication sharedApplication] delegate] managedObjectContext];
        [managedObjectContext deleteObject:project];
                
        // Reload data
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

@end
