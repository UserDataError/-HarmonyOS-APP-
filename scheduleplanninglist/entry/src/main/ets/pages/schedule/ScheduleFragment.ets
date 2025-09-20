import SchedulesApi, { ScheduleListBean } from "../../api/SchedulesApi"
import { ScheduleAddOrUpdateDialog } from "./ScheduleAddOrUpdateDialog"
import { promptAction } from "@kit.ArkUI"

@Preview
@Component
export struct ScheduleFragment {
  @State
  isRefreshing: boolean = false
  @State
  isEdit: boolean = false
  @State
  dataList: ScheduleListBean[] = []
  @State
  searchKey: string = ""
  @State
  checkList: Set<number> = new Set([])
  @State
  curSchedule: ScheduleListBean | null = null
  private dialogController: CustomDialogController | null =
    new CustomDialogController({
      builder: ScheduleAddOrUpdateDialog({
        curSchedule: this.curSchedule, onSuccess: () => {  //操作成功回调getList()
          this.getList()
        }
      }),
      customStyle: true,
      alignment: DialogAlignment.Bottom  // 对话框底部弹出
    })

  aboutToAppear(): void {
    this.getList() //进入页面自动调用搜索方法
  }

  @Builder
  itemEnd(item: ScheduleListBean) {  //右划删除
    Stack() {
      Button("删除").backgroundColor(Color.Red).onClick(() => {
        this.delete(item)
      })
    }
  }

  async delete(item: ScheduleListBean) {   //删
    const res = await SchedulesApi.removeById(item.id)
    if (res) {
      this.getList() //删除后查询所有日程
    }
  }

  async getList() {   //查
    this.dataList = await SchedulesApi.list(this.searchKey)
    this.isRefreshing = false
  }

  addItem() {
    this.curSchedule = null
    this.dialogController?.open()
  }

  deleteItem() {
    if (this.checkList.size === 0) {  //未选日程提示
      promptAction.showToast({ message: '请选择要删除日程', alignment: Alignment.Center })
      return
    }
    this.getUIContext().showAlertDialog({
      message: "确定要删除吗？", confirm: {
        value: "确定",
        action: async () => {
          const success = await SchedulesApi.removeBatchByIds(Array.from(this.checkList))// 调用API批量删除接口，传入选中项的ID数组
          if (success) {
            promptAction.showToast({ message: '删除成功', alignment: Alignment.Center })
            this.checkList.clear()// 清空选中列表
            this.isEdit = false
            this.getList()// 刷新日程列表数据
          }
        }
      }
    })
  }

  build() {
    RelativeContainer() {
      Column() {
        Row() {
          Text("日程")
            .fontSize(24)
          Image($rawfile("ic_public_edit.svg"))
            .width(24)
            .aspectRatio(1)
            .onClick(() => {
              this.isEdit = !this.isEdit  // 切换编辑状态
              if (!this.isEdit) {
                this.checkList.clear() //退出编辑状态时清空选择
              }
            })
        }
        .width("100%")
        .padding({ left: 12, top: 12, right: 12 })
        .justifyContent(FlexAlign.SpaceBetween)

        Row().height(8)
        Row() {
          Search({ placeholder: "请输入关键词搜索", value: this.searchKey })  // value绑定搜索关键词
            .onSubmit(() => {
              this.getList()
            })
            .onChange((value) => {
              this.searchKey = value
              if (this.searchKey.length === 0) {
                this.getList()
              }
            })
            .width("100%")
        }
        .width("100%")
        .padding({ left: 12, right: 12 })

        Refresh({ refreshing: $$this.isRefreshing }) {
          List() {
            ForEach(this.dataList, (item: ScheduleListBean) => {
              ListItem() {
                Row({ space: 12 }) {
                  Image(`${item.category?.icon}`)
                    .width(48)
                    .aspectRatio(1)
                  Text(`${item.category?.name}`)

                  if (this.isEdit) {
                    Blank()
                    Toggle({ type: ToggleType.Checkbox })
                      .onChange((isOn) => {
                      if (isOn) {
                        this.checkList.add(item.id)
                      } else {
                        this.checkList.delete(item.id)
                      }
                    })
                  } else {
                    Text(`${item.content}`)
                      .fontSize(16)
                      .layoutWeight(1)
                      .maxLines(1)
                      .fontColor(item.category?.type === 0 ? "#ffff0000" : "#ff01fc2b")
                      .textOverflow({ overflow: TextOverflow.Ellipsis })
                      .textAlign(TextAlign.End)
                  }
                }
                .width("100%")
                .height(56)
                .onClick(() => {   //改   点击打开日程项
                  this.curSchedule = item
                  this.dialogController?.open()
                })
              }.swipeAction({  // 右滑操作
                end: {
                  builder: () => {
                    this.itemEnd(item)
                  }
                }
              })
            })
          }
          .width("100%")
          .height("100%")

          .padding({ left: 12, right: 12 })
          .divider({ color: "#ccc", strokeWidth: 1 })
        }
        .width("100%")
        .layoutWeight(1)
        .onRefreshing(() => {  //刷新
          this.getList()
        })
      }
      .width("100%")
      .height("100%")

      if (this.isEdit) {
        Button() {
          Image($rawfile('delete.png'))
        }
        .width(48)
        .aspectRatio(1)
        .onClick(() => {
          this.deleteItem()//删除
        })
        .alignRules({
          bottom: { anchor: "__container__", align: VerticalAlign.Bottom },// anchor：以父容器作为锚点
          left: { anchor: "__container__", align: HorizontalAlign.Start },
          right: { anchor: "__container__", align: HorizontalAlign.End },
        })
        .margin({ bottom: 24 })
      } else {
        Button() {
          Image($rawfile('add.png'))  //添加日程图标
        }
        .width(48)
        .aspectRatio(1)
        .alignRules({
          bottom: { anchor: "__container__", align: VerticalAlign.Bottom },
          right: { anchor: "__container__", align: HorizontalAlign.End },
        })
        .margin({ right: 24, bottom: 24 })
        .onClick(() => {
          this.addItem()  //添加日程
        })
      }


    }.width("100%")
    .height("100%")
  }
}