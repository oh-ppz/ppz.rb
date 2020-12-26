const Children = require('../common/children')

module.exports = class {
  constructor(tagName = 'div', content, attr = {}) { // 解构写法，意味着，必须有一个参数
    this.tagName = tagName
    this.content = content
    this.attr = attr
    this.children = new Children()
  }

  // 把 el 加入到 children
  append(el){
    this.children.push(el)
    return this
  }

  // 设置整个 children
  setChildren(target){
    this.children = target
    return this
  }

  // 核心 tag 的 html
  getTag(){
    let attrStr = ''
    if(this.attr)
      for(let key in this.attr)
        result += ` ${key}="${this.attr[key]}"`
    return `<${this.TagName}${attrStr}>${this.content}</${this.tagName}>` 
  }

  toString(){
    return this.getTag()
  }
}