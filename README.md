# CVUMoviePlayerView

**Easy remote video playback in a `UIView` subclass.**

This is still in early stages of development, so proceed with caution when using this in a production application. Any bug reports, feature requests, or general feedback at this point would be greatly appreciated.

## Demo

Build and run the `CVUMoviePlayerViewExample` project in Xcode to see `CVUMoviePlayerView` in action.

## Installation

`CVUMoviePlayerView` requires the `MediaPlayer` Framework, so the first thing you'll need to do is include the framework into your project. In Xcode 4, go to the project file at the root of your workspace and select your active target. There should be several sections across the top of that window; choose "Build Phases". Next, click "Link Binary With Libraries" to expand that section to see the frameworks currently included in your project. Click the "+" at the bottom left and select "MediaPlayer.framework".

Now that the framework has been linked, all you need to do is drop `CVUMoviePlayerView.{h,m}` into your project, and add `#include "CVUMoviePlayerView.h"` to the top of classes that will use it.

## Example Usage

Add an instance of CVUMoviePlayerView to the view of your choosing. Provide a videoURL and a frame. The view will show a play UIButton over a placeholder UIImageView that triggers the playback.

``` objective-c

CGRect frame = CGRectMake(0, 0, 300, 300);
NSURL* videoURL = [NSURL URLWithString:@"https://devimages.apple.com.edgekey.net/resources/http-streaming/examples/bipbop_4x3/bipbop_4x3_variant.m3u8"];
CVUMoviePlayerView* moviePlayerView = [[CVUMoviePlayerView alloc] initWithFrame:frame videoURL:videoURL];
[self.view addSubview:moviePlayerView];
```

This is what it looks like:

[![Example Usage of the CVUMoviePLayerView](https://raw.github.com/ursachec/CVUMoviePlayerView/master/example.png)](#app)



## Advanced Usage

You can provide a placeholder image upon initialization. 

``` objective-c

CGRect frame = CGRectMake(0, 0, 300, 300);
UIImage* placeholderImage = [UIImage imageNamed:@"video_placeholder_image.png"];
NSURL* videoURL = [NSURL URLWithString:@"https://devimages.apple.com.edgekey.net/resources/http-streaming/examples/bipbop_4x3/bipbop_4x3_variant.m3u8"];
CVUMoviePlayerView* moviePlayerView = [[CVUMoviePlayerView alloc] initWithFrame:frame placeholderImage:placeholderImage videoURL:videoURL];
```

You can set an image for the play button.

``` objective-c
    
// self.moviePlayerView is an already initialized instance of CVUMoviePlayerView
UIImage* playVideoButtonPlaceholderImage = [UIImage imageNamed:@"play_button.png"];
[self.moviePlayerView.placeholderPlayVideoButton setImage:playVideoButtonPlaceholderImage forState:UIControlStateNormal];

    
```

## Supported streaming formats

- HTTP Live Streaming content
- all other formats also supported by *MPMoviePlayerController* 


## Contact

Claudiu-Vlad Ursache

- https://github.com/ursachec
- https://twitter.com/ursachec
- http://cvursache.com

## License

CVUMoviePlayerView is available under the MIT license. See the LICENSE file for more info.
