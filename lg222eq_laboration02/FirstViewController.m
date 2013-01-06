//
//  FirstViewController.m
//  lg222eq_laboration02
//
//  Created by Lucas Gren on 2012-06-28.
//  Copyright (c) 2012 Lucas Gren. All rights reserved.
//

#import "FirstViewController.h"



@interface FirstViewController ()

@end

@implementation FirstViewController

@synthesize searchText, rowSelected, nameStringArray, messageStringArray, imageURLStringArray, activity, selectedTweet;




- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    TweetParser *tp = [TweetParser sharedInstance];
    searchText = [searchBar text];
    tp = [TweetParser sharedInstance];
    [tp findMatches:searchText];
    
    
    [searchBar resignFirstResponder];
    [activity startAnimating];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];

    

    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailViewController *detail = [self.storyboard instantiateViewControllerWithIdentifier:@"Detail"];
    [self.navigationController pushViewController:detail animated:YES];
        
    NSNumber *indexForTweet = [NSNumber numberWithInt:[indexPath row]];


    //selectedTweet = [td.arrayOfTweets objectAtIndex:[indexPath row]];
    
  //  NSLog(@"%@", selectedTweet.theAuthor.name);

    NSDictionary *extraInfo = [NSDictionary dictionaryWithObjectsAndKeys: indexForTweet, @"indexTweet", nil];
    
    NSNotification *notify = [NSNotification notificationWithName:@"clicked" object:self userInfo:extraInfo];
    
    [[NSNotificationCenter defaultCenter]postNotification:notify];



    
    
}



- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"]; 
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
    cell.textLabel.text = [messageStringArray objectAtIndex:[indexPath row]];
    
/*    for (Tweet *tweets in arrayOfTweets) {
        NSString *imageFile = [[NSBundle mainBundle] pathForResource: [imageURLStringArray objectAtIndex:[indexPath row]] ofType:@"png"];
        NSLog(@"%@", tweets.imageLink);
    }
    
    UIImage *ui = [[UIImage alloc] initWithContentsOfFile:imageFile];
    cell.imageView.image = ui;*/
    
    cell.detailTextLabel.text = [nameStringArray objectAtIndex:[indexPath row]];
        
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if (messageStringArray == nil) {
        [messageStringArray removeAllObjects];
    }

    return cell;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return messageStringArray.count;
}

-(void) doneParsing: (NSNotification *) note{
    

    NSDictionary *dict = [note userInfo];
    NSNumber *dataload = [dict objectForKey:@"dataLoaded"];
    data = [dataload boolValue];
    
    nameStringArray = [[NSMutableArray alloc]init];
    messageStringArray = [[NSMutableArray alloc]init];
    imageURLStringArray = [[NSMutableArray alloc]init];
    TweetParser *tp = [TweetParser sharedInstance];
//    if (data== YES) {
        for (Tweet *tweet in tp.arrayOfTweets) {
            [messageStringArray addObject:tweet.title];
            [nameStringArray addObject:tweet.theAuthor.name];
  //          [imageURLStringArray addObject:tweet.link];
            
//        }
    }
    
    
    
    [tableView reloadData];
    [activity stopAnimating];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];

    
    
}


- (void)viewDidLoad{
    [super viewDidLoad];
    
    NSNotificationCenter *ns = [NSNotificationCenter defaultCenter];
    [ns addObserver:self selector:@selector(doneParsing:) name:@"parsed" object:nil];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
