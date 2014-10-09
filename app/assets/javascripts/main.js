/* D3 Tree */
/* Copyright 2013 Peter Cook (@prcweb); Licensed MIT */

$(document).ready(function() {
  
  // Tree configuration
  var branches = [];
  // var seed = {i: 0, x: 420, y: 600, a: 0, l: 130, d:0}; // a = angle, l = length, d = depth
  // a = angle sets the angle of the "trunk"
  // l = length is a better way of making a shorter tree **log10(loc)?**
  // d = depth higher values seems to make the whole tree "thinner"
  // maxDepth determines when the tree stops growing AND the width of the lines
  // maxDepth is compared against d which increments after each "growth"
  var angleDelta = 0.5; // Angle delta EDIT, the smaller the value, the narrower the tree
  var lengthDelta = 0.8; // Length delta (factor) EDIT VERY SENSITIVE. The smaller the number to "stubbier" the braches. This is applied after each growth and sets the rate at which branch length decreases.
  var angleRandomness = 0.7; // Randomness EDIT (factor) 
  var maxDepth = 10; // EDIT This is how you set the tree "maturity". 10 works, 12 is slow. **log2(commits).round?**

  // Build list of trees and bind data
  var stats = new Array();

  $(".attribute-holder").each(function (i) {
          stats[i]=$(this).attr("id");
  });

  var trees = d3.selectAll('.chart').data(stats);

  trees.on('mouseover', regenerate );

  // Draw trees on load 
  var loadTrees = function(trees){

    trees.each(function (d) {

      regenerate(d);

    });
  };

  loadTrees(trees)

  // Tree creation functions
  function branch(b) {
    var end = endPt(b), randomAngleDelta, newB;

    branches.push(b);

    if (b.d === maxDepth)
      return;

    // Left branch
    randomAngleDelta = angleRandomness * Math.random() - angleRandomness * 0.5; // Math.random() returns a value from 0 to 1.
    // Perhaps we can substitute values from the commit to make trees distinct

    var sideBranchDelta = 1;

    if (b.t == "pine") {
      sideBranchDelta = 0.6
    };

    newB = {
      i: branches.length,
      x: end.x,
      y: end.y,
      a: b.a - angleDelta + randomAngleDelta,
      l: b.l * lengthDelta * sideBranchDelta,
      d: b.d + 1,
      g: b.g,
      t: b.t,
      parent: b.i
    };
    branch(newB);

    if (b.t == "pine" || ( b.t == "oak" && b.g > 1.0 && b.i < 2 ) ) {
      // Center
      randomAngleDelta = angleRandomness * Math.random() - angleRandomness * 0.5; // Math.random() returns a value from 0 to 1.
      // Perhaps we can substitute values from the commit to make trees distinct
      newB = {
        i: branches.length,
        x: end.x,
        y: end.y,
        a: b.a + randomAngleDelta * 0.1,
        l: b.l * lengthDelta,
        d: b.d + 1,
        g: b.g,
        t: b.t,
        parent: b.i
      };
      branch(newB);
    }

    // Right branch
    randomAngleDelta = angleRandomness * Math.random() - angleRandomness * 0.5;
    newB = {
      i: branches.length,
      x: end.x, 
      y: end.y, 
      a: b.a + angleDelta + randomAngleDelta, 
      l: b.l * lengthDelta * sideBranchDelta, // Include Math.random() here for scary tree. Include randomAngleDelta to warp sizes.
      d: b.d + 1,
      g: b.g,
      t: b.t,
      parent: b.i
    };
    branch(newB);
  }

  function regenerate(d) {
  
    // Extract seed parameters from element attributes
    var depth = $("div." + d).attr("age");
    var length = $("div." + d).attr("length");
    var gnarl = $("div." + d).attr("gnarling");
    var name = $("div." + d).attr("id");
    var type = $("div." + d).attr("type");
    var initialise = $("div." + d).attr("initialise");


    branches = [];
    var seed = {i: 0, x: 420, y: 600, a: 0, l: length, d: (10 - depth), g: gnarl, t: type}; // a = angle, l = length, d = depths, g = gnarl
    branch(seed);

    if (initialise == "true") { create(name) }

    else { update(name) }

    $("div." + d).attr("initialise", "false");

  }

  function endPt(b) {
    // Return endpoint of branch
    var x = b.x + b.l * Math.sin( b.a );
    var y = b.y - b.l * Math.cos( b.a );
    return {x: x, y: y};
  }


  // D3 functions
  function x1(d) {return d.x;}
  function y1(d) {return d.y;}
  function x2(d) {return endPt(d).x;}
  function y2(d) {return endPt(d).y;}
  function highlightParents(d) {
    var colour = d3.event.type === 'mouseover' ? 'green' : '#777';
    var depth = d.d;
    for(var i = 0; i <= depth; i++) {
      d3.select('#id-'+parseInt(d.i)).style('stroke', colour);
      d = branches[d.parent];
    } 
  }
  function showColor(d) {
    var color = $("div." + d).attr("color");
  }

  function create(name) {
    console.log("Creating")
    d3.select('g.' + name)
      .selectAll('g.' + name + '>line')
      .data(branches)
      .enter()
      .append('line')
      .attr('x1', x1)
      .attr('y1', y1)
      .attr('x2', x2)
      .attr('y2', y2)
      .style('stroke-width', function(d) {return parseInt(maxDepth + 1 - d.d) + 'px';})
      .attr('id', function(d) {return 'id-'+d.i;})
      // .on('mouseover', showColor);
      // .on('mouseover', highlightParents)
      // .on('mouseout', highlightParents);
  }

  function update(name) {
    d3.select('g.' + name)
      .selectAll('g.' + name + '>line')
      .data(branches)
      .transition()
      .attr('x1', x1)
      .attr('y1', y1)
      .attr('x2', x2)
      .attr('y2', y2);
  }

});
