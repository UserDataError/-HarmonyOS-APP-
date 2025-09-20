import { preferences } from "@kit.ArkData";
import { common } from "@kit.AbilityKit";

export default class PreferencesApi {
  private static instance: PreferencesApi
  private dataPreferences: preferences.Preferences | null = null

  private constructor() {
  }
  /**
   * 获取单例实例的静态方法
   * @returns PreferencesApi的唯一实例
   */
  public static getInstance(): PreferencesApi {
    if (!PreferencesApi.instance) {
      PreferencesApi.instance = new PreferencesApi()
    }
    return PreferencesApi.instance;
  }
  /**
   * 异步初始化方法（需在首次使用前调用）
   * @param context UIAbility上下文对象
   */
  async init(context: common.UIAbilityContext) {
    try {
      this.dataPreferences = await preferences.getPreferences(context, "myStore")
    } catch (e) {
      console.log(JSON.stringify(e))
    }
  }
  /**
   * 存储对象类型数据
   * @param key 存储键名
   * @param value 要存储的对象（会自动序列化为JSON）
   * @throws 未初始化时抛出错误
   */
  setObject(key: string, value: object) {
    if (!this.dataPreferences) {
      throw new Error('dataPreferences = null')
    }
    this.dataPreferences.putSync(key, JSON.stringify(value))
    this.dataPreferences.flushSync()
  }
  /**
   * 删除指定键的数据
   * @param key 要删除的键名
   * @throws 未初始化时抛出错误
   */
  delete(key: string) {
    if (!this.dataPreferences) {
      throw new Error('dataPreferences = null')
    }
    this.dataPreferences.deleteSync(key)
    this.dataPreferences.flushSync()
  }
  /**
   * 获取存储的对象数据
   * @param key 要获取的键名
   * @returns 反序列化后的对象或null
   */
  getObject<T>(key: string) {
    if (!this.dataPreferences) {
      return null
    }
    const res = this.dataPreferences.getSync(key, "")
    // 处理空值和类型校验
    if (typeof res === 'string' && res.length !== 0) {
      return JSON.parse(res) as T
    }
    return null
  }

  getBoolean(key: string) {
    if (!this.dataPreferences) {
      throw new Error('dataPreferences = null')
    }
    return this.dataPreferences.getSync(key, false) as boolean
  }
  /**
   * 获取布尔值类型数据
   * @param key 要获取的键名
   * @returns 存储的布尔值（默认返回false）
   * @throws 未初始化时抛出错误
   */
  setBoolean(key: string, value: boolean) {
    if (!this.dataPreferences) {
      throw new Error('dataPreferences = null')
    }
    this.dataPreferences.putSync(key, value)
    this.dataPreferences.flush()
  }
}