import { router } from "@kit.ArkUI"


@Entry
@Component
export struct AboutPage {
  private arr: string[] = ["为什么叫日程计划", "隐私保护指引", "用户服务协议", "会员服务协议", "自动续费协议"]

  build() {
    Column({ space: 15 }) {
      Row() {
        Image($r("app.media.back"))
          .onClick(() => {
            router.replaceUrl({
              url: "pages/MyPage"
            })
          })
          .align(Alignment.Start)
          .height(30)
          .width(50)
        Text("关于我们")
          .fontSize(25)
          .fontColor('#ff000000')
          .textAlign(TextAlign.Center)
          .width("100%")
          .offset({ x: -27, y: 0 })
      }
      .width("100%")
      Column({ space: 10 }) {
        Image($r("app.media.app_icon"))
          .width(60)
          .height(60)
        Text("日程计划")
          .fontSize(20)
          .fontColor('#ff000000')
          .textAlign(TextAlign.Center)
          .width("100%")
        Text("V1.0.0")
          .fontSize(14)
          .fontColor('#ff000000')
          .textAlign(TextAlign.Center)
          .width("100%")
      }

      Column() {
        List({ space: 15 }) {
          ForEach(this.arr, (item: string) => {
            ListItem(){
              Text(item)
                .fontSize(15)
                .textAlign(TextAlign.Center)
                .width("100%")
            }
            .borderRadius(10)
            .backgroundColor("#ffffffff")
            .height("10%")
            .margin(2)

          })
        }

      }
      .padding(10)
      .margin(30)
      .borderWidth(1)
      .borderStyle(BorderStyle.Solid)
      .width("90%")
      .height("30%")
      .borderRadius(10)

      Text("如有疑问，请拨打客服热线：19188888888\n"
        +"在线时间：周一至周五（法定节假日除外）\n"
        +"上午9:30—12:00\n"
        +"下午14:00—18:00")
        .fontStyle(FontStyle.Italic)
        Blank()
      Text("ICP备案号：桂ICP备12312312号-1A")
        .align(Alignment.Bottom)
    }
    .height("100%")
  }
}