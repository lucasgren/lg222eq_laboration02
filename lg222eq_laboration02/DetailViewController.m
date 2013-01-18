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
    NSNumber *intTweet = [dict objectForKey:@"indexTweet"];
    
    int intForIndex = [intTweet integerValue];
    
    TweetParser *tp = [TweetParser sharedInstance];
    tp = [TweetParser sharedInstance];
    
    theTweet = [tp.arrayOfTweets objectAtIndex: intForIndex];
        
    [name setText: theTweet.name];
    content.numberOfLines = 4;
    [content setText:theTweet.message];
    

}

-(IBAction)pressedSaveAsFavourite:(id)sender{

    //Fixes bug of having to press save twice the first time
    if (i == 0) {
        self.saveButtonIsActive = !self.saveButtonIsActive;
        i++;
    }
    
    
    if([DataHandler containsTweet:theTweet]){
        [self setFavoriteButtonAdd];
    }
    else{
        [self setFavoriteButtonRemove];
    }
}
-(void)setFavoriteButtonAdd{
    [saveFavourite setTitle:@"Save as Favourite" forState:UIControlStateNormal];
    [saveFavourite setTitleColor:[UIColor colorWithRed:36/255.0 green:71/255.0 blue:113/255.0 alpha:1.0] forState:UIControlStateNormal];
    [DataHandler deleteTweet:theTweet];
}

-(void)setFavoriteButtonRemove{
    [saveFavourite setTitle:@"Remove from Favourites" forState:UIControlStateNormal];
    [saveFavourite setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [DataHandler saveTweet:theTweet];
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
