//
//  SecondViewController.m
//  lg222eq_laboration02
//
//  Created by Lucas Gren on 2012-06-28.
//  Copyright (c) 2012 Lucas Gren. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()


@end

@implementation SecondViewController

@synthesize nameStringArray, messageStringArray, imageURLStringArray, savedTweets;

/*- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailViewController *detail = [self.storyboard instantiateViewControllerWithIdentifier:@"Detail"];
    [self.navigationController pushViewController:detail animated:YES];
    
    
}*/
/*

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
    cell.textLabel.text = [messageStringArray objectAtIndex:[indexPath row]];
    
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
/*
- (void) getSaved: (NSNotification *) note{
    
    NSDictionary *dict = [note userInfo];
    Tweet *tweet = [dict objectForKey:@"tweet"];
    [savedTweets addObject:tweet];
    
    NSLog(@"%@", tweet);

    
    nameStringArray = [[NSMutableArray alloc]init];
    messageStringArray = [[NSMutableArray alloc]init];
    imageURLStringArray = [[NSMutableArray alloc]init];

//    for (Tweet *tw in savedTweets) {
            [messageStringArray addObject:tweet.content];
            [nameStringArray addObject:tweet.theAuthor.name];
    //        [imageURLStringArray addObject:tw.imageLink];
 //       }
        
    
    [tableView reloadData];
    
    
}*/

/*
- (void)viewDidLoad{
    
    DataHandler *dh = [DataHandler sharedInstance];
    
//    savedTweets = [dh loadTweets];
    
    nameStringArray = [[NSMutableArray alloc]init];
    messageStringArray = [[NSMutableArray alloc]init];
    imageURLStringArray = [[NSMutableArray alloc]init];
    
    for (Tweet *tw in savedTweets) {
        [messageStringArray addObject:tw.message];
        [nameStringArray addObject:tw.theAuthor.name];
            [imageURLStringArray addObject:tw.url];
        }
    
    
    [tableView reloadData];
    
    
/*    NSNotificationCenter *no = [NSNotificationCenter defaultCenter];
    [no addObserver:self selector:@selector(getSaved:) name:@"saved" object:nil];*/
    
/*

}

- (void)viewDidUnload{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}*/

@end
