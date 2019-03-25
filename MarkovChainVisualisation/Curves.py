class ComplexBezier:
    
    #checked
    def derive(self, points_):
        
        out = T()
        p = points_[:]
        
        for d in range(len(p), 1, -1):
            for c in range((len(p) - 1), 0, -1):
                
                ls = list()
                
                for j in range(0, c):

                    dpt = PVector(c * (p[j + 1].x - p[j].x), c * (p[j + 1].y - p[j].y))
                    ls.append(dpt)

                out.append(ls)
                p = ls

        return out
    
    #checked
    def derivative(self, t_):
        
        mt = 1.0 - t_
        a = 0.0
        b = 0.0
        c = 0.0
        
        p = list(self.dpoints)[0][:]
        
        if self.order == 2:
            
            pp = list()
            pp.append(list(p)[0])
            pp.append(list(p)[1])
            pp.append(PVector(1E-9, 1E-9))
            p = pp
            a = mt
            b = t_

        elif self.order == 3:

            a = mt * mt;
            b = mt * t_ * 2.0;
            c = t_ * t_;

        return PVector(a * list(p)[0].x + b * list(p)[1].x + c * list(p)[2].x, a * list(p)[0].y + b * list(p)[1].y + c * list(p)[2].y)
      
    #checked  
    def getAngle(self, p0_, p1_, p2_):

        dx1 = p1_.x - p0_.x;
        dy1 = p1_.y - p0_.y;
        dx2 = p2_.x - p0_.x;
        dy2 = p2_.y - p0_.y;
        cross = dx1 * dy2 - dy1 * dx2;
        dot = dx1 * dx2 + dy1 * dy2;
        return atan2(cross, dot);
  
    #checked
    def droots(self, p_):
        
        if len(p_) == 3:
            
            a = p_[0]
            b = p_[1]
            c = p_[2]
            d = a - 2.0 * b + c
            
            if d != 0:
            
                m1 = sqrt(b * b - a * c)
                m2 = -a + b
                v1 = -(m1 + m2) / d
                v2 = -(-m1 + m2) / d
                return [v1, v2]
            
            elif b != c and d == 0.0:
            
                return [(2.0 * b - c) / (2.0 * (b - c))]
            
            return []
        
        elif len(p_) == 2:
            
            a = p_[0]
            b = p_[1]
            
            if a != b: return [a / (a - b)]
            
        return []
       
     
    #checked
    def getValues(self, dpoints_, k_):
        
        out = [None] * len(dpoints_)

        for i in range(0, len(dpoints_)):
            
            if k_ == 0: out[i] = dpoints_[i].x
            if k_ == 1: out[i] = dpoints_[i].y
            
        return out
        
    #checked
    def shrink(self, values_):
        
        valid = []
        for f in values_: 
            
            if f >= 0 and f <= 1.0: valid.append(f)
        
        return valid
        
    #checked
    def extrema(self):
        
        result = {}
        roots = []

        for k in range(0, 2):
            
            p = self.getValues(list(self.dpoints)[0], k)
            result[k] = self.droots(p)
            if self.order == 3:
                
                p2 = self.getValues(list(self.dpoints)[1], k)
                result[k] += self.droots(p2)
            
            result[k] = self.shrink(result[k])
            result[k].sort()
            roots += result[k]
            
        roots.sort()
        return roots  
           
    #checked    
    def checkForValue(self, array_, value_):
    
        for f in array_:
            if f == value_: return False
            
        return True

    #checked
    def hull(self, t_):

        q = [None] * 10
        p = self.points[:]
        #println(p)
        idx = 0
        i = 0
        l = 0
        
        q[idx] = p[0]
        idx += 1
        q[++idx] = p[1]
        idx += 1
        q[++idx] = p[2]
        idx += 1
        
        if self.order == 3: 
            q[idx] = p[3]
            idx += 1
        
        while len(p) > 1:
                  
            p_ = []
            for i in range(0, (len(p) - 1)):

                pt = PVector.lerp(PVector(p[i].x, p[i].y), PVector(p[i + 1].x, p[i + 1].y), float(t_))
                q[idx] = pt
                idx += 1
                p_.append(pt)
                
            p = p_
            
        return q
        
    #checked
    def lli4(self, p0_, p1_, p2_, p3_):
        
        return self.lli8(p0_.x, p0_.y, p1_.x, p1_.y, p2_.x, p2_.y, p3_.x, p3_.y)
    
    #checked
    def lli8(self, x1_, y1_, x2_, y2_, x3_, y3_, x4_, y4_):
        
        nx = (x1_ * y2_ - y1_ * x2_) * (x3_ - x4_) - (x1_ - x2_) * (x3_ * y4_ - y3_ * x4_)
        ny = (x1_ * y2_ - y1_ * x2_) * (y3_ - y4_) - (y1_ - y2_) * (x3_ * y4_ - y3_ * x4_)
        d = (x1_ - x2_) * (y3_ - y4_) - (y1_ - y2_) * (x3_ - x4_)
                                                                   
        return PVector(nx / d, ny / d)
        
    #checked
    def simple(self):
        
        if self.order == 3:
        
            a1 = self.getAngle(self.points[0], self.points[3], self.points[1]);
            a2 = self.getAngle(self.points[0], self.points[3], self.points[2]);
            if (a1 > 0 and a2 < 0) or (a1 < 0 and a2 > 0): return false

        n1 = self.normal2D(0.0);
        n2 = self.normal2D(1.0);
        s = n1.x * n2.x + n1.y * n2.y;
        angle = abs(acos(s));
        return angle < PI / 3.0;

    #checked
    def getXY(self, t_):
        
        if t_ == 0.0: return self.points[0]
        o = len(self.points) - 1;
        if t_ == 1.0: return self.points[o]
        
        p = self.points[:]
        mt = 1.0 - t_
        
        if o == 0: return self.points[0]
        if o == 1: return PVector(mt * p[0].x + t_ * p[1].x, p[0].y + t_ * p[1].y)
        
        mt2 = mt * mt
        t2 = t_ * t_
        a = 0.0
        b = 0.0
        c = 0.0
        d = 0.0
        
        if o == 2:
            
            pp = [p[0], p[1], p[2], PVector(0.0, 0.0)];
            p = pp;
            a = mt2;
            b = mt * t_ * 2.0;
            c = t2;
            
        elif o == 3:
            
            a = mt2 * mt;
            b = mt2 * t_ * 3.0;
            c = mt * t2 * 3.0;
            d = t_ * t2;
            
        return PVector(a * p[0].x + b * p[1].x + c * p[2].x + d * p[3].x, a * p[0].y + b * p[1].y + c * p[2].y + d * p[3].y)
     
    #checked
    def normal2D(self, t_):
        
        d = self.derivative(t_)
        q = sqrt(d.x * d.x + d.y * d.y)
        return PVector(-d.y / q, d.x / q)
        
    #checked  
    def splitCurve2(self, t1_, t2_):
        
        if t1_ == 0: return self.splitCurve1(t2_).left
        if t2_ == 0: return self.splitCurve1(t1_).right
        
        q = self.hull(t1_)
        
        if self.order == 2:
            
            result = Segment(ComplexBezier([q[0], q[3], q[5]]), ComplexBezier([q[5], q[4], q[2]]), q)
        
        else:
            
            result = Segment(ComplexBezier([q[0], q[4], q[7], q[9]]), ComplexBezier([q[9], q[8], q[6], q[3]]), q)  
        
        result.left.t1 = self.mapFloat(0, 0.0, 1.0, self.t1, self.t2)
        result.left.t2 = self.mapFloat(t1_, 0.0, 1.0, self.t1, self.t2)
        result.right.t1 = self.mapFloat(t1_, 0.0, 1.0, self.t1, self.t2)
        result.right.t2 = self.mapFloat(1.0, 0.0, 1.0, self.t1, self.t2)
        
        t2_ = map(t2_, t1_, 1.0, 0.0, 1.0);
        
        subsplit = result.right.splitCurve1(t2_);
        return subsplit.left;
   
    #checked     
    def splitCurve1(self, t1_):

        q = self.hull(t1_)
        
        if self.order == 2:
            
            result = Segment(ComplexBezier([q[0], q[3], q[5]]), ComplexBezier([q[5], q[4], q[2]]), q)
        
        else:
            
            result = Segment(ComplexBezier([q[0], q[4], q[7], q[9]]), ComplexBezier([q[9], q[8], q[6], q[3]]), q)  

        result.left.t1 = self.mapFloat(0.0, 0.0, 1.0, self.t1, self.t2)
        result.left.t2 = self.mapFloat(t1_, 0.0, 1.0, self.t1, self.t2)
        result.right.t1 = self.mapFloat(t1_, 0.0, 1.0, self.t1, self.t2)
        result.right.t2 = self.mapFloat(1.0, 0.0, 1.0, self.t1, self.t2)

        return result
    
    def reduce(self):
        
        t1 = 0.0
        t2 = 0.0
        step = 0.01
        i = 0
        
        pass1 = []
        pass2 = []

        extrema = self.extrema();
        if self.checkForValue(extrema, 0.0): extrema.insert(0, 0.0)
        if self.checkForValue(extrema, 1.0): extrema.append(1.0)
        
        t1 = extrema[0]
        
        for i in range(1, len(extrema)):
            
            t2 = extrema[i]
            segment = self.splitCurve2(t1, t2)
            segment.t1 = t1
            segment.t2 = t2
            pass1.append(segment)
            t1 = t2

        for p1 in pass1:
            
            t1 = 0.0
            t2 = 0.0

            for t2 in self.frange((t1 + step), (1.0 + step), step):

                segment = p1.splitCurve2(float(t1), float(t2))
                
                if segment.simple() is False:

                    t22 = float(t2)
                    t22 -= step;
                    if abs(t1 - t22) < step: 
                        return []
                    segment = p1.splitCurve2(t1, t2)
                    segment.t1 = map(t1, 0, 1, p1.t1, p1.t2)
                    segment.t2 = map(t22, 0, 1, p1.t1, p1.t2)
                    pass2.append(segment)
                    t1 = t22
                    break
              
            if t1 < 1.0:

                segment = p1.splitCurve2(t1, 1);
                segment.t1 = map(t1, 0, 1, p1.t1, p1.t2);
                segment.t2 = p1.t2;
                pass2.append(segment);

        return pass2

    #checked
    def setOffset(self, d_):
        
        distanceFn = False
        ord = self.order
        r1 = d_
        r2 = d_
      
        points2 = self.points[:]
        np = [None] * 4
        
        v = [self.offset(0.0, 10.0), self.offset(1.0, 10.0)]
        o = self.lli4(PVector(v[0].x, v[0].y), v[0].c, PVector(v[1].x,v[1].y), v[1].c)

        for xy in range(0, 2):
            
            p  = np[xy * ord] = PVector(points2[xy * ord].x, points2[xy * ord].y)
            p.x +=  d_ * v[xy].n.x
            p.y +=  d_ * v[xy].n.y
            
        for xy in range(0, 2):
        
            p = np[xy * ord];
            d = self.derivative(xy);
            p2 = PVector(p.x + d.x, p.y + d.y);
            np[xy + 1] = self.lli4(p, p2, o, points2[xy + 1]);
            
        return ComplexBezier(np)       
            
    def offset(self, t_, d_ = None):
        
        if d_ == None:

            reduced = self.reduce()
            out = list()
            for b in reduced:
                out.append(b.setOffset(t_))
            
            self.complex = out
        
        else:
            
            c = self.getXY(t_);
            n = self.normal2D(t_);
            return Ret(c, n, c.x + n.x * d_, c.y + n.y * d_);
      
    def frange(self, start_, stop_ = None, step_ = None):
        if stop_ == None:
            stop_ = start_ + 0.0
            start_ = 0.0
        if step_ == None:
            step_ = 1.0
        while True:
            if step_ > 0 and start_ >= stop_:
                break
            elif step_ < 0 and start <= stop_:
                break
            yield ("%g" % start_)
            start_ = start_ + step_
            
    def mapFloat(self, v_, min0_, max0_, min1_, max1_):

        span0 = float(max0_) - float(min0_)
        span1 = float(max1_) - float(min1_)
        v2 = (float(v_) - min0_) / span0
        return min1_ + (v2 * span1)

    def render(self, reverse_ = False):
        
        if self.complex != None:

                if reverse_ == True:
                    
                    for curve in self.complex[::-1]:
                
                        vertex(curve.points[3].x, curve.points[3].y)
                        bezierVertex(curve.points[2].x, curve.points[2].y, curve.points[1].x, curve.points[1].y, curve.points[0].x, curve.points[0].y)
        
                else: 
                    
                    for curve in self.complex:
                
                        vertex(curve.points[0].x, curve.points[0].y)
                        bezierVertex(curve.points[1].x, curve.points[1].y, curve.points[2].x, curve.points[2].y, curve.points[3].x, curve.points[3].y)
        
    
    def getFirstComplexPoint(self, reverse_ = False):

        if self.complex != None:

                if reverse_ == True:
                    
                    for curve in self.complex[::-1]:
                
                        return curve.points[3]
        
                else: 
                    
                    for curve in self.complex:
                
                        return curve.points[0]

    def renderComplex(self, reverse_ = False):
        
        segments = [color(0, 255, 255), color(255, 0, 255), color(255, 255, 0), color(0, 0, 0)]
        idx = 0
        if self.complex != None:

                if reverse_ == True:
                    
                    for curve in self.complex[::-1]:
                
                        
                        stroke(segments[idx])
                        strokeWeight(1.0)
                        beginShape()
                        vertex(curve.points[3].x, curve.points[3].y)
                        bezierVertex(curve.points[2].x, curve.points[2].y, curve.points[1].x, curve.points[1].y, curve.points[0].x, curve.points[0].y)
                        endShape()
                        idx += 1
        
                else: 
                    
                    for curve in self.complex:
                
                        stroke(segments[idx])
                        strokeWeight(1.0)
                        beginShape()
                        vertex(curve.points[0].x, curve.points[0].y)
                        bezierVertex(curve.points[1].x, curve.points[1].y, curve.points[2].x, curve.points[2].y, curve.points[3].x, curve.points[3].y)
                        endShape()
                        ind += 1
    
    
    def renderComplex(self, reverse_ = False):
        
        if self.complex != None:
            
            println("render complex")

    def __init__(self, points_):
        
        self.order = len(points_) - 1
        self.points = points_
        self.dpoints = self.derive(self.points)
        self.t1 = 0.0
        self.t2 = 0.0
        self.complex = None

      
class Ret:

   def __init__(self, c_, n_, x_, y_):
       
       self.c = c_
       self.n = n_
       self.x = x_
       self.y = y_
        
class Segment:
    
    def __init__(self, left_, right_, span_):
        
        self.left = left_
        self.right = right_
        self.span = span_
    
class T(list):
    
    def append(self, set_):
        if set_ not in self:
            list.append(self, set_)
