//
//  DetailViewController.m
//  lg222eq_laboration02
//
//  Created by Lucas Gren on 2012-08-14.
//
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

@synthesize selectedTweet, saveButtonIsActive, theTweet, indexInteger, arrayOfTweets;




-(void) selectedTweet: (NSNotification *) note{
    
    
    NSDictionary *dict = [note userInfo];
    selectedTweet = [[NSNumber alloc]init];
    selectedTweet = [dict objectForKey:@"indexTweet"];
    
    indexInteger = [selectedTweet intValue];
    theTweet = [[Tweet alloc] init];
    TweetParser *tp = [TweetParser sharedInstance];
    
    theTweet = [tp.arrayOfTweets objectAtIndex:indexInteger];

    [name setText: theTweet.theAuthor.name];
    content.numberOfLines = 4;
    //    content.adjustsFontSizeToFitWidth = YES;
    [content setText:theTweet.title];
    


}

-(IBAction)pressedSaveAsFavourite:(id)sender{
    
    
    //Fixes bug of having to press save twice the first time
    if (i == 0) {
        self.saveButtonIsActive = !self.saveButtonIsActive;
        i++;
    }
    
    if (saveButtonIsActive) {
        self.saveButtonIsActive = !self.saveButtonIsActive;
        
        
        saveFavourite.selected = YES;
    
        
//        [[tp.arrayOfTweets objectAtIndex:indexInteger] setSaved:YES];
        
//        TweetParser *tp = [TweetParser sharedInstance];
        
        [DataHandler saveTweet:theTweet];
         
        //Notify
        NSDictionary *extraInfo = [NSDictionary dictionaryWithObject:theTweet forKey:@"tweet"];
        
        NSNotification *notify = [NSNotification notificationWithName:@"saved" object:self userInfo:extraInfo];
        
        [[NSNotificationCenter defaultCenter]postNotification:notify];




        
    } else {
        
        self.saveButtonIsActive = !self.saveButtonIsActive;
        
        saveFavourite.selected = NO;
        
        
 //       [[tp.arrayOfTweets objectAtIndex:indexInteger] setSaved:NO];
  //      [savedTweets removeObject:theTweet];
        [DataHandler deleteTweet:theTweet];
        
    }
    
    

}


- (void)viewDidLoad
{
    [super viewDidLoad];

    i = 0;
    
    NSNotificationCenter *ns = [NSNotificationCenter defaultCenter];
    [ns addObserver:self selector:@selector(selectedTweet:) name:@"clicked" object:nil];

    

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
