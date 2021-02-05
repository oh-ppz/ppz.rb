target_out = Pathname TARGET_OUT

# css
  # 输出文件路径
  output_css_path = target_out + 'index.css'
  # 复制
  FileUtils.cp PPZMain::CSS_FILE_PATH, output_css_path

# html
  # 输出文件路径
  output_html_path = target_out + 'index.html'
  # 解析文档
  parser = PPZ::FileDocParser.new TARGET_IN
  # 拼接上 css 文件链接
  output_html = '<link rel="stylesheet" href="./index.css"/>' + parser.get_model.to_html 
  # 输出
  PPZ::Func::write_to_file output_html_path.to_s, output_html