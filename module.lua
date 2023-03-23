local main = {
	["Builds"]={},
	["UserDeesigned"]={},
	["Internal"]={"Erroring this will stop the script."}
}
function main.Internal.stop()
	error("Main module was forced to stop")
end
function main.Internal.check(meta:string,value)
	local ret = nil
	if meta == "VECTOR" then
		local vector = {["X"]=0,["Y"]=0,["Z"]=0}
		if type(value) == 'vector' then
			if not value.X then
				vector.X = 0
			else
				vector.X = value.X
			end
			if not value.Y then
				vector.Y = 0
			else
				vector.Y = value.Y
			end
			if not value.Z then
				vector.Z = 0
			else
				vector.Z = value.Z
			end
		else
			if type(value) == 'table' then
				if #value > 0 then
					warn(vector)
					if #value < 2 then
						vector.X = value[1]
					else
						vector.X = 0
					end
					if #value < 3 then
						vector.Y = value[2]
					else
						vector.Y = 0
					end
					if #value < 4 then
						vector.Z = value[3]
					else
						vector.Z = 0
					end
				end
			end
		end
		ret=Vector3.new(vector.X,vector.Y,vector.Z)
	end
	return ret
end
function main.Builds.Elevator(CFrames:"Table",advancedMovement:boolean,Model:Model,speed: number)
	local status = true
	spawn(function()
		if Model then
			if Model.PrimaryPart then
				if CFrames then
					if #CFrames > 0 then
						local mod = Model:Clone()
						mod.Parent = game.Workspace
						mod:SetPrimaryPartCFrame(main.Internal.check("VECTOR",CFrames[1][1]))
						local currentFloor = 1
						local e = {["EVENT"]={},["INTERNAL"]={}}
						function e.INTERNAL.FLOOR(num)
							if num ~= currentFloor  then
								local step = 0
								if currentFloor < num then
									step = -1
								else
									step = 1
								end
								for c=currentFloor,num,step do
									local start = CFrames[currentFloor]
									mod:SetPrimaryPartCFrame(main.Internal.check("VECTOR",CFrames[currentFloor][1]))
									--MAKE ELEVATOR LERP TO FLOOR
								end
								
							end
						end
						function e.EVENT.floor(number)
							e.INTERNAL.FLOOR(number)
						end
					else
						status = "there are no positions"
					end
				else
					status = "Positions are invalid"
				end
			else
				status = "Model doesn't have Primery Part"
			end
		else
			status = "There  is not a model"
		end
	end)
	return status
end
return main
