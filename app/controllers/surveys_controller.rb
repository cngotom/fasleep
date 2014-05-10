class SurveysController < ApplicationController
	def create
		#answers = params['survey']

		@type = get_types(params['survey'])

		render 'site/fenxi'
	end


	protected

	def get_types(_answers)
		scores = [4,3,1,0]

		answers = {}

		_answers.each do |k,v|
			answers[k] = v.to_i
		end

		#如果第17题选C，则输出：“您目前不适合在本场所进行相关的保健工作，请在适当的时候再来做保健。”否则，进行到下一步
		if answers['answer_16'] == 2
			type = type = "F-E1"
		#answers
		puts answers
		elsif answers['answer_0'] == 0 
			score_x =  scores[answers['answer_5']] + scores[answers['answer_6']] + scores[answers['answer_7']]  + scores[answers['answer_8']] + scores[answers['answer_9']]

			score_x = score_x * 5		


			score_y = scores[answers['answer_3']] +  scores[answers['answer_4']] + scores[answers['answer_5']] + scores[answers['answer_14']]  + scores[answers['answer_15']]
			score_y = score_y * 5	


			score_z = scores[answers['answer_2']] +  scores[answers['answer_10']] + scores[answers['answer_11']] + scores[answers['answer_13']] 
			score_z = score_z * 100 / 16	

			#get score
			max_score = score_x
			max_score = score_y if score_y > max_score
			max_score = score_z if score_z > max_score

		
			if max_score > 50

				if score_x == score_y && score_y == score_z && score_y == max_score
					if answers['answer_1'] > 1
						type = "F-3" 
					else
						type = "F-2"
					end
				elsif score_x == score_z && score_z == max_score
					if answers['answer_1'] > 1
						type = "F-3" 
					else
						type = "F-1"
					end

				#y=z
				elsif score_z == score_y  && score_y == max_score
					if answers['answer_1'] > 1
						type = "F-3" 
					else
						type = "F-2"
					end
				#x=y
				elsif score_x == score_y  && score_y == max_score

					type = "F-2"
				else
						type = "F-1" if max_score == score_x
						type = "F-2" if max_score == score_y
						type = "F-3" if max_score == score_z
				
				end

			elsif max_score > 25
				type = "F-5"
			else
				type = "F-E0"
			end

		#female
		else
			score_x = scores[answers['answer_5']] + scores[answers['answer_6']] + scores[answers['answer_7']]  + scores[answers['answer_8']] + scores[answers['answer_9']] + scores[answers['answer_12']]

			score_x = score_x * 100.0 / 24		


			score_y = scores[answers['answer_3']] +  scores[answers['answer_4']] + scores[answers['answer_5']] + scores[answers['answer_14']]  + scores[answers['answer_15']]
			score_y = score_y * 5	


			score_z = scores[answers['answer_2']] +  scores[answers['answer_10']] + scores[answers['answer_11']] + scores[answers['answer_13']] 
			score_z = score_z * 100.0 / 16	

			#get score
			max_score = score_x
			max_score = score_y if score_y > max_score
			max_score = score_z if score_z > max_score

			if max_score > 50
				if score_x == score_y && score_y == score_z && score_y == max_score
					if answers['answer_1'] > 1
						type = "F-3" 
					else
						type = "F-1"
					end
				elsif score_x == score_z && score_z == max_score
					if answers['answer_1'] > 1
						type = "F-3" 
					else
						type = "F-1"
					end

				#y=z
				elsif score_z == score_y  && score_y == max_score
					if answers['answer_1'] > 1
						type = "F-3" 
					else
						type = "F-2"
					end
				#x=y
				elsif score_x == score_y  && score_y == max_score
					type = "F-1"
				else
						type = "F-1" if max_score == score_x
						type = "F-2" if max_score == score_y
						type = "F-3" if max_score == score_z
				end
			elsif max_score > 25
				type = "F-5"
			else
				type = "F-E0"
			end

		end
		
		return type
	end
end
	

=begin
1.肝郁血虚型：女性居多。

典型症状：脾气急（7），小心眼，想得到，管得多，睡觉轻（6），做梦多（8），兼有血虚的症状：气色差（10），月经不调（13），掉头发多（9）。

2.胆热痰湿型：男性居多，女性也不少，可以作为首选方

典型症状：入睡困难（4），易醒（6），白天乏力没精神（5），容易受惊吓感（16），抑郁焦虑（15）。

3.气虚血瘀型：老年人居多

典型症状：血液循环不好，脑供血不足（14），健忘（12），头晕（11），睡眠少（3）。

一、 针对选项进行赋值：A=4分，B=3分，C=1，D=0

二、 如果第17题选C，则输出：“您目前不适合在本场所进行相关的保健工作，请在适当的时候再来做保健。”否则，进行到下一步。

三、 对于男性，1的满分为20分，2的满分为20分，3的满分为16分

1. 把1对应的6，7，8，9，10得分相加，总和除以20乘以100得总分X

2. 把2对应的4，5，6，15，16得分相加，总和除以20乘以100得总分Y

3. 把3对应的3，11，12，14得分相加，总和除以16乘以100得总分Z

4. 对比X、Y、Z，取最大值，

1) 若最大值大于50，且对应的是X，则输出F-1方

2) 若最大值大于50，且对应的是Y，则输出F-2方

3) 若最大值大于50，且对应的是Z，则输出F-3方

4) 若最大值小于50且大于25，则输出F-5方

5) 若最大值小于25，则输出：“恭喜您！您暂时不需要在快睡好眠做保健！”

6) 若X=Y，则输出F-2方

7) 若Y=Z，当年龄选择在C或D时，则输出F-3方；当年龄选择在A或B时，则输出F-2方

8) 若X=Z，当年龄选择在C或D时，则输出F-3方；当年龄选择在A或B时，则输出F-1方

9) 若X=Y=Z，当年龄选择在C或D时，则输出F-3方；当年龄选择在A或B时，则输出F-2方

四、 对于女性，1的满分为24分，2的满分为20分，3的满分为16分

1. 把1对应的6，7，8，9，10，13得分相加，总和除以24乘以100得总分X

2. 把2对应的4，5，6，15，16得分相加，总和除以20乘以100得总分Y

3. 把3对应的3，11，12，14得分相加，总和除以16乘以100得总分Z

4. 对比X、Y、Z，取最大值，

a) 若最大值大于50，且对应的是X，则输出F-1方

b) 若最大值大于50，且对应的是Y，则输出F-2方

c) 若最大值大于50，且对应的是Z，则输出F-3方

d) 若最大值小于50且大于25，则输出F-5方

e) 若最大值小于25，则输出：“恭喜您！您暂时不需要在快睡好眠做保健！”

f) 若X=Y，则输出F-1方

g) 若Y=Z，当年龄选择在C或D时，则输出F-3方；当年龄选择在A或B时，则输出F-2方

h) 若X=Z，当年龄选择在C或D时，则输出F-3方；当年龄选择在A或B时，则输出F-1方

i) 若X=Y=Z，当年龄选择在C或D时，则输出F-3方；当年龄选择在A或B时，则输出F-1方。
=end