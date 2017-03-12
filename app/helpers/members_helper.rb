module MembersHelper
	def result_str num
		case num
		when 1 then "我們非常肯定有這位校友（三個欄位都符合），代號 1"
		when 2 then "我們確實有這位校友 （姓名與生日符合），代號 2"
		when 3 then "我們應該是有這位校友 （姓名符合），代號 3"
		when 0 then "無任何符合條件的校友，代號 0"
		end
	end
end
