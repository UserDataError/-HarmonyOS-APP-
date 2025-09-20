import { http } from "@kit.NetworkKit"

const BASE_URL: string = "http://172.25.160.1:9000/api"

export interface CommonHttpPageRes<T> {
  current: number
  pages: number
  size: number
  total: number
  records: T[]
}

export class CommonHttpRes<T> {
  data: T | null
  msg: string
  code: number

  constructor(data: T | null, msg: string, code: number) {
    this.data = data
    this.code = code
    this.msg = msg
  }

  static ok<T>(data: T | null = null): CommonHttpRes<T> {
    return new CommonHttpRes<T>(data, '', 0)
  }

  static error<T>(): CommonHttpRes<T>

  static error<T>(code: number, msg: string): CommonHttpRes<T>

  static error<T>(code?: number, msg?: string): CommonHttpRes<T> {
    return new CommonHttpRes<T>(null, msg ?? '', code ?? 500)
  }
}

export default class Api {
  static async get<T>(path: string) {
    return await Api.request<T>(path, http.RequestMethod.GET)
  }

  static async delete<T>(path: string) {
    return await Api.request<T>(path, http.RequestMethod.DELETE)
  }

  static async post<T>(path: string, param?: object) {
    return await Api.request<T>(path, http.RequestMethod.POST, param)
  }
  // 通用请求方法
  static async request<T>(path: string, method: http.RequestMethod, param?: object) {
    const httpRequest = http.createHttp()
    const url = `${BASE_URL}${path}`
    try {
      const response = await httpRequest.request(url, {
        method: method,
        header: {
          "Content-Type": "application/json"
        },
        extraData: param ? JSON.stringify(param) : undefined
      })
      if (response.responseCode === http.ResponseCode.OK) {
        if (typeof response.result === 'string') {
          return JSON.parse(response.result) as CommonHttpRes<T>
        } else {
          return CommonHttpRes.error<T>()
        }
      } else {
        return CommonHttpRes.error<T>(response.responseCode, '')
      }
    } catch (e) {
      return CommonHttpRes.error<T>(500, JSON.stringify(e))
    } finally {
      httpRequest.destroy()
    }
  }

  static async uploadFile<T>(fileName: string, filePath: string) {
    const httpRequest = http.createHttp()
    const url = `${BASE_URL}/upload/img`
    try {
      const response = await httpRequest.request(url, {
        method: http.RequestMethod.POST,
        header: {
          'content-Type': "multipart/form-data"
        },
        multiFormDataList: [
          {
            name: "file",
            contentType: "image/jpeg",
            remoteFileName: fileName,
            filePath: filePath
          }
        ]
      })
      if (response.responseCode === http.ResponseCode.OK) {
        if (typeof response.result === 'string') {
          return JSON.parse(response.result) as CommonHttpRes<T>
        } else {
          return CommonHttpRes.error<T>()
        }
      } else {
        return CommonHttpRes.error<T>(response.responseCode, '')
      }
    } catch (e) {
      return CommonHttpRes.error<T>(500, JSON.stringify(e))
    } finally {
      httpRequest.destroy()
    }
  }
}