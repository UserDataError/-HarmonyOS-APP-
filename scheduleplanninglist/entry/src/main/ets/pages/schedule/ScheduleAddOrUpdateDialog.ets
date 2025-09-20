import CategoryApi, { CategoryBean } from "../../api/CategoryApi"
import SchedulesApi, { ScheduleListBean } from "../../api/SchedulesApi"
import { promptAction } from "@kit.ArkUI"

interface TabType {
  name: string
  type: number
}

@Entry
@Component
@CustomDialog
export struct ScheduleAddOrUpdateDialog {
  controller?: CustomDialogController
  @Link
  curSchedule: ScheduleListBean | null
  @State
  tabList: TabType[] = [{
    name: "工作",
    type: 0,
  }, {
    name: "娱乐",
    type: 1,
  }]
  @State
  dataList: CategoryBean[] = []
  @State
  curIndex: number = 0
  onSuccess: () => void = () => {
  }

  aboutToAppear(): void {
    this.getList()
  }

  async getList() {
    this.dataList = await CategoryApi.list()
  }

  @Builder
  TabBuilder(index: number, text: string) {
    Column() {
      Text(text)
        .fontSize("16vp")
        .fontColor(this.curIndex === index ? "#ff003cff" : "#ff989090")
    }

    .width("48vp")
    .padding({ top: "17vp", bottom: "8vp" })
    .margin({ bottom: "8vp" })
    .border({
      width: { bottom: this.curIndex === index ? "2vp" : "" },
      color: this.curIndex === index ? "#ff003cff" : "#fffdfdfd"
    })

  }

  async submit() {
    if (!this.curSchedule) {
      return
    }
    if (this.curSchedule.categoryId === 0) {
      promptAction.showToast({ message: "账目类型不能为空" })
      return
    }
    if (this.curSchedule.content.length === 0) {
      promptAction.showToast({ message: "输入内容不能为空" })
      return
    }

    const res =
      await SchedulesApi.addOrUpdate(this.curSchedule.content, this.curSchedule.categoryId, this.curSchedule.id)
    if (res) {
      this.onSuccess?.()
      this.controller?.close()
    }
  }

  build() {
    Column() {
      Stack() {
        Image($rawfile("half.png"))
          .width(64)
          .height(24)
          .onClick(() => {
            this.controller?.close()
          })
      }.width("100%")

      Tabs({ index: $$this.curIndex }) {
        ForEach(this.tabList, (tab: TabType, index) => {
          TabContent() {
            Grid() {
              ForEach(this.dataList.filter(e => e.type === tab.type), (item: CategoryBean) => {
                GridItem() {
                  Stack() {
                    Column({ space: 8 }) {
                      Image(this.curSchedule?.categoryId === item.id ? item.iconSelected : item.icon)
                        .width(48)
                        .aspectRatio(1)
                      Text(item.name)
                        .fontSize(12)
                        .fontColor(this.curSchedule?.categoryId === item.id ? "#ffd7d0d0" : "#ff0048ff")
                    }
                    .width(86)
                    .aspectRatio(1)
                    .justifyContent(FlexAlign.Center)
                    .borderRadius(16)
                    .backgroundColor(this.curSchedule?.categoryId === item.id ? "#ff0048ff" : "#ffd7d0d0")
                  }
                  .width("100%")
                  .onClick(() => {
                    if (this.curSchedule) {
                      this.curSchedule.categoryId = item.id
                    } else {
                      this.curSchedule = new ScheduleListBean()
                      this.curSchedule.categoryId = item.id
                    }
                  })
                }.width("100%").aspectRatio(1)
              })
            }.width("100%").columnsTemplate('repeat(3,1fr)')// 设置网格为3列等宽布局
          }
          .tabBar(this.TabBuilder(index, tab.name))
        })
      }
      .width("100%").height("45%")

      Text("待办").fontSize(20).fontColor("#ff1c1b1b")
      Row().height(12)
      TextArea({ placeholder: "请输入安排", text: this.curSchedule?.content })
        .padding({
          left: 0,
        })
        .borderRadius(0)
        .backgroundColor("#fff").onChange((value) => {
        if (this.curSchedule) {
          this.curSchedule.content = value
        } else {
          this.curSchedule = new ScheduleListBean()
          this.curSchedule.content = value
        }
      }).height("25%")
      Row().width("100%").height(1).backgroundColor("#ccc")
      Row().height(12)
      Button("保存").width("100%").onClick(() => {
        this.submit()   //将数据传入后端
      })
    }
    .width("100%")
    .alignItems(HorizontalAlign.Start)
    .height("55%")
    .padding({ left: 12, right: 12})
    .borderRadius({ topLeft: 24, topRight: 24 })
    .backgroundColor(Color.White)
  }
}