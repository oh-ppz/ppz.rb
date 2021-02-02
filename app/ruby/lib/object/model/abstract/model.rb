require_relative '../common/escape'

class AbstractModel
  def self.from_line line # 静态方法，从“输入行”里实例化一个 model
    if match_data = self::REG_EXP.match(line)
      self.new match_data.post_match
    else
      nil
    end
  end

  # 加粗、斜体、链接等
  def transform_inline_element str
    str = str + ''
    # 因为加粗、斜体等，会生成 html 代码，为了不使“用户原本输入的 html”和“生成的 html”冲突，因此先把“用户输入的 html 转义
    Escape.html_char! str
    
    # 变粗等，使用特殊字符比如 *，来标识
    # 但这会使用户想输入 * 时，形成歧义
    # 因此，用户向输入 *（而不是变斜时），可以输入 \*

    # 所以此流程
    # 先把 * 等特殊字符转义（\* -> 某种形式）
    # 再识别哪些变斜，哪些变粗
    # 再把用户原来想输入的 * 放到字符串里（某种形式 -> *)

    Escape.ppz_char! str # 把用户输入的 \* 转义 => 剩下的 *** 就肯定是 斜体加粗 了

    # + 斜体和加粗
    str.gsub! /\*\*\*(.+)\*\*\*/, '<b><i>\1</i></b>'
    # + 加粗
    str.gsub! /\*\*(.+)\*\*/, '<b>\1</b>'
    # + 斜体
    str.gsub! /\*(.+)\*/, '<i>\1</i>'
    # + 行内块
    str.gsub! /```([^(```)]+)```/, '<span class="special-txt">\1</span>'
    # + 图片 先图片后链接
    str.gsub! /!\[([^\]]*)\]\(([^\)]+)\)/, '<img title="\1" src="\2" />'
    # + 链接 先图片后链接
    str.gsub! /\[([^\]]+)\]\(([^\)]+)\)/, '<a href="\2" title="\2">\1</a>'
    
    Escape.transform_to_real! str
  end
end