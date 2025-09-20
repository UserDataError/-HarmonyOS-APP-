
import {  router } from '@kit.ArkUI'
import { Logger } from '@ohos/httpclient';

@Entry
@Component
struct Welcome {

  onPageShow() {
    Logger.info('Welcome!')
    setTimeout(() => {
      router.replaceUrl({
        url: "pages/LoginPage"
      })
    }, 1500);
  }

  build() {
    Column() {
      Column({space:30}){
        Image($r("app.media.logo"))
          .width(70)
          .height(70)
        Text("日程清单")
          .fontSize(30)
          .blendMode(BlendMode.DST_IN, BlendApplyType.OFFSCREEN)
        Text("做好每天的Todolist")
          .fontSize(30)
          .blendMode(BlendMode.DST_IN, BlendApplyType.OFFSCREEN)
      }
    .height("50%")
      .width("100%")
      Text('无广告、不过渡索取、滥用系统权限')
        .fontSize(22)
        .fontWeight(FontWeight.Regular)

    }
    .linearGradient({
      direction: GradientDirection.Right,
      colors: [["#ff798cff", 0.0], ["#ffb523ca", 1]]
    })
    .blendMode(BlendMode.SRC_OVER, BlendApplyType.OFFSCREEN)
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }
}