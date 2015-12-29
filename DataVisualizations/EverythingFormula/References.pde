/**
 * "TupperPlot in JavaScript"
 * Renders the Tupper function (or other functions if you want) onto a DHTML grid.
 * Main reference: http://mathworld.wolfram.com/TuppersSelf-ReferentialFormula.html
 * 
 * Copyright Notice
 * -----------------
 * "TupperPlot in JavaScript" by Andrew McRae is licensed under a Creative Commons Attribution-ShareAlike 2.5 Australia License.
 *  License summary: http://creativecommons.org/licenses/by-sa/2.5/au/
 * Please note that the BigInt.js library was written by someone else and is not covered by this license.
 *
 * Revision History
 * -------------------
 * v1.0  2007-01-21  Andrew McRae <ajmcrae.SPAMCONTRAIRE@NONSPAM.gmail.com>
 *      First version.
 *       And they said it could never be done in JavaScript. :-D
 * v1.1  2007-01-25  Andrew McRae <ajmcrae.SPAMCONTRAIRE@NONSPAM.gmail.com>
 *      Minor performance tweak.
 *      First public CC release.
 *
 * (add remix comments here)
 */

/*

 var BSIZE = 230;
 
 var k0  = int2bigInt(0,16,0);
 var k1  = int2bigInt(1,16,0);
 var k2  = int2bigInt(2,16,0);
 var k4  = mult(k2,k2);
 var k17 = int2bigInt(17,16,0);
 var k_17  = sub(k0,k17);
 
 var kTupper = str2bigInt(
 "960939379918958884971672962127852754715004339660129306651505519271702802395266"+ 
 "424689642842174350718121267153782770623355993237280874144307891325963941337723"+ 
 "487857735749823926629715517173716995165232890538221612403238855866184013235585"+ 
 "136048828693337902491454229288667081096184496091705183454067827731551705405381"+
 "627380967602565625016981482083418783163849115590225610003652351370343874461848"+
 "378737238198224849863465033159410054974700593138339226497249461751545728366702"+
 "369745461014655997933798537483143786841806593422227898388722980000748404719",
 10,BSIZE,0
 );
 
 
/* Requires bigInt objects as parameters. 
 
 The function had to be rearranged to cope with the limitations of the BigInt library that I used.
 For example, negative exponentiation wasn't supported directly, and even negative numbers of any kind could not be used!
 Maybe it's my lack of understanding of BigInt.js, but when simply calling add(add(sub(0,17),2),17) does NOT yield 2 then it's a buggy library.
 */
 
//var Tupper = function(x, y) {
//  // floor(y/17)  <br/>
//  var v = dup(y);
//  divInt_(v, 17);
//
//  //negative exponent of 2, rewritten as a bitwise right shift.  <br/>
//  var e = mult(x, k17);
//  add_(e, mod(y, k17));
//
//  var sh = parseInt(bigInt2str(e, 10));
//  if (sh>0) {
//    rightShift_(v, sh-1);
//    //final modulo to recover pixel bit.  <br/>
//    mod_(v, k4);
//    return greater(v, k1);
//  } else {
//    //final modulo to recover pixel bit.  <br/>
//    mod_(v, k2);
//    return greater(v, k0);
//  }
//};
//
//
////create a grid of span tags so their background colours can be altered by the function output.
//var drawPlotArea = function(width, height, flipXAxis, flipYAxis) {
//  var H = '<p>';
//  var y0 = flipYAxis ? 0 : height-1;
//  var yL = flipYAxis ? height : -1;
//  for (var y=y0; y!=yL; y>yL?y--:y++) {
//    var x0 = flipXAxis ? width-1 : 0;
//    var xL = flipXAxis ? -1 : width;
//    for (var x=x0; x!=xL; x<xL?x++:x--) {
//      H += '<span class="pixel" id="px'+x+'y'+y+'">+</span>';
//    }
//    H += '<br>';
//  }
//  H+='</p>';
//  $('plotArea').innerHTML = H;
//
//  /*
//  $('log').innerHTML += '  k17:'+bigInt2str(k17,10);
//   $('log').innerHTML += '  0-17+2+17='+bigInt2str(add(add(sub(k0,k17),k2),k17), 10);
//   $('log').innerHTML += '\n  17-2='+bigInt2str(sub(k17,k2), 10);
//   $('log').innerHTML += '\n  17**-1 mod 4 ='+bigInt2str(inverseMod(k17,k4), 10);
//   var kld = int2bigInt(19,8,0);
//   rightShift_(kld,2);
//   $('log').innerHTML += '\n  19>>2='+bigInt2str(kld, 10);
//   */
//
//  var elem = $('px'+0+'y'+0);
//  if (elem!=null) elem.style.backgroundColor = 'green';
//};
//
//
//
//
//renderState = {
//f:
//  null, 
//colourant:
//  null, 
//xMin:
//  null, 
//yMin:
//  null, 
//width:
//  0, 
//height:
//  0, 
//ix:
//  0, 
//iy:
//  0, 
//clocker:
//  0, 
//quantumMS:
//  03, 
//sliceLimit:
//  30      // HEY! change this down to 10 or 1 if your computer is too slow.
//};
//
//function renderTimeSlice() {
//  for (var py=renderState.iy; py<renderState.height; py++) {
//    var y = addInt(renderState.yMin, py);
//    for (var px=renderState.ix; px<renderState.width; ) {
//      var x = addInt(renderState.xMin, px);
//      var r = renderState.f(x, y);
//      var c = renderState.colourant(r);
//      /*
//        $('log').innerHTML = 
//       'X:'+bigInt2str(x,10)+'\n'
//       +'Y:'+bigInt2str(y,10)+'\n'
//       +'R:'+bigInt2str(r,10);
//       */
//      var elem = $('px'+px+'y'+py);
//      if (elem!=null) elem.style.backgroundColor = c;
//      ++px;
//
//      //timeslicing.
//      if (++(renderState.clocker) >= renderState.sliceLimit) {
//        renderState.clocker=0;
//        renderState.ix = px;
//        renderState.iy = py;
//        renderState.timer = setTimeout("renderTimeSlice();", renderState.quantumMS);
//        return;
//      }
//    }
//    renderState.ix=0;
//  }
//}
//
//
//var render2DFunction = function( f, xMin, xMax, yMin, yMax, colourant) {
//  renderState.width = parseInt(bigInt2str( sub(xMax, xMin), 10)) + 1;
//  renderState.height= parseInt(bigInt2str( sub(yMax, yMin), 10)) + 1;
//  renderState.xMin = xMin;
//  renderState.yMin = yMin;
//  renderState.ix=0;
//  renderState.iy=0;
//  renderState.f = f;
//  renderState.colourant = colourant;
//  $('log').value += '\nPlot ranges:\n';
//  $('log').value += 'X:[ '+bigInt2str(xMin, 10)+ ', '+bigInt2str(xMax, 10)+']\n';
//  $('log').value += 'Y:[ '+bigInt2str(yMin, 10)+ ', '+bigInt2str(yMax, 10)+']\n';
//  renderTimeSlice();
//};
//
//
//
//function testGraphRender() {
//  drawPlotArea(10, 10);
//  var f = function(x, y) { 
//    return modInt(x, 2)+modInt(y, 3);
//  };
//  var c = function(v) { 
//    return v==1?'blue' : (v==2?'green' : (v==3?'red': 'white') )
//  };
//  render2DFunction( 
//  f, 
//  str2bigInt('0', 10, BSIZE, 0), str2bigInt('9', 10, BSIZE, 0), 
//  str2bigInt('0', 10, BSIZE, 0), str2bigInt('9', 10, BSIZE, 0), 
//  c
//    );
//  //$('fdesc').innerHTML += f.toString();
//  $('log').innerHTML += f.toString();
//}
//
//
//function drawTupper() {
//  //$('fdesc').innerHTML += Tupper.toString();
//  $('log').value += Tupper.toString();
//  var c = function(v) { 
//    return v ? 'black' : 'white';
//  };
//  render2DFunction( 
//  Tupper, 
//  str2bigInt('0', 10, BSIZE, 0), str2bigInt('105', 10, BSIZE, 0), 
//  kTupper, addInt(kTupper, 16), 
//  c
//    );
//}


