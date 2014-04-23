def uploaded_file(filename)
  ActionDispatch::Http::UploadedFile.new(
                                         tempfile: File.new("#{Rails.root}/../support/#{filename}"),
                                         filename: filename
                                         )
end
