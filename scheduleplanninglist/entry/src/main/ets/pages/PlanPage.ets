import {CellStatus,
  CJCalendarControl,
  CJCalStatusParams,
  CJCellStyle,
  CJDateItem,
  CJCalendar,
  SelectedShape,
  SelectedStyle,
  CJViewModel,
  OptMode,
  CJDateShowBackMode
} from 'cjcalendar';

interface Note {
  content: string;
  createTime: string;
}

// 定义持久化键名（需在应用启动时初始化）
//PersistentStorage.persistProp('userInputKey', '');

@Component
@Entry
export struct PlanPage {
  cjDataItem: CJDateItem = new CJDateItem(new Date())
  cjCellStyle: CJCellStyle = new CJCellStyle()
  controller: CJCalendarControl = new CJCalendarControl()
  @State defSelectedItems: Array<string> = ["2024-11-03", "2024-11-08"]
  @State extras: Record<string, number | string | boolean> = {}
  @State notes: Note[] = [] // 存储所有备注

  // 绑定持久化存储数据（双向同步）
 // @StorageLink('markInputKey') markInput: string = '';

  // private getCurrentTime(): string {
  //   const now = new Date()
  //   return `${now.getFullYear()}-${(now.getMonth() + 1).toString().padStart(2, '0')}-` +
  //     `${now.getDate().toString().padStart(2, '0')} ` +
  //     `${now.getHours().toString().padStart(2, '0')}:` +
  //     `${now.getMinutes().toString().padStart(2, '0')}:` +
  //     `${now.getSeconds().toString().padStart(2, '0')}`
  // }

  // 添加备注
  // private addNote() {
  //   if (this.markInput.trim()) {
  //     this.notes.unshift({
  //       content: this.markInput,
  //       createTime: this.getCurrentTime()
  //     })
  //     this.markInput = '' // 清空输入框
  //   }
  // }

  build() {
    Column() {
      Text("计划安排")
        .height(50)
        .textAlign(TextAlign.Center)
      Column() {
        CJCalendar({
          logSwitch: true,
          controller: this.controller,
          extras: this.extras,
          // 初始化默认选中项目
          optMode: OptMode.NORMAL,
          // 回显方式，只有在 OptMode.NORMAL下才生效
          dateShowBackMode: CJDateShowBackMode.SHOW_PRE_LAST_NEXT_FIRST | CJDateShowBackMode.SHOW_CLICK,
          viewModel: CJViewModel.MONTH,
          // 初始化选中项
          defSelectedItems: [new Date("2025-5-25")],
          selectedStyle: SelectedStyle.CLOSE,
          selectedShape: SelectedShape.SHAPE_RECT,
          showFastToday: true,
          // 是否显示折叠按钮
          isShowFoldView: true,
          // 标题栏背景色
          titleBackgroundColor: Color.Orange,
          // 标题格式化显示
          titleFormat: "yyyy年MM月",
          // 是否显示农历
          showLunar: true,
          // 是否显示节日
          showJieRi: true,
          // 仅需要日期显示区域，不需要底部自定义区域
          onlyShowDateArea: false,
          // 是否将底部自定义区域添加到整体
          isAttchCustomLayoutToWhole: false,
          // 是否显示节气
          showJieQi: true,
          onMonthChangeBefore: (curr: CJDateItem, target: CJDateItem) => {
            console.log("月份切换之前：", "当前：" + curr.toString() + "，目标：" + target.toString())
          },

          onMonthChanged: (month: CJDateItem) => {
            console.log("月份切换结束：", month.toString())
          },
          onCellItemClick: (item: CJDateItem) => {
            // 这里修改数据后会同步更新到界面
            // item.date = item.date + 1
            // item.extras.set("test", "-" + (item.date + 1) + "-")
            console.log("点击了：", JSON.stringify(item))
            return false
          },
          // 日历初始化完成
          onInitFinish: () => {
            // 1、强制刷新所有
            // this.controller.refresh(true)
            // 2、指定修改具体项目
            let days: CJDateItem[] | undefined = this.controller.getCurrMonthDays()
            let now: Date = new Date()
            days?.forEach(day => {
              if (day.date > now.getDate() - 3 && day.date < now.getDate() + 3) {
                day.markText = "注"
              }
            })
            this.controller.setFoldStatue(true)
          },

          //自定义Cell样式风格
          buildCellStyle: (item: CJDateItem) => {
            let cjCellStyle: CJCellStyle = new CJCellStyle()
            if (item.week == 0 || item.week == 6) {
              cjCellStyle.fontColor = "#b83b5e"
            }
            // 标注样式
            cjCellStyle.markFontColor = "#ff922f08"
            cjCellStyle.markFontSize = 10
            cjCellStyle.markMarin = 4
            cjCellStyle.markFontWeight = FontWeight.Bold
            cjCellStyle.markImageWidth = 12
            cjCellStyle.markAlignment = Alignment.TopEnd
            // 设置今天文字颜色
            cjCellStyle.todayFontColor = "#FFFFFF"
            // 设置今天背景色
            cjCellStyle.todayBackgroundColor = "#ffffa801"

            return cjCellStyle
          },
          // 月视图下的用户布局区域
          buildMonthCustomLayout: () => {
            this.BuildMonthCustomLayout()
          },
        })
      }
      .layoutWeight(1)
      .justifyContent(FlexAlign.Start)

    }
    .height("100%")
  }

  @Builder
  BuildCellBackground() {
    if (this.cjDataItem.isToday && this.cjDataItem.extras.test == '1') {
      Column()
        .backgroundColor("#D13F3F")
        .width(50)
        .height(56)
        .borderRadius(6)
        .opacity(0.5)

    } else if (this.cjDataItem.isToday && this.cjDataItem.extras.test == '0') {
      Column()
        .backgroundColor("#D13F3F")
        .width(50)
        .height(56)
        .borderRadius(6)

    } else if (this.cjDataItem.isToday) {
      Column()
        .backgroundColor("#D13F3F")
        .width(50)
        .height(56)
        .borderRadius(6)
    } else {
      if (this.cjDataItem.isSelected) {
        Column()
          .alignItems(HorizontalAlign.End)
          .justifyContent(FlexAlign.Start)// .backgroundColor(this.cjDataItem.extras.test == '1' ? Color.Orange : this.cjCellStatus.backgroundColor)
          .width(50)
          .height(56)
          .border({
            width: 1,
            color: "#D13F3F"
          })
          .borderRadius(6)
      }
    }
  }

  @Builder
  BuildMonthCustomLayout() {
    Scroll() {
    Flex({ wrap: FlexWrap.Wrap }) {
      Button("回到今天")
        .onClick(() => {
          this.controller.backToday()
        })
        .fontColor(Color.Black)
        .backgroundColor("#00000000")
      Button("显示农历")
        .onClick(() => {
          this.controller.showLunar(true)
        })
        .fontColor(Color.Black)
        .backgroundColor("#00000000")
      Button("隐藏农历")
        .onClick(() => {
          this.controller.showLunar(false)
        })
        .fontColor(Color.Black)
        .backgroundColor("#00000000")
      Button("切换周模式")
        .onClick(() => {
          this.controller.changViewModel(CJViewModel.WEEK)
        })
        .fontColor(Color.Black)
        .backgroundColor("#00000000")
      Button("切换月模式")
        .onClick(() => {
          this.controller.changViewModel(CJViewModel.MONTH)
        })
        .fontColor(Color.Black)
        .backgroundColor("#00000000")
      this.BuildCellBody()
    }
    .margin({
      top: 30
    })
  }
}
  step: number = 1

  @Builder
  BuildCellBody() {
    Column() {
      Column() {
        // Button("test")
        //   .onClick(() => {
        //     this.controller.getCurrMonthDays()
        //   })

        // // 输入区域
        // TextInput({ placeholder: ('请输入备注内容')})
        //   .onChange((value: string) => {
        //     this.markInput = value
        //   })
        //   .margin(10)
        //   .padding(10)
        //   .width('90%')
        //   .height(60)
        //   .borderRadius(8)
        //   .backgroundColor(Color.White)

        // // 添加按钮
        // Button('添加备注')
        //   .onClick(() => this.addNote())
        //   .margin(10)
        //   .width('90%')
        //   .height(40)
        //   .backgroundColor('#409EFF')
        //   .fontColor(Color.White)

      }
      .width('100%')
      .height('100%')
      .padding(10)
      .backgroundColor('#f5f5f5')

    }
    .alignItems(HorizontalAlign.Center)

}
}