import { router } from "@kit.ArkUI"


@Entry
@Component

export struct SuggestPage{

  build() {
    Column(){
      Row(){
        Image($r("app.media.back"))
          .onClick(() => {
            router.replaceUrl({
              url: "pages/MyPage"
            })
          })
          .align(Alignment.Start)
          .height(30)
          .width(50)
        Text("意见反馈")
          .fontSize(25)
          .fontColor('#ff000000')
          .textAlign(TextAlign.Center)
          .width("100%")
          .offset({ x: -27, y: 0 })
      }
      .width("100%")
      Image($r("app.media.SuggestHead"))
        .width("100%")
        .height("100")
        .borderRadius(8)
        .margin({top:20,bottom:18})
      Text("常见问题")
        .textAlign(TextAlign.Center)

        Column({space:10}){
        Row({space:5}){
          Image($r("app.media.question"))
            .width(25)
          Text("客服联系电话：19188888888（工作日在线）")
            .fontSize(13)
        }
        .width("100%")
        .margin({left:10})
          Row({space:5}){
            Image($r("app.media.question"))
              .width(25)
            Text("官方QQ：3030043566")
              .fontSize(13)
          }
          .width("100%")
          .margin({left:10})
          Row({space:5}){
            Image($r("app.media.question"))
              .width(25)
            Text("会员开通未到账？")
              .fontSize(13)
          }
          .width("100%")
          .margin({left:10})
          Row({space:5}){
            Image($r("app.media.question"))
              .width(25)
            Text("广告问题")
              .fontSize(13)
          }
          .width("100%")
          .margin({left:10})
          Row(){
            Image($r("app.media.question"))
              .width(25)
            Text("如何设置日")
              .fontSize(13)
          }
          .width("100%")
          .margin({left:10})
        }
        .height("80%")
    }
    .margin({right:10,left:10})
  }
}