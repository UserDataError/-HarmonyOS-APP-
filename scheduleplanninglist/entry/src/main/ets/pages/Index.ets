import { router } from '@kit.ArkUI';
import { common } from '@kit.AbilityKit';
import ToolBarData from '../ViewModel/ToolBarData';
import ToolBarComponent from '../view/ToolBarComponent';
import { MyPage } from './MyPage';
import { PlanPage } from './PlanPage';
import { ConcentrationPage } from './ConcentrationPage';
import { ScheduleFragment } from './schedule/ScheduleFragment';

@Entry
@Component
struct Index {
  //No.3————写一个数组，索引变量，控制器,先写一个viewModel——ToolBarData
  @State toolBarConfig: ToolBarData[] = []
  navCurrentPosition: number = 0;
  private controller: TabsController = new TabsController();

  //在页面打开的时候给toolBarConfig数组加上数据
  aboutToAppear() {
    //用户协议弹窗
    AlertDialog.show({
      title: "用户许可使用协议",
      message:
      "请您本产品之前，请务必仔细阅读并理解《用户许可使用协议》（以下简称“本协议”）中规定的多有权利和限制。\n" +
        "\n" +
        "我们一向尊重并会严格保护用户在使用本产品时的合法权益（包括用户隐私、用户数据等）不受到任何侵犯。\n" +
        " \n" +
        "本协议（包括本文最后部分的隐私政策）是用户（包括通过各种合法途径获取到本产品的自然人、法人或其他组织机构，以下简称“用户”或“您”）与我们之间针对本产品相关事项最终的、完整的且排他的协议，并取代、合并之前的当事人之间关于上述事项的讨论和协议。" +
        " \n" +
        "本协议将对用户使用本产品的行为产生法律约束力，您已承诺和保证......",
      autoCancel: false, //点击遮障层时，是否关闭弹窗。默认值：true
      alignment: DialogAlignment.Center, //弹窗在竖直方向上的对齐方式。默认值：DialogAlignment.Default
      primaryButton: {
        value: "退出应用",
        fontColor: '#ffff0000',
        action: () => {
          (getContext(this) as common.UIAbilityContext)?.terminateSelf();
        }
      },
      secondaryButton: {
        value: "我同意",
        fontColor: "#ff1c7eff",
        action: () => {
        }
      },
      cornerRadius: 12, //弹窗边框弧度
      width: '80%', //弹窗宽度
      cancel: () => {
      }
    })

    this.toolBarConfig = [
      {
        num: 0,
        text: "日程",
        img_after: $r("app.media.schedule"), //未选中时的状态
        icon: $r("app.media.schedule_selected"),
      }, {
      num: 1,
      text: "计划",
      img_after: $r("app.media.plan"), //未选中时的状态
      icon: $r("app.media.plan_selected"),
    }, {
      num: 2,
      text: "专注",
      img_after: $r("app.media.concentration"), //未选中时的状态
      icon: $r("app.media.concentration_selected"),
    },
      //   {
      //   num: 3,
      //   text: "我的",
      //   img_after: $r("app.media.mine"), //未选中时的状态
      //   icon: $r("app.media.mine_selected"),
      // },
      {
        num: 3,
        text: "我的",
        img_after: $r("app.media.mine"), //未选中时的状态
        icon: $r("app.media.mine_selected"),
      },
    ];
  }

  build() {

    Stack({ alignContent: Alignment.Bottom }) {
      //Navigation组件是路主导航的根试图容器
      Navigation() {
        //四个页面的切换
        Tabs({ barPosition: BarPosition.Start, controller: this.controller }) {
          //循环生成4个页面
          ForEach(this.toolBarConfig, (item: ToolBarData) => {
            //第一个页面，主页
            TabContent() {
              if (item.num === 0) {
                //显示主页,ScheduleFragment
                ScheduleFragment()
              } else if (item.num === 1) {
                //显示计划页面
                PlanPage()
              } else if (item.num === 2) {
                //显示专注页面
                ConcentrationPage()
              } else if (item.num === 3) {
                MyPage()
              } else {
                //生成简单的自定义组件页面
                this.HolderPage(item.text);
              }
            }

          }, (item: ToolBarData) => JSON.stringify(item))
        }
        .backgroundColor("#ffffffff")
        .barHeight(0) //设置为0，方便实现自定义布局效果
        .scrollable(false) //限制滚动效果，让滚动时不触发切换

      }
      .toolbarConfiguration(this.ToolBarBuilder()) //重新自定义组件
      .hideTitleBar(true) //设置是否隐藏标题栏
      .width("100%")
      .height("100%")
    }
  }

  //自定义组件
  @Builder
  ToolBarBuilder() {
    ToolBarComponent({
      //组件绑定
      controller: this.controller,
      toolBarConfig: this.toolBarConfig,
      navCurrentPosition: this.navCurrentPosition//No.8————回到ToolBarComponent接着写build里面的内容
    })
      .backgroundColor("#fff")
      .height("100%")

  }

  //生成简单的自定义组件页面
  @Builder
  HolderPage(text: string) {

    Column() {
      Text(text)
        .fontSize(35)
        .backgroundColor("#ff7c7c7c")
        .width("100%")
        .height("100%")
        .textAlign(TextAlign.Center)
    }
    .justifyContent(FlexAlign.Center)

  }
}