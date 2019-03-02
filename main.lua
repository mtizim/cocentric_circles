-- requires love2d, preferably 11+
Class = require("dependencies.30log")
circleClass = Class("circle")

-- window width, height
love.window.setMode(0,0,{fullscreen = true})
ww, wh = love.graphics.getDimensions()
-- biggest radius
rstart = wh/2
-- starting angular velocity
ostart = 1
-- every next circle radius multiplier
rscale = 0.5
-- every next circle angvel multiplier
oscale = 1
circle_count = 5


function circleClass:init(xrel,yrel,r,omega,childnum,parent)
    self.xrel = xrel
    self.yrel = yrel
    self.omega = omega
    self.r = r
    self.rotation = 0
    if childnum > 0 then
        self.kid = circleClass(0,r*(1-rscale),r*rscale,omega*oscale,childnum-1,self)
        self.kid2 = circleClass(0,-r*(1-rscale),r*rscale,omega*oscale,childnum-1,self)
    end
end

function circleClass:update(dt)
    self.rotation = self.rotation + self.omega * dt
    if self.kid then
        self.kid:update(dt)
        self.kid2:update(dt)
    end
end

function circleClass:draw()
    -- coordinate translation and rotation
    love.graphics.translate(self.xrel,self.yrel)
    love.graphics.rotate(self.rotation)
    -- drawing
    love.graphics.circle("line",0,0,self.r)
    if self.kid then
        love.graphics.push()
        self.kid:draw()
        love.graphics.pop()
        love.graphics.push()
        self.kid2:draw()
        love.graphics.pop()
    end
end




function love.load()
    maincircle = circleClass(0,0,rstart,ostart,circle_count,nil)
end

function love.update(dt)
    maincircle:update(dt)
end

function love.draw()
    love.graphics.setBackgroundColor(0,0,0)
    love.graphics.push()
    love.graphics.translate(ww/2,wh/2)
    love.graphics.setColor(1, 1, 1)
    maincircle:draw()
    love.graphics.pop()
end