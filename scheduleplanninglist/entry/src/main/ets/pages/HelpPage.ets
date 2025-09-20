import { PromptAction, router } from "@kit.ArkUI"

@Entry
@Component
export  struct HelpPage{

  ThanksDialog(){
    let uiContext = this.getUIContext();
    let promptAction: PromptAction = uiContext.getPromptAction();
    promptAction.showDialog({
      title: '支持成功',
      message: '感谢您的帮助！日程清单因您而更好！',
      buttons: [
        { text: '确认',
          color: '#000000' },
        { text: '取消',
          color: '#ffff0000' }]
    })
  }

  build() {
    Column() {
      // 顶部文字区域
      Column({ space: 8 }) {
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
          Text("让日程清单更好")
            .fontSize(25)
            .fontColor('#ff000000')
            .textAlign(TextAlign.Center)
            .width("100%")
            .offset({ x: -27, y: 0 })
        }
        .width("100%")
      }
      .width('100%')
      .padding(16)
      .backgroundColor("#F5F5F5")
      Image($r("app.media.helpTab"))
        .width("100%")
      Blank()
      // 商品列表
      Column() {
        Text("您的鼓励是我们最大的动力")
        .fontSize(15)
        .fontColor(Color.Black)
        .margin({bottom:16 })
          Row(){
          Column({space:50}){
            Row({space:50}){
              Column(){
                Image($r("app.media.HelpCoCaCoLa"))
                  .width("200px")
                  .height("200px")
                Text("悠闲快乐水")
                Text("3.5￥")
              }
              .onClick(()=>{
                this.ThanksDialog();
              })
              Column(){
                Image($r("app.media.HelpChicken"))
                  .width("200px")
                  .height("200px")
                Text("美味大鸡腿")
                Text("6.88￥")
              }
              .onClick(()=>{
                this.ThanksDialog();
              })
            }

            Row({space:50}){
              Column(){
                Image($r("app.media.HelpCoffee"))
                  .width("200px")
                  .height("200px")
                Text("清醒咖啡")
                Text("15.50￥")
              }
              .onClick(()=>{
                this.ThanksDialog();
              })
              Column(){
                Image($r("app.media.HelpLobster"))
                  .width("200px")
                  .height("200px")
                Text("龙虾大餐")
                Text("188.88￥")
              }
              .onClick(()=>{
                this.ThanksDialog();
              })
            }
          }
          }
      }
      .margin({ top: 20 })

      // 自定义金额输入
      Flex({ justifyContent: FlexAlign.SpaceBetween, alignItems: ItemAlign.Center }) {
        Text("吃顿好的")
          .fontSize(16)
          .fontColor("#333333")
        TextInput({ placeholder: "————￥" })
          .width(120)
          .textAlign(TextAlign.End)
          .fontSize(16)
          .type(InputType.Number)
          .fontColor("#FF5500")

      }
      .padding(16)
      .margin({ top: 20 })

      // 底部操作按钮
      Button("支持开发者", { type: ButtonType.Capsule })
        .width('80%')
        .height(48)
        .fontSize(18)
        .backgroundColor("#FF5500")
        .margin(24)
        .onClick(()=>{
          this.ThanksDialog();
        })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}