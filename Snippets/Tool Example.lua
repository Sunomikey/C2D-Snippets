function Blueprint:Build()
  
	self.activated = false
  self.left = false
  self.aim_point = VectorF()
	
	-- Pioneer's script will call these functions to control the tool
	-- add code to these
	
	self.OnToolActivate = function()
		print("tool picked up")
		self.activated = true
    
    local mo = self:GetMasterMO()
 		mo:SetBalancer(true)
	end

	function self.OnToolDeactivate()
		print("tool dropped")
		self.activated = false
    
    local mo = self:GetMasterMO()
 		mo:SetBalancer(false)
	end

	function self.ToolLeftButtonPress()
    print("left pressed")
		self.left = true
	end

	function self.ToolLeftButtonRelease()
    print("left released")
    self.left = false
	end

	function self.ToolAimPoint(tool_aim_point)
		self.aim_point = tool_aim_point
	end
  
  --balance tool to mouse aim
  function self.balanceToAimPoint()
    local mo = self:GetMasterMO()
    if mo then
      mo:SetBalancerPower(10000)
      local vec = self.aim_point - mo:GetPosition()
      local angle = -vec:GetAngleRad()
      if self:IsMirrored() then angle = angle + math.pi end
      mo:SetBalanceToAngle(angle)
    end
  end

end



function Blueprint:Update()

	if self.activated then
    --do this if the tool is in pios hands now
		self.balanceToAimPoint()
    
    --add code here
    if self.left then
      print("left held, mouse at: ", self.aim_point)
    end
   
	end

end