const Base = require('./base')

module.exports = class extends Base {
  // 重写，加入子元素时，设置 id、tagName
  append(el){
    if(!this.appended) // h 元素的 id 用于索引元素
      throw Error('请先把 h 元素添加到父级元素')

    el.attr.id = this.id + '-' + (this.children.length + 1)
    el.hIndex = this.hIndex + 1
    el.tagName = 'h' + el.hIndex
    return super.append(el)
  }
}