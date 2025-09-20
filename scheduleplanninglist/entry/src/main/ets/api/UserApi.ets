import Api from "./Api"
import PreferencesApi from "./PreferencesApi"
import { promptAction } from "@kit.ArkUI"


export interface LoginRequest {
  phone: string
  password: string
}

export interface RegisterRequest {
  phone: string
  password: string
  nickname: string
}

@Observed
export class UserInfoBean {
  id: number
  sex: string = ''
  phone: string
  nickname: string
  password: string
  avatar: string
  role: string

  constructor(id: number, nickname: string, phone: string, password: string, avatar: string, role: string) {
    this.id = id
    this.phone = phone
    this.nickname = nickname
    this.password = password
    this.avatar = avatar
    this.role = role
  }
}

export const key_UserInfoBean: string = "UserInfoBean"


export default class UserApi {
  static async list() {
    let param: Record<string, Object> = {
      'userId': UserApi.getUserInfo()?.id ?? 0,
    }
    const res = await Api.post<UserInfoBean[]>(`/users/list`, param)
    if (res.data) {
      return res.data
    }
    return []
  }

  static async register(request: RegisterRequest) {
    const res = await Api.post<boolean>("/users/register", request)
    if (res.data) {
      return res.data
    }
    if (res.msg && res.msg.length > 0) {
      promptAction.showToast({ message: res.msg, alignment: Alignment.Center })
    } else {
      promptAction.showToast({ message: '注册失败', alignment: Alignment.Center })
    }
    return false
  }

  static async login(request: LoginRequest) {
    const res = await Api.post<UserInfoBean>("/users/login", request)
    if (res.data) {
      PreferencesApi.getInstance().setObject(key_UserInfoBean, res.data)
      AppStorage.setOrCreate(key_UserInfoBean, res.data)
    }
    if (res.msg && res.msg.length > 0) {
      promptAction.showToast({ message: res.msg, alignment: Alignment.Center })
    } else {
      promptAction.showToast({ message: '登录失败', alignment: Alignment.Center })
    }
    return res.data
  }

  static async refreshUserInfo() {
    const res = await Api.get<UserInfoBean>(`/users/getUserInfo/${UserApi.getUserInfo()?.id}`)
    if (res.data) {
      PreferencesApi.getInstance().setObject(key_UserInfoBean, res.data)
      AppStorage.setOrCreate(key_UserInfoBean, res.data)
    }
    return res.data
  }

  static async update(nickname: string, password: string, avatar: string, sex: string) {
    let param: Record<string, Object> = {
      'nickname': nickname,
      'password': password,
      'avatar': avatar,
      'sex': sex,
      'id': UserApi.getUserInfo()?.id ?? 0,
    }
    const res = await Api.post<boolean>("/users/update", param)
    if (res.data) {
      return true
    }
    return false
  }

  static isLogin() {
    let res = PreferencesApi.getInstance().getObject<UserInfoBean>(key_UserInfoBean)
    AppStorage.setOrCreate(key_UserInfoBean, res)
    return res != null
  }

  static getUserInfo() {
    return AppStorage.get<UserInfoBean>(key_UserInfoBean)
  }


  static async checkUserExist(id: number) {
    let param: Record<string, Object> = {
      'id': id,
    }
    const res = await Api.post<UserInfoBean>(`/users/checkUserExist`, param)
    if (res.data) {
      return res.data
    }
    return null
  }

}
