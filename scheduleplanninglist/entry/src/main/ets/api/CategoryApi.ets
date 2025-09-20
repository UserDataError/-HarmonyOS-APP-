import Api from './Api'

export class CategoryBean {
  id: number = 0
  name: string = ''
  icon: string = ''
  type: number = 0
  iconSelected: string = ''
}

export default class CategoryApi {
  static async list() {
    const param: Record<string, Object> = {}
    const res = await Api.post<CategoryBean[]>("/categories/list", param)
    if (res.data) {
      return res.data
    }
    return []
  }
}