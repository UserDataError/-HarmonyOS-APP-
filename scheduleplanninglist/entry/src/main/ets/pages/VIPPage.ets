import { PromptAction, router } from "@kit.ArkUI"


@Entry
@Component
export  struct VIPPage {

  scroller: Scroller = new Scroller()

  build() {
    Column() {
      // 返回栏
      Row(){
        Image($r("app.media.back"))
          .onClick(()=>{
            router.replaceUrl({
              url:"pages/MyPage"
            })
          })
          .align(Alignment.Start)
          .height(30)
          .width(30)
        Text('会员中心')
          .fontSize(20)
          .fontColor('#FFFFFF')
          .textAlign(TextAlign.Center)
          .width("100%")
          .offset({ x: -27, y: 0 })
      }
      .backgroundColor('#ff151e27')
      .width("100%")
      Scroll(this.scroller){
        Column() {
          Image($r("app.media.VIPBackground"))
          .width("100%")
          .height("90%")
          Row({space:30}){
            Column(){
                Text('悦享卡')
                  .fontSize(18)
                  .fontColor('#FFD700')
                Text('9元/月')
                  .fontSize(28)
                  .fontColor('#FFD700')
              .margin({ bottom: 24 })
              Button('立即开通', { type: ButtonType.Capsule })
                .width('45%')
                .height(40)
                .backgroundColor('#FFD700')
                .fontColor('#2A004B')
                .onClick(()=>{
                  //支付页面
                  let uiContext = this.getUIContext();
                  let promptAction: PromptAction = uiContext.getPromptAction();
                  promptAction.showDialog({
                    title: '确认开通会员',
                    message: '开通月度会员',
                    buttons: [
                      {
                        text: '确认',
                        color: '#000000'
                      },
                      {
                        text: '取消',
                        color: '#ffff0000'
                      }
                    ]
                  })
                })
            }
            Column(){
                Text('畅享卡')
                  .fontSize(18)
                  .fontColor('#FFD700')
                Text('99元/年')
                  .fontSize(28)
                  .fontColor('#FFD700')
              .margin({ bottom: 24 })
              Button('立即开通', { type: ButtonType.Capsule })
                .width('45%')
                .height(40)
                .backgroundColor('#FFD700')
                .fontColor('#2A004B')
                .onClick(()=>{
                  //支付页面
                  let uiContext = this.getUIContext();
                  let promptAction: PromptAction = uiContext.getPromptAction();
                  promptAction.showDialog({
                    title: '确认开通会员',
                    message: '开通年度会员',
                    buttons: [
                      {
                        text: '确认',
                        color: '#000000'
                      },
                      {
                        text: '取消',
                        color: '#ffff0000'
                      }
                    ]
                  })
                })
            }

          }

          Blank(50)
          Row({space:160}){
            Text("价值权益说明:")
              .fontColor("#ffd9d9d9")
            Text("每月限购1次")
              .fontColor("#ffff0000")
          }
          .padding(10)

          Text(
            "年卡规则说明\n" +
            "\n" +
            "\n" +
            "1、悦享卡售价为98元，支付成功后即刻生效，可在365天内享受悦享卡权益；\n" +
            "\n" +
            "2、如当前有悦享卡尚在有效期内,再次购买悦享卡，该悦享卡将在当前月卡过期后自动生效，非购买当日立即生效；提前预购的悦享卡暂不支持退款，请用户谨慎操作购买；\n" +
            "\n" +
            "3、悦享卡仅限开通时绑定的用户，悦享卡开通后不可将权益转移/更改绑定到其他用户；\n" +
            "\n" +
            "6、悦享卡为虚拟物品，售出后，无论是否剩余有未领取的奖励，均暂不支持退款。因账号封停导致的道具领取失败均不支持退款与道具补发，请谨慎购买；\n" +
            "\n" +
            "7、悦享卡的付费金额不参与日程清单App及应用内的各项充值返利/累计充值活动；\n" +
            "\n" +
            "8、悦享卡成功支付后，领取奖励资格可能存在短暂延迟，敬请耐心等待。如响应存在长时间异常，请通过客服，或通过意见反馈与我们联系；\n" +
            "\n" +
            "9、任何以盗窃、利用系统漏洞、通过任何非日程计划官方或授权途径获得的悦享卡权益，均不获相关保护，我们有权取消及/或不予提供悦享卡权益，所有产生的损失及责任由行为人自行承担。\n" +
            "\n" +
            "\n" +
            "自动续费规则说明\n" +
            "\n" +
            "\n" +
            "1、服务名称：悦享卡自动续费\n" +
            "\n" +
            "\n" +
            "2、您点击订阅、开通及使用悦享卡会员自动续费服务（以下称“本自动续费服务”），则视为您同意本规则。如您通过微信支付开通本自动续费服务，且在订阅期内未主动明确取消本自动续费服务，则相关主体将在每个订阅期到期当日，从您开通本自动续费服务时绑定的自有充值账户、绑定的第三方支付账户、银行卡、通信账户等账户（以下统称“账户”）余额中自动代扣下一个订阅期的服务费，从而延长该订阅期对应的会员有效期，订阅到期当日成功续费后对应订阅内容将在次日即下一周期的订阅生效日正常发放。\n" +
            "\n" +
            "\n" +
            "3、年卡订阅周期：365天。 月卡订阅周期：30天。"+
            "\n" +
            "\n" +
            "4、如需退订自动续费，您可通过 点击“自动续费管理”-->在自动续费页面找到您所开通的自动续费服务，点击关闭即可；微信支付的自动续费状态更新可能存在显示延时，请以微信支付的自动续费签约状态为准；需要提醒您特别注意，基于自动续费服务的特点，如果您在订阅期内未明确取消自动续费服务，腾讯将根据您的委托向相关主体发出下一个订阅期的代扣指令，原则上对基于该指令扣除的费用将不予退还。\n" +
            "\n" +
            "\n" +
            "5、日程计划官方亦可以根据运营策略需要而停止继续向您提供自动续费服务，您的会员服务期限自当前服务周期届满之日起终止。\n" +
            "\n" +
            "\n")
            .padding(10)
            .fontColor("#ffd9d9d9")
        }
        .width('100%')
        .backgroundColor('#212F3C')
      }

    }
    .height("100%")
    .width('100%')
    .backgroundColor('#F5F5F5')



  }
}
