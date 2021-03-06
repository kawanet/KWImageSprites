KWImageSprites
==============

KWImageSprites clips sprites from an image like CSS-sprite.

```obj-c
#import "KWImageSprites.h"
```

```obj-c
KWImageSprites *sprites = [[KWImageSprites alloc] init];

NSError *err = nil;
[sprites loadMapWithPath:@"glyphicons-halflings.json" error:&err];
[sprites loadImageWithPath:@"glyphicons-halflings.png" error:&err];

UIImage *image = [sprites imageForName:@"icon-music"];
```

## DEMO APPLICATION

KWImageSprites requires a pair of sprite sheet `.png` image and sprite map `.json` file.

<img src="https://raw.github.com/kawanet/KWImageSprites/master/public/capture1.png" width="320">

### Sprite Sheet Image

The demo application includes
[`glyphicons-halflings.png`](https://raw.github.com/kawanet/KWImageSprites/master/KWImageSprites/glyphicons-halflings.png)
sprite sheet borrowed from
[Glyphicons](http://glyphicons.com)
via
[Bootstrap](https://raw.github.com/twbs/bootstrap/v2.3.2/img/glyphicons-halflings.png).

<img src="https://raw.github.com/kawanet/KWImageSprites/master/KWImageSprites/glyphicons-halflings.png" width="469">

### Sprite Map JSON

The demo application includes
[`glyphicons-halflings.json`](https://raw.github.com/kawanet/KWImageSprites/master/KWImageSprites/glyphicons-halflings.json)
sprite map generated from
[bootstrap.css](https://github.com/twbs/bootstrap/blob/v2.3.2/docs/assets/css/bootstrap.css)
by
[image-sprites](https://github.com/kawanet/image-sprites)
script.

```json:glyphicons-halflings.json
{
 "icon-white": [-14,-14,14,14],
 "icon-glass": [0,0,14,14],
 "icon-music": [24,0,14,14],
 "icon-search": [48,0,14,14],
 "icon-envelope": [72,0,14,14],
 "icon-heart": [96,0,14,14],
 "icon-star": [120,0,14,14],
 "icon-star-empty": [144,0,14,14],
 "icon-user": [168,0,14,14],
 "icon-film": [192,0,14,14],
```

## INSTALLATION

```rb:Podfile
pod 'KWImageSprites', :git => 'https://github.com/kawanet/KWImageSprites.git'
```

## AUTHOR

Yusuke Kawasaki http://www.kawa.net/

## COPYRIGHT 
The following copyright notice applies to all the files provided in this distribution, including binary files, unless explicitly noted otherwise.

    Copyright 2013 Yusuke Kawasaki
