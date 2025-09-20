import ToolBarData from '../ViewModel/ToolBarData';
import { hilog } from '@kit.PerformanceAnalysisKit';

//自定义组件ToolBarBuilder，里面用到的view————ToolBarComponent
@Component
export  default struct ToolBarComponent{

  //ToolBarComponent是子组件，包含主页面的一下3个内容——索引，内容数组，控制器
 @State navCurrentPosition:number=0;
  toolBarConfig:ToolBarData[]=[];
  controller:TabsController=new TabsController();  //可以在主页面使用ToolBarComponent

  build() {

   //回到ToolBarComponent接着写build里面的内容
   Column(){
    Divider()
//     .backgroundColor("#ffff0000")
     .height(1)
     .opacity(1) //透明度，值在【0-1之间】，1代表不透明，0代表完全透明

    Row(){
     ForEach(this.toolBarConfig,(item:ToolBarData)=>{
      Column(){
       //item内容
       Image(this.navCurrentPosition/*当前索引*/===item.num?item.icon:item.img_after)
        .height(24)
        .margin({bottom:18})
        .objectFit(ImageFit.Contain)//设置图片的缩放矢量，让图片显示在边界中

       Text(item.text)
        .fontColor(this.navCurrentPosition===item.num?"#ffff0000":"#ff000000")
        .fontWeight("500")//设置字体粗细，500代表适中
        .fontSize(13)
        .textAlign(TextAlign.Center)

      }
      .width("25%")
      .onClick(()=>{
       //改变当前选中的索引navCurrentPosition，然后通过通过控制器实现索引的变化，切换item
       this.navCurrentPosition=item.num;
       this.controller.changeIndex(this.navCurrentPosition)
       hilog.info(0x0000, 'testTag', '%{public}s', 'item.num==='+item.num);
      })
     },(item:ToolBarData)=>JSON.stringify(item))
    }
   }
  }
}