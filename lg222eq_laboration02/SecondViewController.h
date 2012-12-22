//
//  SecondViewController.h
//  lg222eq_laboration02
//
//  Created by Lucas Gren on 2012-06-28.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataHandler.h"
#import "DetailViewController.h"


@interface SecondViewController : UIViewController{
    
    IBOutlet UITableView *tableView;
    BOOL data;
}

@property (nonatomic) NSMutableArray *nameStringArray;
@property (nonatomic) NSMutableArray *messageStringArray;
@property (nonatomic) NSMutableArray *imageURLStringArray;
@property (nonatomic) NSMutableArray *savedTweets;


@end
