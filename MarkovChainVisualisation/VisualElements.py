colors = ["0xA31F34", "0xF09CA9", "0xFFFFFF"]

radiusOffset = 1.1
arrowRatio = 2.25
thikness = 6.0

from Curves import ComplexBezier

class Markov:
    
    def render(self):
        
        for n in range(0, len(self.nodes)):
            
            node = list(self.nodes)[n]
            node.render()
            
        for l in range(0, len(self.links)):
            
            link = list(self.links)[l]
            
            if link.type == "direct":
                
                d = DirectLink(link.a, link.b)
                d.render()
            
            elif link.type == "paired":
                
                p = PairedLink(link.a, link.b)
                p.render()
                
            elif link.type == "self":
                
                s = SelfClosingLink(link.a, self.x, self.y, self.radius)
                s.render()
                
            else:
                
                println("The link type is undefined")

          
    def getN(self, data_):
        
        N = 0
        for i in range(0, len(data_)):
            
            N = max(N, list(data_)[i][0], list(data_)[i][1])

        return N + 1
    
    def getType(self, a_, b_):

        if a_ == b_: return "self"
        if a_ != b_ and self.checkPair(a_, b_) == True: return "paired"
        return "direct"
       
    def checkPair(self, a_, b_):
        
        for link in self.data:

            if a_.index == link[1] and b_.index == link[0]: 

                return True
            
        return False
         
    def __init__(self, x_, y_, radius_, data_):

        self.x = x_
        self.y = y_
        self.radius = radius_
        self.data = data_
        self.n = self.getN(self.data)
        self.nodes = []
        self.links = []
        
        for i in range(0, self.n):
            
            x = self.x + self.radius * cos(TWO_PI/self.n * i)
            y = self.y + self.radius * sin(TWO_PI/self.n * i)
            self.nodes.append(Node(i, x, y, self.radius))
            
        for j in range(0, len(self.data)):

            a = self.nodes[self.data[j][0]]
            b = self.nodes[self.data[j][1]]
            self.links.append(Link(a, b, self.getType(a, b)))
                  
class Node:
    
    def render(self):
        
        stroke(0x000000)
        fill(colors[self.index])
        ellipse(self.x, self.y, self.radius, self.radius)
        
    def __init__(self, index_, x_, y_, radius_):
        
        self.index = index_
        self.radius = radius_
        self.x = x_
        self.y = y_
       
class Link:
    
    def __init__(self, a_, b_, type_):
        
        self.a = a_
        self.b = b_
        self.type = type_
        
class DirectLink:
    
    def setByOffset(self, a_, b_):
        
        x = 0.0
        y = 0.0
        
        d = sqrt(pow(b_.x - a_.x, 2) + pow(b_.y - a_.y, 2)) + 1E-99
        delta = a_.radius / 2.0 / d * radiusOffset
        
        out = PVector.lerp(PVector(a_.x, a_.y), PVector(b_.x, b_.y), delta)
        return out
    
    def setPoints(self):
        
        global thikness, arrowRatio, radiusOffset
        
        arrowThikness = thikness * arrowRatio
        n = 2
        a = self.setByOffset(self.a, self.b)
        b = self.setByOffset(self.b, self.a)
        self.vertices[0] = PVector(b.x, b.y);
        
        offset = [None] * n
        arrowOffset = [None] * n
        
        for i in range(0, n):
            
            offset[i] = -thikness / 2.0 + thikness / n * i;
            offset[i] += thikness / n / 2.0
            
            arrowOffset[i] = -arrowThikness / 2.0 + arrowThikness / n * i
            arrowOffset[i] += arrowThikness / n / 2.0
        
        arrow = PVector(a.x, a.y)
        distance = PVector.dist(a, b)
        lrp = thikness / 2.0 * arrowRatio / (distance + 1E-99)
        arrow.lerp(b, 1.0 - lrp);
        
        for i in range(0, n):
            
            k = list(offset)[i]
            ka = list(arrowOffset)[i]
            dx = a.x - b.x
            dy = a.y - b.y
            
            distance2 = sqrt(dx*dx + dy*dy) + 1E-99
            dx /= distance2
            dy /= distance2
       
            x1 = a.x + dy * k
            y1 = a.y - dx * k
          
            x3 = arrow.x + dy * k
            y3 = arrow.y - dx * k

            x5 = arrow.x + dy * ka
            y5 = arrow.y - dx * ka
            
            if i == 1:
                
                self.vertices[1] = PVector(x5, y5)
                self.vertices[2] = PVector(x3, y3)
                self.vertices[3] = PVector(x1, y1)
                
            else:
                
                self.vertices[6] = PVector(x5, y5)
                self.vertices[5] = PVector(x3, y3)
                self.vertices[4] = PVector(x1, y1)
                
    def render(self):
        
        noStroke()
        fill(0x000000)
        
        beginShape()
        for v in self.vertices: vertex(v.x, v.y)
        endShape(CLOSE)
        
    def __init__(self, a_, b_):
        
        self.a = a_
        self.b = b_
        self.points = []
        self.vertices = [None] * 7
        self.setPoints()
   
class PairedLink:
    
    def setByOffset(self, a_, b_):
        
        x = 0.0
        y = 0.0
        
        d = sqrt(pow(b_.x - a_.x, 2) + pow(b_.y - a_.y, 2)) + 1E-99
        delta = a_.radius / 2.0 / d * radiusOffset
        
        out = PVector.lerp(PVector(a_.x, a_.y), PVector(b_.x, b_.y), delta)
        return out
    
    def setControlPoints(self, p0_, p1_, h_):

        offset = -h_
        n = 2
        
        for i in range(0, n):
            
            dx = p0_.x - p1_.x
            dy = p0_.y - p1_.y
        
            d = sqrt(dx*dx + dy*dy)
            dx /= d
            dy /= d
            
            x1 = p0_.x + dy * offset / 2.0
            y1 = p0_.y - dx * offset / 2.0
            x2 = p1_.x + dy * offset / 2.0
            y2 = p1_.y - dx * offset / 2.0
            
            x3 = PVector.lerp(p0_, p1_, 0.25).x + dy * offset
            y3 = PVector.lerp(p0_, p1_, 0.25).y - dx * offset
            x4 = PVector.lerp(p0_, p1_, 0.75).x + dy * offset
            y4 = PVector.lerp(p0_, p1_, 0.75).y - dx * offset
            x5 = PVector.lerp(p0_, p1_, 0.5).x + dy * offset
            y5 = PVector.lerp(p0_, p1_, 0.5).y - dx * offset

        self.t0 = PVector(x1, y1)
        self.t1 = PVector(x2, y2)
        self.d0 = PVector(x3, y3)
        self.d1 = PVector(x4, y4)
        self.m = PVector(x5, y5)

    def render(self):
        
        global thikness

        noStroke()
        fill(0x000000)
        beginShape()  
        self.bezier0.offset(-thikness / 4.0)
        self.bezier0.render()
        self.splits.left.offset(-thikness / 4.0)
        self.splits.left.render()
        self.splits.right.offset(-thikness / 3.0 * 2.0)
        vertex(self.splits.right.getFirstComplexPoint().x, self.splits.right.getFirstComplexPoint().y) 
        vertex(self.e.x, self.e.y)
        self.splits.right.offset(thikness / 3.0 * 2.0)
        vertex(self.splits.right.getFirstComplexPoint().x, self.splits.right.getFirstComplexPoint().y) 
        self.splits.left.offset(thikness / 4.0)
        self.splits.left.render(True)
        self.bezier0.offset(thikness / 4.0)
        self.bezier0.render(True)
        endShape(CLOSE)

    
    def __init__(self, a_, b_):
        
        self.s = self.setByOffset(a_, b_)
        self.e = self.setByOffset(b_, a_)
        self.dir = 1
        if a_.index > b_.index: 
            self.dir = 1
        else:
            self.dir = -1

        self.setControlPoints(self.s, self.e, 24.0)
        
        self.bezier0 = ComplexBezier([self.s, self.t0, self.d0, self.m])
        self.bezier1 = ComplexBezier([self.m, self.d1, self.t1, self.e])    
        self.splits = self.bezier1.splitCurve1(0.8)

    
class SelfClosingLink:

    def setControlPoints(self, p0_, p1_, h_):
        
        offsetD = -h_
        offsetT = -h_ + h_ / 1.5
        n = 2
        
        for i in range(0, n):

            dx = p0_.x - p1_.x
            dy = p0_.y - p1_.y
        
            d = sqrt(dx*dx + dy*dy)
            dx /= d
            dy /= d
        
            x1 = p0_.x + dy * offsetD
            y1 = p0_.y - dx * offsetD
            x2 = p1_.x + dy * offsetD
            y2 = p1_.y - dx * offsetD
            
            x3 = p0_.x + dy * offsetT
            y3 = p0_.y - dx * offsetT
            x4 = p1_.x + dy * offsetT
            y4 = p1_.y - dx * offsetT
            
            self.d0 = PVector(x1, y1)
            self.d1 = PVector(x2, y2)
            self.t0 = PVector(x3, y3)
            self.t1 = PVector(x4, y4)

    def render(self):
        
        global thikness

        noStroke()
        fill(0x000000)
        beginShape()  
        self.bezier0.offset(-thikness / 4.0)
        self.bezier0.render()
        self.splits.left.offset(-thikness / 4.0)
        self.splits.left.render()
        self.splits.right.offset(-thikness / 3.0 * 2.0)
        vertex(self.splits.right.getFirstComplexPoint().x, self.splits.right.getFirstComplexPoint().y) 
        vertex(self.e.x, self.e.y)
        self.splits.right.offset(thikness / 3.0 * 2.0)
        vertex(self.splits.right.getFirstComplexPoint().x, self.splits.right.getFirstComplexPoint().y) 
        self.splits.left.offset(thikness / 4.0)
        self.splits.left.render(True)
        self.bezier0.offset(thikness / 4.0)
        self.bezier0.render(True)
        endShape(CLOSE)
        
    def __init__(self, a_, cx_, cy_, width_):
        
        global radiusOffset
        
        phi = 0.2
        h = width_ / 4.0 * 3.0
        
        v0 = PVector(cx_, cy_)
        v0.sub(PVector(a_.x, a_.y))    
        v0.normalize()
        
        theta0 = v0.heading()
        theta0 -= phi
        
        v0 = PVector.fromAngle(theta0)
        v0.mult(a_.radius / 2.0 * radiusOffset)
        
        v1 = PVector(cx_, cy_)
        v1.sub(PVector(a_.x, a_.y))    
        v1.normalize()
        
        theta1 = v1.heading()
        theta1 += phi
        
        v1 = PVector.fromAngle(theta1)
        v1.mult(a_.radius / 2.0 * radiusOffset)
        
        v2 = PVector(cx_, cy_)
        v2.sub(PVector(a_.x, a_.y))    
        v2.normalize()
        v2.mult(a_.radius / 2.0 * radiusOffset + h)
        
        self.s = PVector(a_.x, a_.y).sub(v0)
        self.e = PVector(a_.x, a_.y).sub(v1)
        self.m = PVector(a_.x, a_.y).sub(v2)

        d = self.e.dist(self.s) / 2.0
        delta = width_ / d / 6.0

        self.setControlPoints(PVector.lerp(self.e, self.s, (0.5 + delta)), PVector.lerp(self.e, self.s, (0.5 - delta)), h)     
        
        self.bezier0 = ComplexBezier([self.s, self.t0, self.d0, self.m])
        self.bezier1 = ComplexBezier([self.m, self.d1, self.t1, self.e])    
        self.splits = self.bezier1.splitCurve1(0.95)
        
class Lyrics:
    
    def __init__(self, x_, y_, width_, height_, data_):

        self.x = x_
        self.y = y_
        self.w = width_
        self.h = height_
        self.data = data_
        
    def render(self):

        global colors
        
        for i in range(0, len(self.data)):
            
            stroke(0x000000)
            strokeWeight(1.0)
            x = self.w / len(self.data) * i
            fill(colors[self.data[i][2]])
            rect(self.x + x, self.y, self.w / len(self.data), self.h)
