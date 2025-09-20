import { router } from "@kit.ArkUI"
import UserApi from "../api/UserApi";


@Entry
@Component
export struct MyPage{

  private Uid:number=100000;

//  private arr: string[] = ["主题风格", "设置中心","关于我们","帮助中心","意见反馈"]

  build() {
    Column(){
      Row({space:10}){
        Image($r("app.media.UserIMG"))//默认头像
      //  Image(UserApi.getUserInfo()?.avatar)
          .width("80vp")
          .height("80vp")
          .align(Alignment.Start)
        Column(){
          Text(UserApi.getUserInfo()?.nickname)
            .fontSize("50vp")
          Text("Uid:"+this.Uid+UserApi.getUserInfo()?.id)
        }
      }
      .justifyContent(FlexAlign.Center)
      .width("100%")
      Blank()
      Image($r("app.media.VIP"))  //会员开通
        .width("100%")
        .onClick(()=>{
          router.pushUrl({
            url:"pages/VIPPage"
          })
        })
      Column({space:2}){
        List({space:5}){
      //    ForEach(this.arr,(item:string)=>{
          ListItem(){
            Text("关于我们")
              .fontSize(25)
              .textAlign(TextAlign.Start)
              .width("100%")
              .onClick(()=>{
                router.pushUrl({
                  url:"pages/AboutPage"
                })
              })
          }
          .borderRadius(10)
          .backgroundColor("#ffffffff")
          .height("10%")
          .margin(2)
          ListItem(){
            Text("让日程清单更好")
              .fontSize(25)
              .textAlign(TextAlign.Start)
              .width("100%")
              .onClick(()=>{
                router.pushUrl({
                  url:"pages/HelpPage"
                })
              })
          }
          .borderRadius(10)
          .backgroundColor("#ffffffff")
          .height("10%")
          .margin(2)
          ListItem(){
            Text("退出登录")
              .fontSize(25)
              .textAlign(TextAlign.Start)
              .width("100%")
              .onClick(()=>{
                router.replaceUrl({
                  url:"pages/LoginPage"
                })
              })
          }
          .borderRadius(10)
          .backgroundColor("#ffffffff")
          .height("10%")
          .margin(2)
          ListItem(){
            Text("意见反馈")
              .fontSize(25)
              .textAlign(TextAlign.Start)
              .width("100%")
              .onClick(()=>{
                router.pushUrl({
                  url:"pages/SuggestPage"
                })
              })
          }
          .borderRadius(10)
          .backgroundColor("#ffffffff")
          .height("10%")
          .margin(2)
        }

      }
      .backgroundColor("#ffe2e2e2")
    }

  }
}