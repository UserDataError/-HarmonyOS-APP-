//写一个数组，索引变量，控制器,viewModel——ToolBarData

export default class ToolBarData{
  num:number=0;
  text:string="日程";
  img_after:Resource=$r("app.media.schedule") ;//未选中时的状态
  icon:Resource=$r("app.media.schedule_selected");//选中时的状态

}