import NotificationManager from '@ohos.notificationManager';
import { hilog } from '@kit.PerformanceAnalysisKit';
import Base from '@ohos.base';


@Preview
@Entry
@Component
export struct ConcentrationPage {
  textTimerController: TextTimerController = new TextTimerController()
  @State format: string = 'HH:mm:ss.SS';
  @State isShow: boolean = false; // 新增状态变量用于防止重复提醒
  @State times:number = 0;
  @State progressValue: number = 0    // 设置进度条初始值为0
  @State progressTotal:number = 0;    // 设置进度条目标初始值为0

  @State textShadows: ShadowOptions | Array<ShadowOptions> = [ {
    radius: 10,
    color: Color.Green,
    offsetX: 40,
    offsetY: 0
  }, {
    radius: 10,
    color: Color.Yellow,
    offsetX: 20,
    offsetY: 0
  }]


  // 提醒方法
  aboutToAppear(): void {  //申请通知权限
    let requestEnableNotificationCallback = (err: Base.BusinessError): void => {
      // 处理权限请求结果
      if (err) {
        console.error(`requestEnableNotification failed, code is ${err.code}, message is ${err.message}`);
      } else {
        console.info("requestEnableNotification success");
      }
    }
    // 调用系统通知管理器发起权限请求
    NotificationManager.requestEnableNotification(requestEnableNotificationCallback); //使用callback异步回调
  }

  private  notificationRequest: NotificationManager.NotificationRequest = {// 定义私有通知请求对象
    id: 1,
    content: {
      notificationContentType: NotificationManager.ContentType.NOTIFICATION_CONTENT_BASIC_TEXT,
      normal: {
        title: "专注时间已到",
        text: "专注时间到啦！！！",
        additionalText: "additionalText"
      }
    }
  }

  build() {
      Column() {
        TextTimer({
          isCountDown: true,
          count: this.times,
          controller: this.textTimerController
        })
          .textShadow(this.textShadows)
          .format(this.format)
          .margin({top: 150,bottom: 20,right: 20, left: 20 })
          .fontColor(Color.White)
          .fontSize(50)
          .onTimer((utc: number, elapsedTime: number) => {  //elapsedTime为计时器从0开始计时，经过的时间
            let elapsedtime:number=0;
            elapsedtime=this.times/10;

            this.progressValue = elapsedTime;
            if (this.progressValue >= elapsedtime){  //如果进度条的目标值等于elapsedtime的值，就将进度条重置
              this.progressValue = 0;
            }
            hilog.info(0x0000, 'testTag', '%{public}s', 'progressValue=='+ this.progressValue);
            hilog.info(0x0000, 'testTag', '%{public}s', 'progressTotal=='+ this.progressTotal);

            console.info("textTimer's utc is：" + utc + ", elapsedTime is: " + elapsedTime)
            hilog.info(0x0000, 'testTag', '%{public}s', 'elapsedTime==='+JSON.stringify(elapsedTime));
            hilog.info(0x0000, 'testTag', '%{public}s', 'times==='+JSON.stringify(this.times));

            hilog.info(0x0000, 'testTag', '%{public}s', 'elapsedtime='+JSON.stringify(elapsedtime));
            if (elapsedTime>=elapsedtime&&!this.isShow){  //当倒计时结束时，且状态变量为false时，进入判断。
              this.isShow=true;
              hilog.info(0x0000, 'testTag', '%{public}s', 'times=='+JSON.stringify(elapsedTime));
              hilog.info(0x000, 'notification111', '触发')
              NotificationManager.publish(this.notificationRequest, (err) => {  //触发提醒功能
                if (err) {
                  // 1600004	Notification is not enabled.
                  hilog.info(0x000, 'notification111', JSON.stringify(err))
                  console.error(`[ANS] failed to publish, error[${err}]`);
                  return;
                }
                hilog.info(0x000, 'notification111', '成功')
                console.info(`[ANS] publish success`);
              });
            }
            this.isShow=false;  //提醒后将状态变量置为false
          })
        Text("专注模式")
          .fontColor("#ffe9933f")
          .fontSize(25)
        Progress({
          value: 0,
          total: this.progressTotal,
          type: ProgressType.Ring
        })
          .width(100)
          .height(100)
          .value(this.progressValue)
        Column() {
            Button("TEST(5秒)")
            .type(ButtonType.Normal)
            .margin({ top: 20, bottom: 10 })
            .borderRadius(15)
            .width(160)
            .height(60)
            .fontSize(20)
              .fontColor(Color.White)
              .backgroundColor("#00000000")
            .onClick(() => {
              this.times = 5000 //单位ms
              this.progressTotal=500;
            })
          Row({space:3}) {
            Button("专注30分钟")
              .type(ButtonType.Normal)
              .margin({ top: 20, bottom: 10 })
              .borderRadius(15)
              .width(160)
              .height(60)
              .fontSize(20)
              .fontColor(Color.Blue)
              .backgroundColor("#00000000")
              .onClick(() => {
                this.times = 1800000 //单位ms
                this.progressTotal=180000;
              })
            Button("专注60分钟")
              .type(ButtonType.Normal)
              .margin({ top: 20, bottom: 10 })
              .borderRadius(15)
              .width(160)
              .height(60)
              .fontSize(20)
              .fontColor(Color.Blue)
              .backgroundColor("#00000000")
              .onClick(() => {
                this.times = 3600000 //单位ms
                this.progressTotal=360000;
              })
          }
            Row({space:3}){
            Button("专注90分钟")
              .type(ButtonType.Normal)
              .margin({top: 20, bottom: 10})
              .borderRadius(15)
              .width(160)
              .height(60)
              .fontSize(20)
              .fontColor(Color.Blue)
              .backgroundColor("#00000000")
              .onClick(()=>{
                this.times= 5400000 //单位ms
                this.progressTotal=540000;
              })
            Button("专注120分钟")
              .type(ButtonType.Normal)
              .margin({top: 20, bottom: 10})
              .borderRadius(15)
              .width(160)
              .height(60)
              .fontSize(20)
              .fontColor(Color.Blue)
              .backgroundColor("#00000000")
              .onClick(()=>{
                this.times= 7200000 //单位ms
                this.progressTotal=720000;
              })
          }
          Row({space:3}){
            Button("开始专注")
              .type(ButtonType.Normal)
              .borderRadius(15)
              .width(110)
              .height(60)
              .fontSize(17)
              .fontColor(Color.Blue)
              .backgroundColor("#00000000")
              .onClick(() => {
                this.textTimerController.start()
              })
            Button("暂停")
              .type(ButtonType.Normal)
              .borderRadius(15)
              .width(110)
              .height(60)
              .fontSize(20)
              .fontColor(Color.Blue)
              .backgroundColor("#00000000")
              .onClick(() => {
                this.textTimerController.pause()
              })
            Button("重置")
              .type(ButtonType.Normal)
              .borderRadius(15)
              .width(110)
              .height(60)
              .fontSize(20)
              .fontColor(Color.Blue)
              .backgroundColor("#00000000")
              .onClick(() => {
                this.textTimerController.reset()
                this.progressValue = 0;
              })
          }

        }
      //  .margin({top:10,bottom:20})
      }
      .width("100%")
      .height("100%")
      //.padding(2)
      .backgroundImage($r("app.media.ConcentrationBackground"))
    .backgroundImageSize(ImageSize.Cover)
  }
}