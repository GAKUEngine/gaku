if Gaku::StudentConfig.count.zero?
  Gaku::StudentConfig.create!(active: true)
end