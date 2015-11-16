//
//  CellFrame.m
//  百思不得骑姐
//
//  Created by lanou3g on 15/10/25.
//  Copyright (c) 2015年 lanlou3g.com 蓝欧科技. All rights reserved.
//

#import "CellFrame.h"



@implementation CellFrame

- (void)setModel:(UserModel *)model
{
    _model = model;
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat imageWidth = width - 2*PLspaceBetween;
    self.profile_imageFrame = CGRectMake(PLspaceBetween, PLspaceBetween, 30, 30);
    self.nameFrame = CGRectMake(CGRectGetMaxX(self.profile_imageFrame)+PLspaceBetween, PLspaceBetween,width -(CGRectGetMaxX(self.profile_imageFrame)+PLspaceBetween), 15);
    self.created_atFrame = CGRectMake(CGRectGetMinX(self.nameFrame), CGRectGetMaxY(self.nameFrame), CGRectGetWidth(self.nameFrame), 15);
    CGFloat heightText = [self stringWithByString:model.text fontSize:15 contentSize:CGSizeMake(width - 2*PLspaceBetween, MAXFLOAT)];
    self.textFrame = CGRectMake(CGRectGetMinX(self.profile_imageFrame), CGRectGetMaxY(self.profile_imageFrame)+10, width-2*PLspaceBetween, heightText);
    
    if (model.image1) {
        CGFloat imageH = 0;
//            if ([model.height isEqualToString:@"0"]) {
//                imageH = 150;
//            }else{
                CGFloat beforeHeight = model.height.floatValue;
                CGFloat beforeWidth = model.width.floatValue;
//                imageH = beforeHeight;
                if (beforeHeight > 700) {
                    imageH = beforeHeight;
                }
                if (beforeWidth > 350) {
                    imageH = beforeHeight/beforeWidth * imageWidth;
                    imageWidth = beforeWidth/beforeHeight * imageH;
                }else{
                    imageH = beforeHeight;
                }
//            }
        if ([model.is_gif isEqualToString:@"1"]) {
            CGFloat beforeWidth = model.height.floatValue;
            imageH = beforeWidth;
            self.webViewFrame = CGRectMake(CGRectGetMinX(self.textFrame), CGRectGetMaxY(self.textFrame)+PLspaceBetween, imageWidth, imageH);
//            return;
        }else{
            self.webViewFrame = CGRectMake(CGRectGetMinX(self.textFrame), CGRectGetMaxY(self.textFrame)+PLspaceBetween, imageWidth, imageH);
            
        }
    }
    if(model.richtxt){
    self.webViewFrame = CGRectMake(CGRectGetMinX(self.textFrame), CGRectGetMaxY(self.textFrame)+PLspaceBetween, imageWidth, 160);
    }

    CGFloat buttonY = 0;
    if (model.image1) {
        buttonY = CGRectGetMaxY(self.textFrame) + CGRectGetHeight(self.webViewFrame) + PLspaceBetween;
    }else if(model.richtxt){
        buttonY = CGRectGetMaxY(self.webViewFrame) + PLspaceBetween;
    }else{
        buttonY = CGRectGetMaxY(self.textFrame) + PLspaceBetween;

    }
    
    CGFloat buttonWidth = imageWidth/4;
    CGFloat buttonHeight = 35;
    self.loveButtonFrame = CGRectMake(PLspaceBetween, buttonY, buttonWidth, buttonHeight);
    self.hateButtonFrame = CGRectMake(CGRectGetMaxX(self.loveButtonFrame), buttonY, buttonWidth, buttonHeight);
    self.repostBtnFrame = CGRectMake(CGRectGetMaxX(self.hateButtonFrame), buttonY, buttonWidth, buttonHeight);
    self.commentBtnFrame = CGRectMake(CGRectGetMaxX(self.repostBtnFrame), buttonY, buttonWidth, buttonHeight);
    self.cellHeight = buttonY + 35 + PLspaceBetween;
    
}



- (CGFloat) stringWithByString:(NSString *)str fontSize:(CGFloat)fontSize contentSize:(CGSize)size
{
    CGRect stringH = [str boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
    return stringH.size.height;
}


@end

