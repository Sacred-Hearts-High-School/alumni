require 'csv'
require 'roo'

class Member < ApplicationRecord

  def self.import(file)
    
    allowed_attributes = ["name","email","subjects"]
    xlsx = open_spreadsheet(file)
    p xlsx.info   

    # 開啟每一個分頁進行處理
    xlsx.sheets.each do |sheet|
    	s = xlsx.sheet(sheet)  # 每個分頁
    
    	(5..s.last_row).each do |i|
    		@member = Member.find_by(no: s.row(i)[0], name: s.row(i)[1], birthday: s.row(i)[2])
    		@member = Member.new(no: s.row(i)[0], name: s.row(i)[1], birthday: s.row(i)[2]) if @member.nil?
    		@member.pid = s.row(i)[3] if s.row(i)[3]
    		@member.remark = s.row(i)[4] if s.row(i)[4]
    		@member.department = 2  # 高中
    		@member.save
    	end
    end
  end
  
  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
        when '.csv' then Roo::CSV.new(file.path)
        #when '.xls' then Roo::Excel.new(file.path, packed:false, file_warning: :ignore)
        when '.xlsx' then Roo::Excelx.new(file.path)
        else raise "不支援這個檔案格式: #{file.original_filename}"
    end
  end

end
