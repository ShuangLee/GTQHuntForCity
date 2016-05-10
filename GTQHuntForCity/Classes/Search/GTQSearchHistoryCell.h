//
//  GTQSearchHistoryCell.h
//  GTQHuntForCity
//
//  Created by 光头强 on 16/5/10.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GTQSearchHistoryCell : UITableViewCell
/** 历史搜索文字 */
@property (weak, nonatomic) IBOutlet UILabel *historyTextLabel;

+ (instancetype)historyCellWithTableView:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath atNSMutableArr:(NSMutableArray *)datas;
@end
