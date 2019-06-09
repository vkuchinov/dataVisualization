/*

NEURAL NETWORK PLAYGROUND 
driven by Python backend

TODO LIST:

[-] planned, [x] done, [!] see comments

I have used upper controls (epoch and sliders) and visual aesthetics 
from TensorFlow Playgroundby Daniel Smilkov and Shan Carter, Google, 
everything else is developed from scratch by me.

@author Vladimir V KUCHINOV
@email  helloworld@vkuchinov.co.uk

*/

var player, config, network, grids, svg, defs, tooltip, neurons, synapses;

//network dynamic JSON object
network = {

    parameters: {

        descrete: false,

    },
    
    input : {
        
        values  : [
            
				0.48414304299863586,
				0.99352224579296,
				0.9313089312471964,
				0.6163800876003568,
				0.9142359368096583,
				0.10773214690578437,
				0.4665245441064815,
				0.19926765852092765,
				0.059855396697792385
            
        ],

        
    },
    
    output : {
        
        min : { x: 0.0, y: 0.0 },
        max : { x: 1.0, y: 1.0 }
        
    },

    neurons: [],

    synapses: [],
    
    matrix : [[4, 10, 0], [1, 96, 2], [0, 22, 6]],
    
    testloss : [
        
        { epoch: 0, loss : 0.34, acc: 0.23 },
        { epoch: 1, loss : 0.4, acc: 0.03 },
        { epoch: 2, loss : 0.53, acc: 0.3 },
        { epoch: 3, loss : 0.34, acc: 0.14 },
        { epoch: 4, loss : 0.67, acc: 0.23 },
    
    ]

};

//epoch player
function Player() {

    this.isPlaying = false;
    this.state = "pause";
    this.iter = 1;

    this.run = function(t_) {

        var this_ = player;

        if (this_.isPlaying == true) {

            player.iter++;
            document.getElementById("iter-number").innerHTML = Number(this_.iter / 1000).toLocaleString("en-US", {
                minimumIntegerDigits: 3,
                minimumFractionDigits: 3,
                useGrouping: false
            });

        }

    }

    document.getElementById("iter-number").innerHTML = Number(this.iter / 1000).toLocaleString("en-US", {
            minimumIntegerDigits: 3,
            minimumFractionDigits: 3,
            useGrouping: false
    });
    
    this.timer = d3.timer(this.run, 500);
    
    d3.select("#play-pause-button").on("click", function(d_) {

        player.playOrPause();
        d3.select(this).select("i").node().innerHTML = player.state;

    });
    d3.select("#reset-button").on("click", function(d_) {
        player.reset();
    });
    d3.select("#next-step-button").on("click", function(d_) {
        player.next();
    });

}

Player.prototype.playOrPause = function() {

    this.isPlaying ? (this.isPlaying = !1, this.pause()) : (this.isPlaying = !0, this.play())

}
Player.prototype.pause = function() {
    document.getElementById("next-step-button").disabled = false;
    this.state = "play_arrow";
}
Player.prototype.play = function() {
    document.getElementById("next-step-button").disabled = true;
    this.state = "pause";
    document.getElementById("reset-button").disabled = false;
}
Player.prototype.reset = function() {

    this.state = "play";
    this.isPlaying = false;
    this.iter = 1;
    document.getElementById("iter-number").innerHTML = Number(0).toLocaleString("en-US", {
        minimumIntegerDigits: 3,
        minimumFractionDigits: 3,
        useGrouping: false
    });
    document.getElementById("reset-button").disabled = true;

}
Player.prototype.next = function() {

    if (this.isPlaying == false) {

        this.iter++;
        document.getElementById("iter-number").innerHTML = Number(this.iter / 1000).toLocaleString("en-US", {
            minimumIntegerDigits: 3,
            minimumFractionDigits: 3,
            useGrouping: false
        });
        document.getElementById("reset-button").disabled = false;

    }

}
Player.prototype.set = function(value_) { this.iter = value_; }

player = new Player();

//grid helpers [guidelines]
function Grids(parent_, cols_, rows_, gap_) {

    this.x = config.margin.l;
    this.y = config.margin.t;
    this.w = config.w;
    this.h = config.h;
    this.gap = gap_;
    this.rows = rows_;
    this.cols = cols_;
    this.gw = (this.w - this.gap * (this.cols - 1)) / this.cols,
        this.gh = (this.h - this.gap * (this.rows - 1)) / this.rows;

    for (var i = 0; i < this.cols + 1; i++) {

        if (i != 0) {

            parent_.append("line")
                .attr("class", "grid")
                .attr("x1", this.x + (this.gw + this.gap) * i - this.gap)
                .attr("y1", this.y)
                .attr("x2", this.x + (this.gw + this.gap) * i - this.gap)
                .attr("y2", this.y + this.h)
                .attr("visibility", "hidden")
                .attr("stroke", "#79CFD9");

        }

        if (i != this.cols) {

            parent_.append("line")
                .attr("class", "grid gridcol_" + i)
                .attr("x1", this.x + (this.gw + this.gap) * i)
                .attr("y1", this.y)
                .attr("x2", this.x + (this.gw + this.gap) * i)
                .attr("y2", this.y + this.h)
                .attr("visibility", "hidden")
                .attr("stroke", "#00FFFF");

        }

    }

    for (var i = 0; i < this.rows + 1; i++) {

        if (i != 0) {

            parent_.append("line")
                .attr("class", "grid")
                .attr("x1", this.x)
                .attr("y1", this.y + (this.gh + this.gap) * i - this.gap)
                .attr("x2", this.x + this.w)
                .attr("y2", this.y + (this.gh + this.gap) * i - this.gap)
                .attr("visibility", "hidden")
                .attr("stroke", "#79CFD9");

        }

        if (i != this.rows) {

            parent_.append("line")
                .attr("class", "grid gridrow_" + i)
                .attr("x1", this.x)
                .attr("y1", this.y + (this.gh + this.gap) * i)
                .attr("x2", this.x + this.w)
                .attr("y2", this.y + (this.gh + this.gap) * i)
                .attr("visibility", "hidden")
                .attr("stroke", "#00FFFF");

        }

    }

    this.setOpacity = function(v_) {
        d3.selectAll(".grid").attr("opacity", v_);
    }
    this.show = function() {
        d3.selectAll(".grid").attr("visibility", "visible");
    }
    this.hide = function() {
        d3.selectAll(".grid").attr("visible", "hidden");
    }

    this.getXByCol = function(v_) {

        if (v_ % 1 === 0) {
            return Number(d3.select(".gridcol_" + v_).attr("x1"));
        } else {
            var indx = Math.floor(v_);
            return Number(d3.select(".gridcol_" + indx).attr("x1")) + this.gw * (v_ - indx);
        }

    }
    this.getYByRow = function(v_) {

        if (v_ % 1 === 0) {
            return Number(d3.select(".gridrow_" + v_).attr("y1"));
        } else {
            var indx = Math.floor(v_);
            return Number(d3.select(".gridrow_" + indx).attr("y1")) + this.gh * (v_ - indx);
        }

    }
    this.getWidthByCols = function(v0_, v1_) {

        return Number(d3.select(".gridcol_" + v1_).attr("x1")) - Number(d3.select(".gridcol_" + v0_).attr("x1"));

    }
    this.getHeightByRows = function(v0_, v1_) {

        return Number(d3.select(".gridrow_" + v1_).attr("y1")) - Number(d3.select(".gridrow_" + v0_).attr("y1"));

    }

}

//input visualisation
d3.inputPointsData = function() {

    function inputPointsData(selection_) {

        selection_.each(function(d_, i_) {

            var g = d3.select(this)
                .attr("transform", "translate(" + d_.x + "," + d_.y + ")");
            
            var area = g.append("rect")
                       .attr("width", d_.w)
                       .attr("height", d_.h)
                       .attr("fill", "#FFFFFF")

            var inPoints = g.selectAll(".pointsIn")
                    .data(network.input.points)
                    .enter().append("circle")
                    .attr("class", "pointsIn")
                    .attr("cx", function(d2_) { return remapFloat(d2_.x, network.input.min.x, network.input.max.x, 0.0, d_.w); })
                    .attr("cy", function(d2_) {  return remapFloat(d2_.y, network.input.min.y, network.input.max.y, 0, d_.h); })
                    .attr("r", d_.w * 2.0E-2)
                    .attr("fill", "#000000")


        });

    }

    return inputPointsData;

}

d3.inputPatternData = function() {

    var canvas = document.createElement("canvas");
    var ctx = canvas.getContext("2d");
    
    function inputPatternData(selection_) {
        
        selection_.each(function(d_, i_) {

            var g = d3.select(this)
                .attr("transform", "translate(" + d_.x + "," + d_.y + ")");

            canvas.id = "inputCanvas_" + i_;
            canvas.width = d_.w;
            canvas.height = d_.w;

            var imgData = renderFunction(ctx, d_.values, d_.w);
            ctx.putImageData(imgData, 0, 0);

            var bitmap = canvas.toDataURL();
            
            var ptrn = defs.append("svg:pattern")
                       .attr("id", "input_pattern")
                       .attr("width", d_.w)
                       .attr("height", d_.h)
                       .attr("patternUnits", "userSpaceOnUse")
                       .append("svg:image")
                       .attr("xlink:href", bitmap)
                       .attr("width", d_.w)
                       .attr("height", d_.h)
                       .attr("x", 0)
                       .attr("y", 0);
                
            var area = g.append("rect")
                       .attr("width", d_.w)
                       .attr("height", d_.h)
                       .attr("fill", "url(#input_pattern)")

        });

    }
    
    function renderFunction(parent_, values_, w_){

     var matrix2D = bilinearInterpolation2D(get2Dfrom1D(values_), w_);         
     var out = parent_.createImageData(w_, w_); 
      
     for(var i = 0; i < out.data.length; i += 4){
         
         var x = (i / 4) % w_;
         var y = Math.floor(i / 4 / w_);
         
         var v = remap(matrix2D[x][y], 0, 1, -1, 1);
         
         var color = lerpHexColors(config.colors[1], config.colors[2], v);
         if(v < 0) { color = lerpHexColors(config.colors[1], config.colors[0], Math.abs(v)); }

         if(color == "#") { color = config.colors[1]; }
         var rgb = d3.color(color);
         
         out.data[i] = rgb.r;
         out.data[i + 1] = rgb.g;
         out.data[i + 2] = rgb.b;
         out.data[i + 3] = 255;
         
     }

     return out;
      
  }
    
  function create2DArray(w_){
      
      out = new Array(w_);
      
      for(var i = 0; i < w_; i++){ 
          
          
          out[i] = new Array(w_); 
          for(var j = 0; j < w_; j++){ out[i][j] = 0.0; }
                                 
                                 
      }
      
      return out;
      
  }
    
  function get2Dfrom1D(data_){
      
      var w0 = Math.sqrt(data_.length);
      var out = create2DArray(w0);
      
      for(var i = 0; i < data_.length; i++) { var x = i % w0; var y = Math.floor(i / w0); out[x][y] = data_[i]; };
      
      return out;
      
  }
    
  function get1Dfrom2D(data_){
      
      var out = [data_.length * data_.length]
      
      for (var x = 0; x < data_.length; ++x) {
        for (var y = 0; y < data_[0].length; ++y) {
          
            
        }
      }
      
      return out;
      
  }
    
  function bilinearInterpolation2D(data_, out_){

      var w0 = data_.length;
      var out = create2DArray(out_);
      
      for (var x = 0; x < out_; ++x) {
        for (var y = 0; y < out_; ++y) {
          
            var gx = x / out_ * (w0 - 1);
            var gy =  y / out_ * (w0 - 1);
            var gxi = Math.floor(gx);
            var gyi = Math.floor(gy);

            var c00 = data_[gxi][gyi];
            var c10 = data_[gxi + 1][gyi];
            var c01 = data_[gxi][gyi + 1];
            var c11 = data_[gxi + 1][gyi + 1];
            
            out[x][y] = bilerp(c00, c10, c01, c11, gx - gxi, gy - gyi);
      
        }
      }
      
      return out;
    
  }
    
  function lerpTwoHexColors(hexA_, hexB_, t_){
      
      var ah = parseInt(hexA_.replace(/#/g, ""), 16),
      ar = ah >> 16, ag = ah >> 8 & 0xFF, ab = ah & 0xFF,
      bh = parseInt(hexB_.replace(/#/g, ""), 16),
      br = bh >> 16, bg = bh >> 8 & 0xFF, bb = bh & 0xFF,
      rr = ar + t_ * (br - ar),
      rg = ag + t_ * (bg - ag),
      rb = ab + t_ * (bb - ab);

      return "#" + ((1 << 24) + (rr << 16) + (rg << 8) + rb | 0).toString(16).slice(1);
      
  }
  function dist(x0_, y0_, x1_, y1_){ return Math.sqrt((x1_- x0_) + (y1_ - y0_)); }
    
  function remap(v_, min0_, max0_, min1_, max1_){ return min1_ + (v_ - min0_) / (max0_ - min0_) * (max1_ - min1_); }

  function getPlaceholder(d_, w_, r_, dir_){

      var out = "";
      
      var points = [{x: -w_/2, y: -w_/2, c: "M"}, {x: w_/2, y: -w_/2, c: "M"}, {x: w_/2, y: w_/2, c: "M"}, {x:  -w_/2, y: w_/2, c: "M"}];
     
      var tmp = [], l = r_/ w_, N = points.length;
      
      points.forEach(function(p_, i_){

          var add = [];
          
          var lft = points[(N - 1) -(N - i_)%4],
              rht = points[(i_ + 1)%4];
                            
          add.push({x: lerp(p_.x, lft.x, l), y: lerp(p_.y, lft.y, l), c: "L"});
          add.push({x: p_.x, y: p_.y, c: "S"});
          add.push({x: lerp(p_.x, rht.x, l), y: lerp(p_.y, rht.y, l), c: ""});

          if(i_ == 1 && (dir_ == "LEFT" || dir_ == "BOTH")){
              
              var m = { x: lerp(p_.x, rht.x, 0.5), y: lerp(p_.y, rht.y, 0.5) };
            
              add.push({x: m.x, y: m.y - r_ * 0.75, c: "L"});
              add.push({x: m.x + r_ * 0.75, y: m.y, c: "L"});
              add.push({x: m.x, y: m.y + r_ * 0.75, c: "L"});
              
              d_.out = {x: m.x + r_ * 0.75, y: m.y};
       
          }
          
          if(i_ == N - 1 && (dir_ == "RIGHT" || dir_ == "BOTH")){
              
              var m = { x: lerp(p_.x, rht.x, 0.5), y: lerp(p_.y, rht.y, 0.5) };
            
              add.push({x: m.x, y: m.y - r_ * 0.75, c: "L"});
              add.push({x: m.x - r_ * 0.75, y: m.y, c: "L"});
              add.push({x: m.x, y: m.y + r_ * 0.75, c: "L"});
              
              d_.in = {x: m.x - r_ * 0.75, y: m.y};
       
          }
          
          add.forEach(function(a_){ tmp.push(a_); });
          
          
      });
      
      points = tmp;
      out += "M" + points[0].x + " " + points[0].y;
      
      points.forEach(function(p_, i_){

          if(i_ != 0){
              
              out += " " +  points[i_].c + points[i_].x + " " + points[i_].y
              
          }
          
      })
      
      return out;
      
  }
    
  function getOutPlaceholder(d_, w_, off_, r_){

      var out = "", dir = "RIGHT", off = (w_ - off_) / 2 + off_ * 0.0415;
      
      var points = [{x: 0, y: -w_/2 + off, c: "M"}, {x: w_, y: -w_/2 + off, c: " L"}, {x: w_, y: w_/2 + off - off_ * 0.0415, c: " L"}, {x: 0, y: w_/2 + off - off_ * 0.0415, c: " L"}];
      
      points = [];
      
      points.push({x: 0, y: r_ * 0.75, c: " M"});
      points.push({x: -off_ / 8, y: 0, c: " L"});
      points.push({x: 0, y: -r_ * 0.75, c: " L"});
      
      d_.in = { x : -off_ / 8, y : 0 };
      
      points.forEach(function(p_, i_){

              out += " " + p_.c + p_.x + " " + p_.y
   
      })
      
      return out;
      
  }
    
  function lerp(v0_, v1_, t_){  return v0_ + (v1_ - v0_) * t_;  }
    
  function bilerp(c00_, c10_, c01_, c11_, tx_, ty_) {
      
        return lerp(lerp(c00_, c10_, tx_), lerp(c01_, c11_, tx_), ty_);
      
  }

    return inputPatternData;

}

//neuron visualisation
d3.neuron = function() {

  var gradient = d3.scaleLinear().domain([0.0, 0.72, 1.0]).range(config.colors),
  minmax = { min: Number.POSITIVE_INFINITY, max: Number.NEGATIVE_INFINITY };
  
  var canvas = document.createElement("canvas");
  var ctx = canvas.getContext("2d");
    
  function neuron(selection_) {
      
      selection_.each(function(d_, i_) {
    
      var g = d3.select(this)
              .attr("transform", "translate(" + d_.x + "," + d_.y + ")");
          
      if(d_.id != "out"){
          
          //all neurons except out 
          var dir = "LEFT";
          if(d_.layer != 1) {dir = "BOTH"; }
          if(d_.layer == network.layers.length) { dir = "RIGHT"; }

          var params = { w: network.nsize * 0.917, o: -network.nsize * 0.4585 };
          
          canvas = document.createElement("canvas");
          canvas.id  = "canvas_" + i_;
          canvas.width  = network.nsize;
          canvas.height = network.nsize;

          ctx = canvas.getContext("2d");
          var imgData = renderFunction(ctx, d_.values, network.nsize);
          ctx.putImageData(imgData, 0, 0);
          
          var bitmap = canvas.toDataURL();

          defs.append("svg:pattern")
          .attr("id", "pattern_" + i_)
          .attr("width", params.w)
          .attr("height", params.w)
          .attr("patternUnits", "userSpaceOnUse")
          .attr("patternTransform", "translate(" + params.o + "," + params.o + ")")
          .append("svg:image")
          .attr("xlink:href", bitmap)
          .attr("width", params.w)
          .attr("height", params.w)
          .attr("x", 0)
          .attr("y", 0);
        
          var imgData2 = renderFunction(ctx, d_.values, network.nsize, true);
          ctx.putImageData(imgData2, 0, 0);
          
          var bitmap2 = canvas.toDataURL();
          
          defs.append("svg:pattern")
          .attr("id", "descrete_" + i_)
          .attr("width", params.w)
          .attr("height", params.w)
          .attr("patternUnits", "userSpaceOnUse")
          .attr("patternTransform", "translate(" + params.o + "," + params.o + ")")
          .append("svg:image")
          .attr("xlink:href", bitmap2)
          .attr("width", params.w)
          .attr("height", params.w)
          .attr("x", 0)
          .attr("y", 0);
          
          var node = g.append("path")
                       .attr("d", function(d_) { return getPlaceholder(d_, network.nsize, network.nsize / 6.0, dir)})
                       .attr("fill", "#193D4D")
                       .attr("stroke", "none")

          var area = g.append("rect")
                       .attr("class", "neuronPattern")
                       .attr("x", params.o)
                       .attr("y", params.o)
                       .attr("rx", network.nsize / 8)
                       .attr("ry", network.nsize / 8)
                       .attr("width", params.w)
                       .attr("height", params.w)
                       .attr("fill", "url(#pattern_" + i_ + ")")
                       .attr("stroke", "none")
                       .on("mouseover", function(d_){

                            canvas.id  = "canvas_" + i_;
                            canvas.width  = network.osize;
                            canvas.height = network.osize;
                           
                            ctx = canvas.getContext("2d");
                            imgData = renderFunction(ctx, d_.values, network.osize, network.parameters.descrete? true : false);
                            ctx.putImageData(imgData, 0, 0);
                            var bitmap = canvas.toDataURL();
                           
                            d3.select("#outTemp").attr("xlink:href", bitmap)
                            d3.select(".outputPattern").attr("fill", "url(#outtemp)")
                           
                           
                       })
                       .on("mouseout", function(d_){
                           
                            d3.select(".outputPattern").attr("fill", network.parameters.descrete ? "url(#outdescrete)": "url(#outgradient)" )
   
                       })

          if(d_.layer == 1){

                var label = g.append("text")
                .attr("x", params.o - network.nsize / 2 * 1.5)
                .attr("y", 0)
                .attr("pointer-events", "none")
                .attr("text-anchor", "middle")
                .attr("alignment-baseline", "central")
                .text(d_.id);


          }   

          else{

                var bias = g.append("rect")
                .attr("x", params.o - 10)
                .attr("y", -params.o - 6)
                .attr("width", 6)
                .attr("height", 6)
                .attr("fill", "#00FFFF")
                .attr("stroke", "none")
                .on("mouseover", function(d_){ 
                
                    tooltip.transition().duration(50).style("opacity", .9);
                    tooltip.style("left", (d3.event.pageX) + "px").style("top", (d3.event.pageY) + "px");
                    tooltip.select("#tag").html("bias");
  
                })
                .on("mouseout", function(d_){ 
                
                    tooltip.transition().duration(250).style("opacity", 0);
                
                });

          }
          
      }
      else{

          //out neuron [big one]
          var canvas = document.createElement("canvas");
          canvas.id  = "canvas_" + i_;
          canvas.width  = network.osize;
          canvas.height = network.osize;

          var scale =  network.osize / Math.sqrt(d_.values.length);
          var ctx = canvas.getContext("2d");
          var imgData = renderFunction(ctx, d_.values, network.osize);
          ctx.putImageData(imgData, 0, 0);

          var bitmap = canvas.toDataURL();
          var offset = (network.osize - network.osize) / 2 + network.osize * 0.0415;
          
          var ctx = canvas.getContext("2d");
          var imgData2 = renderFunction(ctx, d_.values, network.osize, true);
          ctx.putImageData(imgData2, 0, 0);

          var bitmap2 = canvas.toDataURL();
          
          defs.append("svg:pattern")
          .attr("id", "outgradient" )
          .attr("width", network.osize)
          .attr("height", network.osize)
          .attr("patternUnits", "userSpaceOnUse")
          .attr("patternTransform", "translate(0," + (-network.nsize/2) + ")")
          .append("svg:image")
          .attr("xlink:href", bitmap)
          .attr("width", network.osize)
          .attr("height", network.osize)
          .attr("x", 0)
          .attr("y", 0);
          
          defs.append("svg:pattern")
          .attr("id", "outdescrete" )
          .attr("width", network.osize)
          .attr("height", network.osize)
          .attr("patternUnits", "userSpaceOnUse")
          .attr("patternTransform", "translate(0," + (-network.nsize/2) + ")")
          .append("svg:image")
          .attr("xlink:href", bitmap2)
          .attr("width", network.osize)
          .attr("height", network.osize)
          .attr("x", 0)
          .attr("y", 0);
          
          defs.append("svg:pattern")
          .attr("id", "outtemp" )
          .attr("width", network.osize)
          .attr("height", network.osize)
          .attr("patternUnits", "userSpaceOnUse")
          .attr("patternTransform", "translate(0," + (-network.nsize/2) + ")")
          .append("svg:image")
          .attr("id", "outTemp")
          .attr("xlink:href", bitmap)
          .attr("width", network.osize)
          .attr("height", network.osize)
          .attr("x", 0)
          .attr("y", 0);

          var node = g.append("path")
                       .attr("d", function(d_) { return getOutPlaceholder(d_, network.osize, network.nsize, 8.0)})
                       .attr("fill", "#193D4D")
                       .attr("stroke", "none")

          var area = g.append("rect")
                       .attr("class", "outputPattern")
                       .attr("x", 0)
                       .attr("y", -network.nsize / 2 + network.nsize * 0.0415)
                       .attr("width", network.osize)
                       .attr("height", network.osize - network.nsize * 0.0415)
                       .attr("fill", "url(#outgradient)")
                       .attr("stroke", "none")
          
          var sx = d3.scaleLinear().range([0, network.osize]).domain([network.output.min.x, network.output.max.x]);
          var sy = d3.scaleLinear().range([network.osize,0]).domain([network.output.min.y, network.output.max.y]);
          
          var xaxis = d3.axisBottom().scale(sx).ticks(12);
          var yaxis = d3.axisRight().scale(sy).ticks(12);
          
          g.append("g")
          .attr("class", "output x_axis axes")
          .attr("transform", "translate(0," + (network.osize - network.nsize / 2) + ")")
          .call(xaxis)
          
          g.append("g")
          .attr("class", "output y_axis axes")
          .attr("transform", "translate(" + (network.osize) + "," + (-network.nsize / 2) + ")")
          .call(yaxis)


      }
        
    });
 
  }
    
  function renderFunction(parent_, values_, w_, descrete_ = false){

     var matrix2D = bilinearInterpolation2D(get2Dfrom1D(values_), w_);         
     var out = parent_.createImageData(w_, w_); 
      
     for(var i = 0; i < out.data.length; i += 4){
         
         var x = (i / 4) % w_;
         var y = Math.floor(i / 4 / w_);
         
         var v = remap(matrix2D[x][y], 0, 1, -1, 1);
         if (descrete_) {  v > 0.0 ? v = 1.0 : v = -1.0; }
         
         var color = lerpHexColors(config.colors[1], config.colors[2], v);
         if(v < 0) { color = lerpHexColors(config.colors[1], config.colors[0], Math.abs(v)); }

         if(color == "#") { color = config.colors[1]; }
         var rgb = d3.color(color);
         
         out.data[i] = rgb.r;
         out.data[i + 1] = rgb.g;
         out.data[i + 2] = rgb.b;
         out.data[i + 3] = 255;
         
     }

     return out;
      
  }
    
  function create2DArray(w_){
      
      out = new Array(w_);
      
      for(var i = 0; i < w_; i++){ 
          
          
          out[i] = new Array(w_); 
          for(var j = 0; j < w_; j++){ out[i][j] = 0.0; }
                                 
                                 
      }
      
      return out;
      
  }
    
  function get2Dfrom1D(data_){
      
      var w0 = Math.sqrt(data_.length);
      var out = create2DArray(w0);
      
      for(var i = 0; i < data_.length; i++) { var x = i % w0; var y = Math.floor(i / w0); out[x][y] = data_[i]; };
      
      return out;
      
  }
    
  function get1Dfrom2D(data_){
      
      var out = [data_.length * data_.length]
      
      for (var x = 0; x < data_.length; ++x) {
        for (var y = 0; y < data_[0].length; ++y) {
          
            
        }
      }
      
      return out;
      
  }
    
  function bilinearInterpolation2D(data_, out_){

      var w0 = data_.length;
      var out = create2DArray(out_);
      
      for (var x = 0; x < out_; ++x) {
        for (var y = 0; y < out_; ++y) {
          
            var gx = x / out_ * (w0 - 1);
            var gy =  y / out_ * (w0 - 1);
            var gxi = Math.floor(gx);
            var gyi = Math.floor(gy);

            var c00 = data_[gxi][gyi];
            var c10 = data_[gxi + 1][gyi];
            var c01 = data_[gxi][gyi + 1];
            var c11 = data_[gxi + 1][gyi + 1];
            
            out[x][y] = bilerp(c00, c10, c01, c11, gx - gxi, gy - gyi);
      
        }
      }
      
      return out;
    
  }
    
  function lerpTwoHexColors(hexA_, hexB_, t_){
      
      var ah = parseInt(hexA_.replace(/#/g, ""), 16),
      ar = ah >> 16, ag = ah >> 8 & 0xFF, ab = ah & 0xFF,
      bh = parseInt(hexB_.replace(/#/g, ""), 16),
      br = bh >> 16, bg = bh >> 8 & 0xFF, bb = bh & 0xFF,
      rr = ar + t_ * (br - ar),
      rg = ag + t_ * (bg - ag),
      rb = ab + t_ * (bb - ab);

      return "#" + ((1 << 24) + (rr << 16) + (rg << 8) + rb | 0).toString(16).slice(1);
      
  }
  function dist(x0_, y0_, x1_, y1_){ return Math.sqrt((x1_- x0_) + (y1_ - y0_)); }
    
  function remap(v_, min0_, max0_, min1_, max1_){ return min1_ + (v_ - min0_) / (max0_ - min0_) * (max1_ - min1_); }

  function getPlaceholder(d_, w_, r_, dir_){

      var out = "";
      
      var points = [{x: -w_/2, y: -w_/2, c: "M"}, {x: w_/2, y: -w_/2, c: "M"}, {x: w_/2, y: w_/2, c: "M"}, {x:  -w_/2, y: w_/2, c: "M"}];
     
      var tmp = [], l = r_/ w_, N = points.length;
      
      points.forEach(function(p_, i_){

          var add = [];
          
          var lft = points[(N - 1) -(N - i_)%4],
              rht = points[(i_ + 1)%4];
                            
          add.push({x: lerp(p_.x, lft.x, l), y: lerp(p_.y, lft.y, l), c: "L"});
          add.push({x: p_.x, y: p_.y, c: "S"});
          add.push({x: lerp(p_.x, rht.x, l), y: lerp(p_.y, rht.y, l), c: ""});

          if(i_ == 1 && (dir_ == "LEFT" || dir_ == "BOTH")){
              
              var m = { x: lerp(p_.x, rht.x, 0.5), y: lerp(p_.y, rht.y, 0.5) };
            
              add.push({x: m.x, y: m.y - r_ * 0.75, c: "L"});
              add.push({x: m.x + r_ * 0.75, y: m.y, c: "L"});
              add.push({x: m.x, y: m.y + r_ * 0.75, c: "L"});
              
              d_.out = {x: m.x + r_ * 0.75, y: m.y};
       
          }
          
          if(i_ == N - 1 && (dir_ == "RIGHT" || dir_ == "BOTH")){
              
              var m = { x: lerp(p_.x, rht.x, 0.5), y: lerp(p_.y, rht.y, 0.5) };
            
              add.push({x: m.x, y: m.y - r_ * 0.75, c: "L"});
              add.push({x: m.x - r_ * 0.75, y: m.y, c: "L"});
              add.push({x: m.x, y: m.y + r_ * 0.75, c: "L"});
              
              d_.in = {x: m.x - r_ * 0.75, y: m.y};
       
          }
          
          add.forEach(function(a_){ tmp.push(a_); });
          
          
      });
      
      points = tmp;
      out += "M" + points[0].x + " " + points[0].y;
      
      points.forEach(function(p_, i_){

          if(i_ != 0){
              
              out += " " +  points[i_].c + points[i_].x + " " + points[i_].y
              
          }
          
      })
      
      return out;
      
  }
    
  function getOutPlaceholder(d_, w_, off_, r_){

      var out = "", dir = "RIGHT", off = (w_ - off_) / 2 + off_ * 0.0415;
      
      var points = [{x: 0, y: -w_/2 + off, c: "M"}, {x: w_, y: -w_/2 + off, c: " L"}, {x: w_, y: w_/2 + off - off_ * 0.0415, c: " L"}, {x: 0, y: w_/2 + off - off_ * 0.0415, c: " L"}];
      
      points = [];
      
      points.push({x: 0, y: r_ * 0.75, c: " M"});
      points.push({x: -off_ / 8, y: 0, c: " L"});
      points.push({x: 0, y: -r_ * 0.75, c: " L"});
      
      d_.in = { x : -off_ / 8, y : 0 };
      
      points.forEach(function(p_, i_){

              out += " " + p_.c + p_.x + " " + p_.y
   
      })
      
      return out;
      
  }
    
  function lerp(v0_, v1_, t_){  return v0_ + (v1_ - v0_) * t_;  }
    
  function bilerp(c00_, c10_, c01_, c11_, tx_, ty_) {
      
        return lerp(lerp(c00_, c10_, tx_), lerp(c01_, c11_, tx_), ty_);
      
  }

  return neuron;
    
}

//synapse visualisation
d3.synapse = function() {

    var curve = d3.line().x(function(d_) {
        return d_.x;
    }).y(function(d_) {
        return d_.y;
    }).curve(d3.curveBasis);

    function synapse(selection_) {

        selection_.each(function(d_, i_) {

            var path = curve(setPath(d_));

            var mouseinteractions = d3.select(this).append("path")
                .attr("d", path)
                .attr("class", "sid_" + i_)
                .style("fill", "none")
                .style("stroke", "transparent")
                .style("stroke-width", 8)
                .on("mouseover", function(d_) {

                    d3.selectAll(".sid_" + i_).style("opacity", 0.5);

                    tooltip.transition().duration(50).style("opacity", .9);
                    tooltip.style("left", (d3.event.pageX + 8) + "px").style("top", (d3.event.pageY + 8) + "px");
                    tooltip.select("#tag").html("weight");
                    tooltip.select("#value").html(d_.weight.toFixed(3))

                })
                .on("mouseout", function(d_) {

                    d3.selectAll(".sid_" + i_).style("opacity", 1.0);
                    tooltip.transition().duration(250).style("opacity", 0);

                });

            var visible = d3.select(this)
                .append("path")
                .attr("class", "sid_" + i_)
                .attr("d", path)
                .style("fill", "none")
                .style("stroke-dasharray", "8 2")
                .style("stroke-dashoffset", 0)
                .style("stroke", function(d_) {
                    return d_.weight > 0.0 ? "#79CFD9" : "#F25C05";
                })
                .style("stroke-width", function(d_) {
                    return remapFloat(Math.abs(d_.weight), 0.0, 1.0, 1.0, 3.0);
                });

        });

    }

    function getNeuronByLayerAndIndex(layer_, index_) {

        var index = 0;
        network.layers.forEach(function(d_, i_) {

            if (i_ < Number(layer_) - 1) {
                index += d_.n;
            }

        })

        index += index_;
        return network.neurons[index - 1];

    }

    function setPath(d_) {

        var srcLayer = d_.from_layer,
            trgLayer = d_.from_layer + 1,
            src = getNeuronByLayerAndIndex(srcLayer, d_.source),
            trg = getNeuronByLayerAndIndex(trgLayer, d_.target);

        var median = {
            x: 0,
            y: 0
        };
        median.x = src.x + (trg.x - src.x) / 2;
        median.y = src.y + (trg.y - src.y) / 2;

        var src0 = {
            x: src.x + network.nsize / 2,
            y: src.y
        };
        var src1 = {
            x: src.x + network.nsize,
            y: src.y
        };

        var trg0 = {
            x: trg.x - network.nsize / 2,
            y: trg.y
        };
        var trg1 = {
            x: trg.x - network.nsize,
            y: trg.y
        };

        return [src, src0, src1, median, trg1, trg0, trg];

    }


    return synapse;

}

//input visualisation
d3.lossGraph = function() {

    function lossGraph(selection_) {

        selection_.each(function(d_) {

            var g = d3.select(this)
                .attr("transform", "translate(" + d_.x + "," + d_.y + ")");

            var topLine = g.append("line")
                          .attr("x1", 0)
                          .attr("y1", 0)
                          .attr("x2", d_.w)
                          .attr("y2", 0)
                          .attr("stroke", "#000000")
                          .attr("stroke-width", 2)
            
            var bottomLine = g.append("line")
                          .attr("x1", 0)
                          .attr("y1", d_.h)
                          .attr("x2", d_.w)
                          .attr("y2", d_.h)
                          .attr("stroke", "#000000")
                          .attr("stroke-width", 2)
            
            var mm = getMinMax(d_.data);

            var loss_x = d3.scaleLinear().domain([0, mm.max.x]).range([0, d_.w]);
            var loss_y = d3.scaleLinear().domain([0, 1]).range([4, d_.h - 4]);
            
            var lossLine = d3.line()
            .x(function(d2_, i_) { return loss_x(i_); })
            .y(function(d2_) { return loss_y(d2_.loss); })
            .curve(d3.curveMonotoneX);
            
            var accLine = d3.line()
            .x(function(d2_, i_) { return loss_x(i_); })
            .y(function(d2_) { return loss_y(d2_.acc); })
            .curve(d3.curveMonotoneX);

            g.append("path")
            .data([d_.data])
            .attr("class", "line")
            .attr("d", lossLine)
            .attr("stroke", "#000000")
            .attr("fill", "none");
            
             g.append("path")
            .data([d_.data])
            .attr("class", "line")
            .attr("d", accLine)
            .attr("stroke", "#0E0E0E")
            .attr("fill", "none");

        });

    }
    
    function getMinMax(data_){

        var min = Math.min(data_[0].loss, data_[0].acc);
        var max = Math.max(data_[0].loss, data_[0].acc);
        
        for(var i = 1, l = data_.length; i < l; i++){
            
            min = Math.min(min, data_[i].loss, data_[i].acc);
            max = Math.max(max, data_[i].loss, data_[i].acc);
            
        }
        
        return { min : {x: 0, y: min}, max: { x: data_.length - 1, y: max}};
        
    }

    return lossGraph;

}

d3.lessmore = function() {

    function lessmore(selection_) {

        selection_.each(function(d_, i_) {

            var g = d3.select(this)
                .attr("class", "slider_" + i_)
                .attr("transform", "translate(" + d_.x + "," + (d_.y - Number(grids.getHeightByRows(0, 2)) + 8) + ")");

            g.append("circle")
                .attr("cx", -config.default.lessmore.w)
                .attr("cy", 0)
                .attr("r", config.default.lessmore.w * 0.9)
                .attr("fill", "#EEEEEE")
                .on("mouseover", function(d_) {
                    d3.select(this).attr("fill", "#DCDCDC");
                })
                .on("mouseout", function(d_) {
                    d3.select(this).attr("fill", "#EEEEEE");
                })
                .on("click", function(d_) {
                    console.log("less");
                })

            g.append("text").attr("class", "material-icons").attr("dx", -config.default.lessmore.w).attr("text-anchor", "middle").attr("alignment-baseline", "central").attr("pointer-events", "none").text("remove")

            g.append("circle")
                .attr("cx", config.default.lessmore.w)
                .attr("cy", 0)
                .attr("r", config.default.lessmore.w * 0.9)
                .attr("fill", "#EEEEEE")
                .on("mouseover", function(d_) {
                    d3.select(this).attr("fill", "#DCDCDC");
                })
                .on("mouseout", function(d_) {
                    d3.select(this).attr("fill", "#EEEEEE");
                })
                .on("click", function(d_) {
                    console.log("more");
                })

            g.append("text").attr("class", "material-icons").attr("dx", config.default.lessmore.w).attr("text-anchor", "middle").attr("pointer-events", "none").attr("alignment-baseline", "central").text("add")

            if (d_.n != undefined) {

                g.append("text").attr("class", "lm_caption").attr("dy", config.default.lessmore.w * 2.0).attr("text-anchor", "middle").attr("pointer-events", "none").attr("alignment-baseline", "central").text(d_.n + " neurons")

            }

            if (d_.label != undefined) {

                g.append("text").attr("class", "block_label").attr("dx", getTextWidth(g, config.default.lessmore.w * 1.25, d_.label)).attr("dy", config.default.lessmore.w / 2).attr("text-anchor", "middle").attr("pointer-events", "none").text(d_.label)

                g.attr("transform", "translate(" + (d_.x - getTextWidth(g, 0, d_.label)) + "," + (d_.y - Number(grids.getHeightByRows(0, 2)) + 8) + ")");


            }

        });

    }

    function getTextWidth(g_, w_, text_) {


        g_.append("text").attr("id", "temp").attr("class", "block_label").text(text_);
        var dims = d3.select("#temp").node().getBBox();
        d3.select("#temp").remove();
        return dims.width / 2 + w_ * 2;


    }

    return lessmore;

}

d3.slider = function() {

    var g, background, highlight, drag, w = grids.getWidthByCols(0, 4);

    function slider(selection_) {

        selection_.each(function(d_, i_) {
            
            var g = d3.select(this)
                .attr("class", "slider_" + i_)
                .attr("transform", "translate(" + grids.getXByCol(d_.gx) + "," + (grids.getYByRow(d_.gy) - 2) + ")");

            var background = g.append("rect")
                .attr("class", "background_" + i_)
                .attr("x", 0)
                .attr("y", 0)
                .attr("rx", 2)
                .attr("ry", 2)
                .attr("width", w)
                .attr("height", 4)
                .attr("fill", "#B7B7B7")
                .attr("stroke", "none");

            var highlight = g.append("rect")
                .attr("class", "highlight_" + i_)
                .attr("x", 0)
                .attr("y", 0)
                .attr("rx", 2)
                .attr("ry", 2)
                .attr("width", remapFloat(d_.v, d_.range[0], d_.range[1], 0, w))
                .attr("height", 4)
                .attr("fill", "#193D4D")
                .attr("stroke", "none");

            var drag = g.append("circle")
                .attr("class", "drag_" + i_)
                .attr("id", "in.children." + i_)
                .attr("cx", remapFloat(d_.v, d_.range[0], d_.range[1], 0, w))
                .attr("cy", 2)
                .attr("r", 8)
                .attr("fill", "#193D4D")
                .attr("stroke", "none")
                .call(d3.drag().on("drag", dragEnd));

            var label = g.append("text")
                .attr("class", "block_slider sLabel_" + i_)
                .attr("dy", -10)
                .attr("fill", "#000000")
                .text(d_.l + d_.v);

        });

    }

    function dragEnd() {

        var indx = d3.select(this).attr("class").replace("drag_", "");
        selectedValue = d3.event.x;

        if (selectedValue < 0)
            selectedValue = 0;
        else if (selectedValue > w)
            selectedValue = w;

        d3.select(this).attr("cx", selectedValue);
        d3.select(".highlight_" + indx).attr("width", selectedValue);

        var range = []
        d3.select(this).attr("id", function(d_, i_){ range = d_.range; })
        
        var dv = remapFloat(selectedValue, 0, w, range[0], range[1])
                             
        d3.select(".sLabel_" + indx).text(function(d2_){ return d2_.l + dv.toFixed(d2_.decimal); })
        
        config.sliders[indx].v = dv;
        
        d3.event.sourceEvent.stopPropagation();

    }

    return slider;

}

d3.confusion = function() {
    
    function confusion(selection_) {
    
         selection_.each(function(d_) {

            var g = d3.select(this).attr("transform", "translate(" + d_.x + "," + d_.y + ")");

            g.append("rect").attr("width", d_.w).attr("height", d_.h).attr("fill", "#FFFFFF");
             
            var blockWidth = (d_.w - d_.offset * 2) / d_.matrix[0].length;
            var blockHeight = (d_.h - d_.offset * 2) / d_.matrix.length;

            var row = g.selectAll(".confusionRow")
            .data(d_.matrix)
            .enter().append("g")
            .attr("transform", function(d2_, j_){ return "translate(" + d_.offset + "," + (d_.offset + j_ * blockHeight) + ")"; })
            .attr("class", "confusionRow");

            var column = row.selectAll(".confusionBlock")
            .data(function(d2_) { return d2_; })
            .enter().append("rect")
            .attr("class","confusionBlock")
            .attr("x", function(d2_, i_) { return i_ * blockWidth; })
            .attr("width", blockWidth )
            .attr("height", blockHeight )
            .style("fill", function(d2_){ return lerpHexColors(config.colors[1], config.colors[2], d2_ / 100.0); })
            .style("stroke", function(d2_){ return lerpHexColors(config.colors[1], config.colors[2], d2_ / 100.0); });

            var ctext = row.selectAll(".confusionLabel")
            .data(function(d_, j_) { return d_; })
            .enter().append("text")
            .attr("class",".confusionLabel")
            .attr("alignment-baseline", "central")
            .attr("text-anchor", "middle")
            .attr("x", function(d2_, i_) { return i_ * blockWidth + blockWidth * 0.5; })
            .attr("y", blockHeight * 0.5)
            .style("fill", function(d2_){ if(d2_ > 50.0) { return "#FFFFFF"; }})
            .text(function(d2_){ return Math.floor(d2_); })
             
            var title = g.append("text")
            .attr("alignment-baseline", "central")
            .attr("text-anchor", "middle")
            .attr("x", d_.w / 2 )
            .attr("y", d_.offset * 0.5)
            .text("Confusion Matrix")

            var suntitle = g.append("text")
            .attr("alignment-baseline", "central")
            .attr("text-anchor", "middle")
            .attr("x", d_.w / 2 )
            .attr("y", d_.h - d_.offset * 0.5)
            .text("Predicted Label")
            
            var titleY = g.append("text")
            .attr("transform", "translate(" + d_.offset * 0.5 + "," + (d_.h / 2) + ")rotate(-90)")
            .attr("alignment-baseline", "central")
            .attr("text-anchor", "middle")
            .text("True Label")
            
            var cm_x = d3.scaleLinear().domain([-1, 1]).range([d_.offset, d_.offset + d_.w - d_.offset * 2]);

            var cm_y = d3.scaleLinear().domain([-1, 1]).range([d_.offset, d_.offset + d_.h - d_.offset * 2]);

            var xAxis = d3.axisBottom(cm_x).ticks(2);

            g.append("g")
            .attr("transform", "translate(0," + (d_.h - d_.offset) + ")")
            .call(xAxis);

            var yAxis = d3.axisLeft(cm_y).ticks(2); 
            g.append("g")
            .attr("transform", "translate(" + d_.offset + ",0)")
            .call(yAxis);
             
            //gradient legend
            var cm_grad = d3.scaleLinear().domain([100.0, 0.0]).range([d_.offset, d_.offset + d_.h - d_.offset * 2]);
             
            var gradAxis = d3.axisRight(cm_grad).ticks(5); 
            g.append("g")
            .attr("transform", "translate(" + (d_.w - d_.offset * 0.85 + blockWidth * 0.25) + ",0)")
            .call(gradAxis);

            var cmGradient = svg.append("defs")
            .append("linearGradient")
            .attr("gradientTransform", "rotate(90)")
            .attr("id", "cm-gradient");

            cmGradient.append("stop")
            .attr("offset", "0%")
            .attr("stop-color", config.colors[2]);

            cmGradient.append("stop")
            .attr("offset", "100%")
            .attr("stop-color", config.colors[1]);

            var cm_gradient = g.append("rect")
            .attr("transform", "translate(" + (d_.w - d_.offset * 0.85) + "," + d_.offset + ")")
            .attr("width", blockWidth * 0.25)
            .attr("height", d_.h - d_.offset * 2)
            .style("fill", "url(#cm-gradient)")
             
         });
          
    }
    
    return confusion;
    
}

d3.json("config.json", function(error_, config_) {

    if (error_) throw error_;
    config = config_;

    d3.json("data/streamed_data_epoch-" + player.iter + ".json", function(error_, data_) {
        
        network.loss = data_.loss;
        network.accuracy = data_.acc;
        network.vloss = data_.val_loss;
        network.vaccuracy = data_.val_acc;
        
        parseNetworkData(data_);
        inits();
        
    });

});

function inits(){
    
    console.log("%cneural network playground", "color: #494949; font-size: 18px; font-family: sans-serif;");
    console.log("%cby Vladimir V KUCHINOV", "color: #494949; font-size: 12px; font-style: italic;font-family: sans-serif;");
    
    //by now from config.json, have to be from JSON coming from Keras server
    //with the same structure and syntax
    config.top.forEach(function(d_) {

        var div = document.createElement("div");
        div.className = "control ui-" + d_.id;
        div.id = d_.id;

        var div2 = document.createElement("div");
        div2.className = "select";

        var label = document.createElement("label");
        label.htmlFor = d_.id;
        label.innerHTML = d_.label;
        div.appendChild(label);

        var select = document.createElement("select");
        select.id = d_.id

        d_.options.forEach(function(o_) {

            var option = document.createElement("option");
            option.value = o_.o;
            option.text = o_.l;
            select.appendChild(option);

        })

        select.selectedIndex = d_.default;
        network.parameters[d_.id] = d_.options[d_.default].o;

        div2.appendChild(select);
        div.appendChild(div2);

        document.getElementById("top-ui").appendChild(div)

    });
    
    var dims = "" + 0 + " " + 0 + " " + (config.w + config.margin.l + config.margin.r) + " " + config.h + (config.margin.t + config.margin.b);

    svg = d3.select("#" + config.parentDiv).append("svg")
        .attr("id", "nn", true)
        .attr("preserveAspectRatio", "xMinYMin meet")
        .attr("viewBox", dims)
        .classed("svg-content", true);
    
    defs = svg.append("svg:defs");

    //tooltip
    tooltip = d3.select("#tooltip");
    tooltip.moveToFront();

    //init grids
    grids = new Grids(svg, 32, 16, 0);
    grids.show();

    //taken from config.labels & config.hints
    //x, y have grids units
    drawBlockLabels();
    drawBlockHints(); 
    
    //draw sliders using data from config.json
    //to get current value call getSliderValue(name_);
    //x, y, w, h have grids units
    drawUISliders(); 

    //x, y, w, h have grids units
    rebuildAndDrawNetwork(32, 224, 3, 3, 25, 12);

    //simple point-based input with white background
    //drawInputPointsData(0, 3, 4);
    
    //it's a mockup, have to be taken from JSON coming
    //from Keras server, network.input.values as float array
    drawInputPatternData(0, 3, 4, network.input.values);
    
    //confusion matrix
    //it's a mockup, have to be taken from JSON coming
    //from Keras server, network.matrix as two-dimensional float array
    drawConfusionMatrix(network.matrix, 24, 11, 7, 5, 48);
    
    //update output loss/accuracy values
    document.getElementById("loss").innerHTML = document.getElementById("loss").innerHTML.replace("{loss}", network.loss.toFixed(3)).replace("{accuracy}", network.accuracy.toFixed(3))
    document.getElementById("vloss").innerHTML = document.getElementById("vloss").innerHTML.replace("{vloss}", network.vloss.toFixed(3)).replace("{vaccuracy}", network.vaccuracy.toFixed(3));
    
}

function rebuildAndDrawNetwork(nsize_, osize_, gx_, gy_, gw_, gh_) {

    var params = { nsize: nsize_, osize : osize_, x: grids.getXByCol(gx_), y: grids.getYByRow(gy_), w: grids.getWidthByCols(0, gw_), h: grids.getHeightByRows(0, gh_) };

    network.nsize = params.nsize;
    network.osize = params.osize;

    var net = {};
    
    network.neurons.forEach(function(d_) {

        if (d_.layer in net) {
            net[d_.layer] += 1;
        } else {
            net[d_.layer] = 1;
        }
        d_["lidx"] = net[d_.layer];

    });

    network.layers = []
    Object.keys(net).forEach(function(k_) {
        
        network.layers.push({
            i: k_,
            n: net[k_]
            
        });
    })

    var largestLayerSize = Math.max.apply(null, Object.keys(net).map(function(i_) { return net[i_]; }));

    var xdist = params.w / Object.keys(net).length,
        ydist = params.h / largestLayerSize;

    network.neurons.map(function(d_) {

        d_.values.forEach(function(v_) {

            //config.minmax.min = Math.min(config.minmax.min, Number(v_));
            //config.minmax.max = Math.max(config.minmax.max, Number(v_));

        })

        if (d_.lidx == 1) {
            getObjectByKey(network.layers, "i", d_.layer).x = params.x + (d_.layer - 0.5) * xdist;
            getObjectByKey(network.layers, "i", d_.layer).y = params.y + (d_.lidx - 0.75) * ydist
        }
        d_["x"] = params.x + (d_.layer - 0.5) * xdist;
        d_["y"] = params.y + (d_.lidx - 0.75) * ydist;

        if (d_.id == "out") {
            d_["x"] = params.w;
        }

    });

    network.neurons.filter(function(d_) { return typeof d_ !== "undefined"; });
    
    drawNetwork();
    drawOutputLegend(26, 9, 160, 16);
    
}

function drawOutputLegend(gx_, gy_, w_, h_){

    var lgradient = svg.append("defs")
        .append("linearGradient")
        .attr("id", "lgradient");

    lgradient.append("stop")
        .attr("offset", "0%")
        .attr("stop-color", config.colors[0])
        .attr("stop-opacity", 1);

    lgradient.append("stop")
        .attr("offset", "33%")
        .attr("stop-color", lerpHexColors(config.colors[0], config.colors[1], 0.5))
        .attr("stop-opacity", 1);

    lgradient.append("stop")
        .attr("offset", "50%")
        .attr("stop-color", config.colors[1])
        .attr("stop-opacity", 1);

    lgradient.append("stop")
        .attr("offset", "66%")
        .attr("stop-color", lerpHexColors(config.colors[1], config.colors[2], 0.5) )
        .attr("stop-opacity", 1);

    lgradient.append("stop")
        .attr("offset", "100%")
        .attr("stop-color", config.colors[2])
        .attr("stop-opacity", 1);

    var ldescrete = svg.append("defs")
            .append("linearGradient")
            .attr("id", "ldescrete");

    ldescrete.append("stop")
        .attr("offset", "0%")
        .attr("stop-color", config.colors[0])
        .attr("stop-opacity", 1);

    ldescrete.append("stop")
        .attr("offset", "50%")
        .attr("stop-color", config.colors[0])
        .attr("stop-opacity", 1);

    ldescrete.append("stop")
        .attr("offset", "50%")
        .attr("stop-color", config.colors[2])
        .attr("stop-opacity", 1);

   var legend = svg.append("rect")
               .attr("x", grids.getXByCol(gx_))
               .attr("y", grids.getYByRow(gy_))
               .attr("width", w_)
               .attr("height", h_)
               .attr("fill", "url(#lgradient)")
               .attr("stroke", "none")
                .on("click", function(d_){

                network.parameters.descrete ^= true;

                    if(network.parameters.descrete){

                        d3.select(this).attr("fill", "url(#ldescrete)");
                        neurons.attr("id", function(d_, i_) { 

                            if(d_.id != "out"){

                                d3.select(this).select(".neuronPattern").attr("fill", "url(#descrete_" + i_ + ")")

                            }else{

                                d3.select(this).select(".outputPattern").attr("fill", "url(#outdescrete)")

                            }

                        });

                    }
                    else{

                        d3.select(this).attr("fill", "url(#lgradient)");
                        neurons.attr("id", function(d_, i_) { 

                            if(d_.id != "out"){

                                d3.select(this).select(".neuronPattern").attr("fill", "url(#pattern_" + i_ + ")")

                            }else{

                                d3.select(this).select(".outputPattern").attr("fill", "url(#outgradient)")

                            }

                        });

                    }

                });

  var lx = d3.scaleLinear().range([ grids.getXByCol(gx_),  grids.getXByCol(gx_) - w_]).domain([-1.0, 1.0]);

  var laxis = d3.axisBottom().scale(lx).ticks(3);

  svg.append("g")
  .attr("class", "output l_axis axes")
  .attr("transform", "translate(" + w_ + "," + (grids.getYByRow(gy_) + h_) + ")")
  .call(laxis)
    
}

function setFromTo(d_) {

    from = network.neurons[d_.source].id;
    to = network.neurons[d_.target].id;
    return "from_" + from + " to_" + to;

}

function drawConfusionMatrix(matrix_, gx_, gy_, gw_, gh_, offset_){
    
     var confusionMatrix = svg.selectAll(".confusionMatrix")
     .data([{ matrix : matrix_, x: grids.getXByCol(gx_), y: grids.getYByRow(gy_), w: grids.getWidthByCols(0, gw_), h: grids.getHeightByRows(0, gh_), offset : offset_ }])
    .enter().append("g")
    .attr("id", "confusionMatrix")
    .call(d3.confusion());
    
}
function drawNetwork(){
    
    var everyHiddenUI = svg.selectAll(".neuron")
    .data(getHiddenLayers())
    .enter().append("g")
    .attr("transform", function(d_) {
    d_.y += config.default.lessmore.w * 0.75;
    return "translate(" + d_.x + "," + d_.y + ")";
    })
    .call(d3.lessmore());
    
    neurons = svg.selectAll(".neuron")
    .data(network.neurons)
    .enter().append("g")
    .attr("class", function(d_) { return "neuron " + "nid_" + d_.id; })
    .attr("transform", function(d_, i_) {
        
        if(i_ == 0) { config.offsetY = d_.y; }
        return "translate(" + d_.x + "," + d_.y + ")";
        
    })
    .call(d3.neuron());
    
    synapses = svg.selectAll(".synapse")
    .data(network.synapses)
    .enter().append("g")
    .attr("class", function(d_) { return "synapse " + setFromTo(d_); })
    .call(d3.synapse())

    d3.selectAll(".synapse").moveToBack();
    
    var params = getHiddenLayersMedian();
    var hiddenUI = svg.append("g").attr("transform", "translate(" + params.median + ", " + Number(grids.getYByRow(1)) + ")");

    hiddenUI.append("path")
    .attr("d", lineToBracePath(params))
    .attr("fill", "none")
    .attr("stroke", "#B7B7B7");

    hiddenUI.append("g")
    .data([{
        
            x: 0,
            y: 40,
            label: setHiddenLabel()
            
    }])
    .attr("transform", function(d_) { return "translate(" + d_.x + "," + d_.y + ")"; })
    .call(d3.lessmore());
    
    //by now there are two params: loss & accuracy
    //no vloss, no vaccuracy
    drawLossGraph(network.testloss, 28, 1, 3, 1);
    
}

function getSliderValueByID(id_){

    var obj =  config.sliders.find(function(v_){ return v_["id"] === id_});
    return obj.v;
    
}

function filterValue(obj_, key_, value_) {
  return obj_.find(function(v_){ return v_[key_] === value_});
}

function drawLossGraph(data_, gx_, gy_, gw_, gh_){
    
     var lossGraph = svg.selectAll(".lossGraph")
     .data([{ data : data_, x: grids.getXByCol(gx_), y: grids.getYByRow(gy_), w: grids.getWidthByCols(0, gw_), h: grids.getHeightByRows(0, gh_) }])
    .enter().append("g")
    .attr("id", "lossGraph")
    .call(d3.lossGraph());
    
}

function drawInputPointsData(gx_, gy_, gw_){
    
    var inData = svg.selectAll(".inputPointsData")
    .data([{ x: grids.getXByCol(gx_), y: grids.getYByRow(gy_), w: grids.getWidthByCols(0, gw_), h: grids.getWidthByCols(0, gw_) }])
    .enter().append("g")
    .attr("id", "inputPointsData")
    .call(d3.inputPointsData());
    
}

function drawInputPatternData(gx_, gy_, gw_, values_){
    
    var inData = svg.selectAll(".inputPatternData")
    .data([{ x: grids.getXByCol(gx_), y: grids.getYByRow(gy_), w: grids.getWidthByCols(0, gw_), h: grids.getWidthByCols(0, gw_), values: values_ }])
    .enter().append("g")
    .attr("id", "inputPatternData")
    .call(d3.inputPatternData());
    
}

function drawUISliders(){
    
    var sliders = svg.selectAll(".slider")
    .data(config.sliders)
    .enter().append("g")
    .call(d3.slider());
    
}

function drawBlockLabels(){
    
    var labels = svg.selectAll(".labels")
    .data(config.labels)
    .enter().append("text")
    .attr("class", "block_label")
    .attr("alignment-baseline", "hanging")
    .attr("dx", function(d_, i_) { return grids.getXByCol(d_.gx); })
    .attr("dy", function(d_, i_) { return grids.getYByRow(d_.gy); })
    .text(function(d_) { return d_.l; })
        
}

function drawBlockHints(){
    
    var hints = svg.selectAll(".hints")
    .data(config.hints)
    .enter().append("text")
    .attr("class", "block_hint")
    .attr("id", function(d_){ return(d_.id); })
    .html(function(d_) {
    return multiline(d_.l, Number(grids.getXByCol(d_.gx)), 10 + Number(grids.getYByRow(d_.gy)), 16);
    })
       
}

function setHiddenLabel() {

    var n = network.layers.length - 2;
    return n < 2 ? "1 HIDDEN LAYER" : n + " HIDDEN LAYERS";

}

function getHiddenLayers() {

    out = [];

    network.layers.forEach(function(d_) {

        if (d_.i != 1 && d_.i != network.layers.length) {

            out.push(d_);
        }

    })

    return out;

}

function getHiddenLayersMedian() {

    var mm = {
        min: Number.POSITIVE_INFINITY,
        max: Number.NEGATIVE_INFINITY
    };
    var hidden = getHiddenLayers();


    hidden.forEach(function(d_) {

        mm.min = Math.min(mm.min, d_.x);
        mm.max = Math.max(mm.max, d_.x);

    })

    var median = lerpMinMax(mm, 0.5)
    var delta = lerpMinMax(mm, 0.5) - lerpMinMax(mm, 0.75) * 1.25;
    return {
        l: -delta,
        median: median,
        r: delta
    };

}

function lineToBracePath(p_) {

    out = "";

    out += "M" + p_.l + " " + 8;
    out += " L" + p_.l + " " + 0;
    out += " L" + p_.r + " " + 0;
    out += " L" + p_.r + " " + 8;

    return out;

}

function parseNetworkData(data_){
    
    data_.activations.data.forEach(function(d_){
        
        d_.layer++;
        if(d_.layer == 1) { d_.id = "in_" + d_.node; } else { d_.id = "h_" + d_.layer + "_" + d_.node; }
        d_.node++;
        network.neurons.push(d_);

    });

    network.neurons[network.neurons.length - 1].id = "out";
    var outIndex = network.neurons[network.neurons.length - 1].layer;

    data_.weights.forEach(function(d_){ 
        
        if(d_.source != -1) { 

            d_.from_layer++;
            if(d_.from_layer < outIndex){ 

            d_.source++;
            d_.target++;

            if(d_.from_layer == outIndex - 1) { if(d_.target == 1) { network.synapses.push(d_); }}
            else { network.synapses.push(d_); }

            }

        } 
    
    });

    network.input.points = [];
    network.input.min = {x: Number.POSITIVE_INFINITY, y: Number.POSITIVE_INFINITY};
    network.input.max = {x: Number.NEGATIVE_INFINITY, y: Number.NEGATIVE_INFINITY};

    data_.activations.x_axis.forEach(function(d_, i_){

    network.input.points.push({x: d_, y: data_.activations.y_axis[i_]});
    network.input.min.x = Math.min(network.input.min.x, d_);
    network.input.max.x = Math.max(network.input.max.x, d_);
    network.input.min.y = Math.min(network.input.min.y, data_.activations.y_axis[i_]);
    network.input.max.y = Math.max(network.input.max.y, data_.activations.y_axis[i_]);

    })
    
    expandArea();
    
}

function expandArea(){
    
    var dx = network.input.max.x - network.input.min.x;
    var dy = network.input.max.y - network.input.min.y;
    
    var deltaX = dx * 0.2;
    var deltaY = dy * 0.2;
    
    network.input.min.x -= deltaX;
    network.input.max.x += deltaX;
    
    network.input.min.y -= deltaY;
    network.input.max.y += deltaY;
      
}

function multiline(text_, dx_, dy_, line_) {

    var lines = text_.split("|"),
        out = "",
        ypos = [dy_],
        x = 0;
    lines.forEach(function(d_) {
        ypos.push(ypos[ypos.length - 1] + line_);
    })

    for (var i = 0; i < lines.length; i++) {

        var y = 0;
        out += "<tspan x=\"" + dx_ + "\" y=\"" + ypos[i] + "\">" + lines[i] + "</tspan>";

    }

    return out;

}

function getObjectByKey(array_, key_, value_) {

    var found = null
    array_.forEach(function(d_) {

        if (Number(d_[key_]) == Number(value_)) {
            found = d_;
        }

    })

    return found;

}

function getChildrenByType(children_, type_) {

    out = [];

    children_.forEach(function(d_) {

        if (type_ == d_.type) {
            out.push(d_);
        }

    });

    return out;

}

function lerpHexColors(a_, b_, t_) {

    var ah = +a_.replace("#", "0x"),
        ar = ah >> 16,
        ag = ah >> 8 & 0xff,
        ab = ah & 0xff,
        bh = +b_.replace("#", "0x"),
        br = bh >> 16,
        bg = bh >> 8 & 0xff,
        bb = bh & 0xff,
        rr = ar + t_ * (br - ar),
        rg = ag + t_ * (bg - ag),
        rb = ab + t_ * (bb - ab);

    return "#" + ((1 << 24) + (rr << 16) + (rg << 8) + rb | 0).toString(16).slice(1);

}

function lerpMinMax(v_, t_) {
    return v_.min + (v_.max - v_.min) * t_;
}

function remapFloat(v_, min0_, max0_, min1_, max1_) {

    return min1_ + (v_ - min0_) / (max0_ - min0_) * (max1_ - min1_);

}

//D3.JS moveToFront() & moveToBack() methods
d3.selection.prototype.moveToFront = function() {

    return this.each(function() {
        this.parentNode.appendChild(this);
    });

};
d3.selection.prototype.moveToBack = function() {

    return this.each(function() {
        var firstChild = this.parentNode.firstChild;
        if (firstChild) {
            this.parentNode.insertBefore(this, firstChild);
        }
    });

};