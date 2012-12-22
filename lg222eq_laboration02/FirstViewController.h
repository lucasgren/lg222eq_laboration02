//
//  FirstViewController.h
//  lg222eq_laboration02
//
//  Created by Lucas Gren on 2012-06-28.
//  Copyright (c) 2012 Lucas Gren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"
#import "TweetParser.h"
#import "DataHandler.h"
#import "DetailViewController.h"


@interface FirstViewController : UIViewController{
    IBOutlet UITableView *tableView;
    IBOutlet UISearchBar *aSearchBar;
    IBOutlet UIActivityIndicatorView *activity;
    BOOL data;

}
                                        


@property (weak, nonatomic) NSString *searchText;
@property (nonatomic) NSInteger rowSelected;
//@property (nonatomic) NSMutableArray *arrayOfTweets;
@property (nonatomic) Tweet *selectedTweet;
@property (nonatomic) NSMutableArray *nameStringArray;
@property (nonatomic) NSMutableArray *messageStringArray;
@property (nonatomic) NSMutableArray *imageURLStringArray;
@property (nonatomic) UIActivityIndicatorView *activity;



@end
