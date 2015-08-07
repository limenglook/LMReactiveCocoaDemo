//
//  UIViewController+LM.h
//  LMCategory
//
//  Created by 李蒙 on 15/7/3.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    LMTransitionTypeFade,
    LMTransitionTypePush,
    LMTransitionTypeCube,
    LMTransitionTypeFlip,
    LMTransitionTypeRipple,
    LMTransitionTypePageCurl,
    LMTransitionTypePageUnCurl,
    LMTransitionTypePageCameraOpen,
    LMTransitionTypePageCamreaClose
} LMTransitionType;

typedef enum : NSUInteger {
    LMTransitionDirectionTop,
    LMTransitionDirectionLeft,
    LMTransitionDirectionBottom,
    LMTransitionDirectionRight
} LMTransitionDirection;

typedef void(^LMTransitionCompletion)();
typedef void(^LMFinishPickingMedia)(NSDictionary *info);
typedef void(^LMCancelPickingMedia)();

typedef void(^LMLoadingAppStore)();
typedef void(^LMLoadedAppStore)(NSError *error);
typedef void(^LMDidFinishAppStore)();

@protocol LMBackButtonHandlderProtocol <NSObject>

@optional

/**
 *  重写此方法处理返回按钮
 *
 *  @return YES:返回,NO:不返回
 */
- (BOOL)lm_navigationShouldPopOnBackButton;

@end

@interface UIViewController (LM) <LMBackButtonHandlderProtocol>

/**
 *  触摸自动隐藏键盘
 */
- (void)lm_tapDismissKeyboard;

/**
 *  转场动画
 *
 *  @param type       LMTransitionType
 *  @param direction  LMTransitionDirection
 *  @param duration   duration
 *  @param completion LMTransitionCompletion
 */
- (void)lm_addTransitionType:(LMTransitionType)type direction:(LMTransitionDirection)direction duration:(NSTimeInterval)duration completion:(LMTransitionCompletion)completion;

/**
 *  快速跳转到UIImagePickerController
 *
 *  @param sourceType    [UIImagePickerControllerSourceTypePhotoLibrary, UIImagePickerControllerSourceTypeCamera, UIImagePickerControllerSourceTypeSavedPhotosAlbum]
 *  @param allowsEditing 是否裁剪
 *  @param completion    跳转完成回调
 *  @param finish        [UIImagePickerControllerMediaType,UIImagePickerControllerOriginalImage,UIImagePickerControllerCropRect,UIImagePickerControllerMediaURL,UIImagePickerControllerReferenceURL,UIImagePickerControllerMediaMetadata]
 *  @param cancel        取消回调
 *
 *  @return UIImagePickerController
 */
- (UIImagePickerController *)lm_presentImagePickerControllerWithSourceType:(UIImagePickerControllerSourceType)sourceType allowsEditing:(BOOL)allowsEditing completion:(void (^)(void))completion didFinishPickingMedia:(LMFinishPickingMedia)finish didCancelPickingMediaWithInfo:(LMCancelPickingMedia)cancel;

/**
 *  跳转到AppStore
 *
 *  @param itemIdentifier       应用Identifier
 *  @param loadingAppStore      加载中回调
 *  @param loadedAppStore       跳转回调
  *  @param didFinishAppStore   点击取消回调
 */
- (void)lm_presentAppStoreWithITunesItemIdentifier:(NSInteger)itemIdentifier loading:(LMLoadingAppStore)loadingAppStore loaded:(LMLoadedAppStore)loadedAppStore didFinish:(LMDidFinishAppStore)didFinishAppStore;

@end
