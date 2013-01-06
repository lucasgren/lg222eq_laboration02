//
//  DetailViewController.h
//  lg222eq_laboration02
//
//  Created by Lucas Gren on 2012-08-14.
//
//

#import <UIKit/UIKit.h>
#import "Tweet.h"
#import "DataHandler.h"
#import "FirstViewController.h"

@interface DetailViewController : UIViewController{
    IBOutlet UILabel *name;
    IBOutlet UILabel *content;
    IBOutlet UIButton *saveFavourite;
    int i;
    BOOL data;
}

@property (nonatomic) Tweet *theTweet;
@property (nonatomic) NSNumber *selectedTweet;
@property (nonatomic) BOOL saveButtonIsActive;
@property (nonatomic) NSInteger indexInteger;
@property (nonatomic) NSMutableArray *arrayOfTweets;


-(IBAction)pressedSaveAsFavourite:(id)sender;

@end
