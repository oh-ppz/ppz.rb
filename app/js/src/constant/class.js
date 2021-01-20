// html 元素的 class

module.exports = new Proxy({

}, {
  set(){
    throw Error('这是一个常数，不可对其设置值')
  }
})
