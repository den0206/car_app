

# 動作イメージ

|Card Carousel|自作 Carousel|
|---|---|
|![動作イメージ](readme_gif/screen-3.gif)|![動作イメージ](readme_gif/screen-2.gif)|

<br>

|動画投稿UI|Tap Animation|
|---|---|
|![動作イメージ](readme_gif/screen-4.gif)|![動作イメージ](readme_gif/screen-1.gif)|
<br>


# ディレクトリ構成(lib)


``` directory
├── main.dart
└── src
    ├── data
    │   ├── consts_color.dart
    │   └── sampleVideo.dart
    ├── extension
    │   ├── animation_background.dart
    │   ├── auto_hide_top_bar_widget.dart
    │   ├── custom_button.dart
    │   ├── custom_dialog.dart
    │   ├── origin_carousel.dart
    │   └── overlay_loading_widget.dart
    ├── model
    │   ├── carousel_object.dart
    │   ├── user.dart
    │   └── video.dart
    ├── provider
    │   ├── favorite_manager.dart
    │   ├── network_manager.dart
    │   ├── ramdom_image_manager.dart
    │   ├── random_user_manager.dart
    │   └── video_manager.dart
    └── screen
        ├── carousels
        │   ├── carousel_card.dart
        │   └── carousel_list.dart
        ├── common
        │   ├── bottom_tab.dart
        │   ├── network_branch.dart
        │   └── no_wifi_screen.dart
        ├── feed
        │   ├── favorite_screen.dart
        │   ├── feed_screen.dart
        │   ├── video_player_page.dart
        │   └── video_view.dart
        ├── inline
        │   ├── inline_detail_screen.dart
        │   └── inline_screen.dart
        ├── root.dart
        ├── upload
        │   ├── confirm_screen.dart
        │   ├── custom_textfields.dart
        │   └── upload_screen.dart
        └── users
            ├── user_detail_screen.dart
            ├── users_card_screen.dart
            ├── users_list_screen.dart
            └── users_screen.dart
        
```


## pub.dev

``` yaml
# null-safety
environment:
  sdk: '>=2.12.0 <3.0.0'

dependencies:
  flutter:
    sdk: flutter
  badges: ^2.0.1
  cached_network_image: ^3.0.0
  chewie: ^1.2.2
  cupertino_icons: ^1.0.3
  image_picker: ^0.8.0+4
  internet_connection_checker: ^0.0.1+1
  provider: ^5.0.0
  video_player: ^2.1.6
  video_thumbnail: ^0.3.3
  
```


## API(使用目的)
---

## [RANDOM User Generator (JSON)](https://randomuser.me/)

>User Modelを作成。実際のUI/UXに近しい環境を再現。


## [Lorem Picsum (JSON)](https://picsum.photos/)

>可能な限りネットワークを経由しての画像描写再現の為。


<br>


### **参考URL**
---
https://flutter.dev/docs/development/ui/animations/hero-animations

https://flutter.dev/docs/cookbook/animation/opacity-animation

https://stackoverflow.com/questions/53727361/how-to-change-speed-of-a-hero-animation-in-flutter

https://medium.com/swlh/flutters-ux-bouncing-animation-1424fdbdd325  等...

### **動作環境**
___

- vscode : 1.57.1 
- dart :  2.13.3
- flutter : 2.2 (null-safety)



