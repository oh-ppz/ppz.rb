module.exports = class extends Error{
  constructor(){
    super('尝试实例化一个没有 init 方法的类')
  }
}