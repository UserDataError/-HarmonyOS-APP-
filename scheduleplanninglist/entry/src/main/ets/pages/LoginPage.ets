import { promptAction, router } from '@kit.ArkUI'
import UserApi from '../api/UserApi'


@Extend(TextInput)
function inputStyle() {
  .placeholderColor($r('sys.color.ohos_dialog_text_alert'))
  .height("45vp")
  .fontSize("18fp")
  .backgroundColor("#ffeae8e8")
  .width("100%")
  .padding({ top: "12vp" })
  .margin({ top: "12vp" })
}

@Extend(Line)
function LineStyle() {
  .width("100%")
  .height("2vp")
  .backgroundColor("#ff292727")
}

@Extend(Text)
function BlueTextStyle() {
  .fontColor("#ff1d36ea")
  .fontSize("14fp")
  .fontWeight(FontWeight.Medium)
}


@Entry
@Component
struct LoginPage {
  @State phone: string = ''
  @State password: string = ''
  //控制是否显示进度
  @State isShowProgress: boolean = false;

  //自定义组件
  @Builder
  imageButton(src: Resource) {
    Button({ type: ButtonType.Circle, stateEffect: true }) {
      Image(src)
    }
    .height("48vp")
    .width("48vp")
    .backgroundColor("#ff7e7979")
  }

  async login() {
    if (this.phone.length === 0) {
      promptAction.showDialog({ message: "请输入手机号" })
      return
    }

    if (this.password.length === 0) {
      promptAction.showDialog({ message: "请输入密码" })
      return
    }
    this.isShowProgress = true
    const res = await UserApi.login({ phone: this.phone, password: this.password })
    this.isShowProgress = false
    if (res) {
      router.replaceUrl({ url: "pages/Index" })
    }
  }

  build() {
    Column() {
      Image($r('app.media.logo'))
        .width("70vp")
        .height("70vp")
        .margin({ top: "70vp", bottom: "6vp" })

      Text("日程清单")
        .fontSize("25fp")
        .fontWeight(FontWeight.Medium)
        .fontColor($r('sys.color.ohos_dialog_text_alert'))

      Text("登录账号以解锁更多功能")
        .fontSize("16fp")
        .fontWeight(FontWeight.Medium)
        .fontColor($r('sys.color.ohos_dialog_text_alert'))
        .margin({ top: "8vp", bottom: "38vp" })

      TextInput({ placeholder: "请输入手机号", text: $$this.phone })// $$双向绑定到this.phone变量，同步输入内容
        .maxLength(11)
        .type(InputType.PhoneNumber)
        .inputStyle()

      Line()
        .LineStyle()
      TextInput({ placeholder: "密码", text: $$this.password })// $$双向绑定到this.password变量，同步输入内容
        .maxLength(11)
        .type(InputType.Password)
        .inputStyle()

      Line()
        .LineStyle()

      Row() {
        Text("短信验证码登录").BlueTextStyle()
        Text("忘记密码").BlueTextStyle()

      }
      .justifyContent(FlexAlign.SpaceBetween)
      .width("100%")
      .margin({ top: "8vp" })

      //登录按钮
      Button("登录")
        .onClick(() => {
          this.login()
        })
        .width("80%")
        .height("48vp")
        .fontSize("16vp")
        .fontWeight(FontWeight.Medium)
        .margin({ top: "100vp", bottom: "12vp" })

      Button("注册账号")
        .width("80%")
        .height("48vp")
        .fontSize("16vp")
        .fontWeight(FontWeight.Medium)
        .margin({ top: "1vp", bottom: "12vp" })
        .onClick(() => {
          router.pushUrl({
            url: "pages/RegisterPage"
          });
        })
      //加上加载组件
      if (this.isShowProgress) {
        LoadingProgress()
          .color(Color.Blue)
          .layoutWeight(1)
          .width("35vp")
          .height("35vp")
          .margin({ top: "20vp" })
      }

      Blank()

      Text("其他登录方式")
        .fontSize("12fp")
        .fontWeight(FontWeight.Medium)
        .fontColor("#ff534e4e")
        .margin({ top: "10vp", bottom: "12vp" })

      Row({ space: 44 }) {
        this.imageButton($r("app.media.login_method1"))
        this.imageButton($r("app.media.login_method2"))
        this.imageButton($r("app.media.login_method3"))
      }
    }
    .linearGradient({
      //背景色渐变
      angle: 145, //线性渐变的起始角度。0点方向顺时针旋转为正向角度。
      colors: [[0xffff00, 0.0], [0x0f00f0, 0.5], [0xff00ff, 1.0]]
    })
    .height("100%")
    .height('100%')
    .width('100%')
    .padding({
      left: "12vp",
      right: "12vp",
      bottom: "12vp"
    })
  }
}
