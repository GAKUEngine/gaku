module Gaku::CountHelper

  def count_div(html_class, &block)
    content_tag :h3, class: "mt-xs #{html_class}" do
      block.call
    end
  end

  def print_count(count, text)
    count != 0 ? text + '(' + count.to_s + ')' : text
  end

end