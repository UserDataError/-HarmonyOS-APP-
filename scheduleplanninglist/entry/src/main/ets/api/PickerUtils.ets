import { photoAccessHelper } from "@kit.MediaLibraryKit"
import { fileIo, picker } from "@kit.CoreFileKit"

export default class PickerUtils {
  static async pickerImg(context: Context, fileName: string) {
    const photoSelectOptions = new photoAccessHelper.PhotoSelectOptions()
    photoSelectOptions.MIMEType = photoAccessHelper.PhotoViewMIMETypes.IMAGE_TYPE
    photoSelectOptions.maxSelectNumber = 1
    // 创建相册选择器实例
    const photoViewPicker = new photoAccessHelper.PhotoViewPicker()
    try {
      const uris = await photoViewPicker.select(photoSelectOptions)
      if (uris.photoUris.length === 0) {
        return ''
      }
      const uri = uris.photoUris[0]
      const sourceFile = await fileIo.open(uri)
      const destFilePath = `${context.cacheDir}/${fileName}`
      const destFile = await fileIo.open(destFilePath, fileIo.OpenMode.READ_WRITE | fileIo.OpenMode.CREATE)
      await fileIo.copyFile(sourceFile.fd, destFile.fd)
      return destFilePath
    } catch (e) {
      console.log(JSON.stringify(e))
    }
    return ""
  }
  /**
   * 通过文件管理器选择图片（返回原始URI）
   * @param context 应用上下文对象
   * @returns 返回原始文件URI（失败返回空字符串）
   */
  static async pickerOnePicToAppCache(context: Context) {
    const documentSelectOptions = new picker.DocumentSelectOptions()
    documentSelectOptions.maxSelectNumber = 1
    documentSelectOptions.fileSuffixFilters = ['.png', 'jpg', '.jpeg', ".svg"]// 文件类型过滤
    const documentViewPicker = new picker.DocumentViewPicker(context)
    try {
      const uris = await documentViewPicker.select(documentSelectOptions)
      if (uris.length === 0) {
        return ""// 用户取消选择
      }
      const uri = uris[0]
      return uri
    } catch (e) {
      console.log(JSON.stringify(e))
    }
    return ""
  }
}