//
//  ViewController.m
//  CVUMoviePlayerViewExample
//
//  Created by Claudiu-Vlad Ursache on 23.02.13.
//  MIT LICENSE
//

#import "ViewController.h"
#import "CVUMoviePlayerView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.    
    
    CGRect frame = CGRectMake(0, 0, 300, 300);
    UIImage* placeholderImage = nil;
    NSURL* videoURL = [NSURL URLWithString:@"https://devimages.apple.com.edgekey.net/resources/http-streaming/examples/bipbop_4x3/bipbop_4x3_variant.m3u8"];
    CVUMoviePlayerView* moviePlayerView = [[CVUMoviePlayerView alloc] initWithFrame:frame placeholderImage:placeholderImage videoURL:videoURL];
    [self.view addSubview:moviePlayerView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
