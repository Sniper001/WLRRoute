//
//  WLRRouteHandler.m
//  Pods
//
//  Created by Neo on 2016/12/15.
//
//

#import "WLRRouteHandler.h"
#import "WLRMatchResult.h"
#import "UIViewController+WLRRoute.h"
#import "NSError+WLRError.h"
@implementation WLRRouteHandler
-(BOOL)shouldHandleWithRequest:(WLRRouteRequest *)request{
    return YES;
}
-(UIViewController *)targetViewControllerWithRequest:(WLRRouteRequest *)request{

    return [[NSClassFromString(@"HBTestViewController") alloc]init];
}
-(UIViewController *)sourceViewControllerForTransitionWithRequest:(WLRRouteRequest *)request{
    return [UIApplication sharedApplication].windows[0].rootViewController;
}
-(BOOL)transitionWithRequest:(WLRRouteRequest *)request error:(NSError *__autoreleasing *)error{
    UIViewController * sourceViewController = [self sourceViewControllerForTransitionWithRequest:request];
    UIViewController * targetViewController = [self targetViewControllerWithRequest:request];
    if ((![sourceViewController isKindOfClass:[UIViewController class]])||(![targetViewController isKindOfClass:[UIViewController class]])) {
        *error = [NSError WLRTransitionError];
        return NO;
    }
    if (targetViewController != nil) {
        targetViewController.wlr_request = request;
    }
    if ([self preferModalPresentationWithRequest:request]||![sourceViewController isKindOfClass:[UINavigationController class]]) {
        [sourceViewController presentViewController:targetViewController animated:YES completion:nil];
    }
    else if ([sourceViewController isKindOfClass:[UINavigationController class]]){
        UINavigationController * nav = (UINavigationController *)sourceViewController;
        [nav pushViewController:targetViewController animated:YES];
    }
    return YES;
}
- (BOOL)preferModalPresentationWithRequest:(WLRRouteRequest *)request;{
    return NO;
}
@end
