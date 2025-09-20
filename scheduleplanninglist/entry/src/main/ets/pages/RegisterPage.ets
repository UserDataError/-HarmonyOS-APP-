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

@Entry
@Component
struct RegisterPage {
  @State nickname: string = ''
  @State phone: string = ''
  @State password: string = ''
  @State password2: string = ''
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

  async register() {

    if (this.nickname.length === 0) {
      promptAction.showDialog({ message: "请输入昵称" })
      return
    }

    if (this.phone.length === 0) {
      promptAction.showDialog({ message: "请输入手机号" })
      return
    }

    if (this.password.length === 0) {
      promptAction.showDialog({ message: "请输入密码" })
      return
    }

    if (this.password !== this.password2) {
      promptAction.showDialog({ message: "两次输入的密码不一致" })
      return
    }


    this.isShowProgress = true
    const res = await UserApi.register({  //使用 async/await 处理异步操作
      phone: this.phone,
      password: this.password,
      nickname: this.nickname,
    })
    this.isShowProgress = false
    if (res) {
      promptAction.showToast({
        message:"注册成功!",
        duration:2000
      })
      router.back()
    }
  }

  build() {
    Column() {
      Image($r('app.media.logo'))
        .width("70vp")
        .height("70vp")
        .margin({ top: "70vp", bottom: "6vp" })

      Text("注册新账户")
        .fontSize("25fp")
        .fontWeight(FontWeight.Medium)
        .fontColor($r('sys.color.ohos_dialog_text_alert'))


      TextInput({ placeholder: "账号", text: $$this.phone })
        .maxLength(11)
        .type(InputType.Number)
        .inputStyle()

      Line()
        .LineStyle()

      TextInput({ placeholder: "用户名", text: $$this.nickname })
        .maxLength(20)
        .type(InputType.Normal)
        .inputStyle()

      Line()
        .LineStyle()

      TextInput({ placeholder: "密码", text: $$this.password })
        .maxLength(11)
        .type(InputType.Password)
        .inputStyle()


      Line()
        .LineStyle()

      TextInput({ placeholder: "再次输入密码", text: $$this.password2 })
        .maxLength(11)
        .type(InputType.Password)
        .inputStyle()


      Line()
        .LineStyle()

      //注册按钮
      Button("注册")

        .onClick(() => {
          this.register();

        })
        .width("80%")
        .height("48vp")
        .fontSize("16vp")
        .fontWeight(FontWeight.Medium)
        .margin({ top: "100vp", bottom: "12vp" })

      Button("找回账号或密码")
        .width("80%")
        .height("48vp")
        .fontSize("16vp")
        .fontWeight(FontWeight.Medium)
        .fontColor("#ff084edd")
        .backgroundColor("#ffeae8e8")
        .margin({ top: "1vp", bottom: "12vp" })

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
    .backgroundImage($r("app.media.background"))
    .backgroundImageSize({ width: "100%", height: "100%" })
    .height('100%')
    .width('100%')
    .padding({
      left: "12vp",
      right: "12vp",
      bottom: "12vp"
    })
  }
}