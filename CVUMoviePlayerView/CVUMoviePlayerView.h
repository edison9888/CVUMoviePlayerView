//
//  CVUMoviePlayerView.h
//  CharlieRose
//
//  Created by Claudiu-Vlad Ursache on 23.02.13.
//  MIT LICENSE
//

#import <UIKit/UIKit.h>

@interface CVUMoviePlayerView : UIView

@property(nonatomic, strong, readonly) UIView* placeholderView;
@property(nonatomic, strong, readonly) UIImageView* placeholderImageView;
@property(nonatomic, strong, readonly) UIButton* placeholderPlayVideoButton;
@property(nonatomic, strong, readwrite) UIImage* placeholderImage;

/**
 * <#add description#>
 */
- (id)initWithFrame:(CGRect)frame
   placeholderImage:(UIImage*)placeholderImage
           videoURL:(NSURL*)videoURL;

/**
 * <#add description#>
 */
- (id)initWithFrame:(CGRect)frame
   placeholderImage:(UIImage*)placeholderImage;

/**
 * <#add description#>
 */
- (id)initWithFrame:(CGRect)frame
           videoURL:(NSURL*)videoURL;

@end
