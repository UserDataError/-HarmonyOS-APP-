import Api from "./Api"
import { promptAction } from "@kit.ArkUI"
import UserApi from "./UserApi"
import { CategoryBean } from "./CategoryApi"

export class ScheduleListBean {
  id: number = 0
  content: string = ""
  categoryId:number = 0  //日程ID
  category: CategoryBean | null = null  //日程类型
}


export default class SchedulesApi {
  static async list(searchKey: string = '') {
    let param: Record<string, Object> = {
      'searchKey': searchKey,
      'userId': UserApi.getUserInfo()?.id ?? 0,
      //'userId': 1,
    }
    const res = await Api.post<ScheduleListBean[]>(`/schedules/list`, param)
    if (res.data) {
      return res.data
    }
    return []
  }

  static async addOrUpdate(content: string, categoryId: number, id: number = 0) {
    let param: Record<string, Object> = {
      'id': id,
      'content': content,
      'categoryId': categoryId,
      'userId': UserApi.getUserInfo()?.id ?? 0,// 空值合并运算符??：当前置结果为null/undefined时，使用默认值0
    }
    const res = await Api.post<boolean>(`/schedules/addOrUpdate`, param)
    if (res.data) {
      return res.data
    }
    if (res.msg && res.msg.length > 0) {
      promptAction.showToast({ message: res.msg, alignment: Alignment.Center })
    } else {
      promptAction.showToast({ message: '提交失败', alignment: Alignment.Center })
    }
    return false
  }

  static async removeById(id: number) {
    return await SchedulesApi.removeBatchByIds([id])
  }

  static async removeBatchByIds(ids: number[]) {
    let param: Record<string, Object> = {
      'ids': ids,
      'userId': UserApi.getUserInfo()?.id ?? 0,
    }
    const res = await Api.post<boolean>(`/schedules/remove`, param)
    if (res.data) {
      return res.data
    }
    if (res.msg && res.msg.length > 0) {
      promptAction.showToast({ message: res.msg, alignment: Alignment.Center })
    } else {
      promptAction.showToast({ message: '删除失败', alignment: Alignment.Center })
    }
    return false
  }
}